import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:uuid/uuid.dart';

class CreateAccountUseCase {
  const CreateAccountUseCase(
    this._unitOfWork,
    this._accountRepository,
  );

  final IUnitOfWork _unitOfWork;
  final IAccountRepository _accountRepository;

  Future<Result<AccountModel, Failure>> execute({
    required String name,
    required AccountType type,
    required int balance,
    String? icon,
    String? color,
    String? parentId,
    bool isActive = true,
    List<String> restrictedCategoryIds = const [],
  }) async {
    if (name.trim().isEmpty) {
      return const ErrorResult(ValidationFailure('Account name cannot be empty'));
    }
    if (balance < 0) {
      return const ErrorResult(ValidationFailure('Initial balance cannot be negative'));
    }

    try {
      return await _unitOfWork.execute(() async {
        final now = DateTimeUtils.nowUtc();
        final accountId = const Uuid().v7();

        final account = AccountModel(
          id: accountId,
          name: name,
          type: type,
          balance: balance,
          initialBalance: balance,
          icon: icon,
          color: color,
          parentId: parentId,
          isActive: isActive,
          restrictedCategoryIds: restrictedCategoryIds,
          createdAt: now,
          updatedAt: now,
        );

        final createResult = await _accountRepository.createAccount(account);
        if (createResult is ErrorResult<void, Failure>) {
          return ErrorResult(createResult.error);
        }

        return Success(account);
      });
    } on Exception catch (e) {
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }
}
