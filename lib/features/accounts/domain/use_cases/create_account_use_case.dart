import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:uuid/uuid.dart';

/// Use case responsible for validating and creating a new [AccountModel].
///
/// Ensures account invariants (non-empty name, non-negative balance) and encapsulates
/// creation within an [IUnitOfWork] atomic database transaction.
class CreateAccountUseCase {
  /// Creates a [CreateAccountUseCase] with required transactional and repository dependencies.
  const new(this._unitOfWork, this._accountRepository);

  final IUnitOfWork _unitOfWork;
  final IAccountRepository _accountRepository;

  /// Executes account creation with the provided parameters.
  ///
  /// When [parentId] is null, creates the root account and automatically generates
  /// its default main pocket holding the initial balance.
  ///
  /// Returns a [Success] containing the created [AccountModel], or an [ErrorResult]
  /// containing [ValidationFailure] if inputs are invalid or [DatabaseFailure] on storage errors.
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
      // Execute within a database transaction to ensure header and category link atomicity
      return await _unitOfWork.execute(() async {
        final now = DateTimeUtils.nowUtc();
        final accountId = const Uuid().v7();

        if (parentId == null) {
          final rootAccount = AccountModel(
            id: accountId,
            name: name,
            type: type,
            balance: 0,
            icon: icon,
            color: color,
            isActive: isActive,
            restrictedCategoryIds: restrictedCategoryIds,
            createdAt: now,
            updatedAt: now,
          );

          final rootResult = await _accountRepository.createAccount(rootAccount);
          if (rootResult is ErrorResult<void, Failure>) {
            return ErrorResult(rootResult.error);
          }

          final mainPocket = AccountModel(
            id: const Uuid().v7(),
            name: t.accounts.mainPocket,
            type: type,
            balance: balance,
            initialBalance: balance,
            icon: icon,
            color: color,
            parentId: accountId,
            isDefault: true,
            restrictedCategoryIds: restrictedCategoryIds,
            createdAt: now,
            updatedAt: now,
          );

          final pocketResult = await _accountRepository.createAccount(mainPocket);
          if (pocketResult is ErrorResult<void, Failure>) {
            return ErrorResult(pocketResult.error);
          }

          return Success(rootAccount);
        } else {
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
        }
      });
    } on Exception catch (e) {
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }
}
