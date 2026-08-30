import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';

class UpdateAccountUseCase {
  const UpdateAccountUseCase(this._repository);

  final IAccountRepository _repository;

  Future<Result<AccountModel, Failure>> execute({
    required AccountModel account,
    required String name,
    required String? icon,
    required String? color,
    required bool isActive,
    required List<String> restrictedCategoryIds,
  }) async {
    if (name.isEmpty) {
      return const ErrorResult(ValidationFailure('Account name cannot be empty'));
    }

    final updated = account.copyWith(
      name: name,
      icon: icon,
      color: color,
      isActive: isActive,
      restrictedCategoryIds: restrictedCategoryIds,
      updatedAt: DateTimeUtils.nowUtc(),
    );

    final result = await _repository.updateAccount(updated);
    if (result is ErrorResult<void, Failure>) {
      return ErrorResult(result.error);
    }
    return Success(updated);
  }
}
