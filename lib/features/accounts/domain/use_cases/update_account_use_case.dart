import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';

/// Use case responsible for validating and persisting modifications to an existing [AccountModel].
class UpdateAccountUseCase {
  /// Creates an [UpdateAccountUseCase] with the required [IAccountRepository].
  const UpdateAccountUseCase(this._repository);

  final IAccountRepository _repository;

  /// Validates and updates the account properties and category restrictions.
  ///
  /// Returns [Success] with the updated [AccountModel], or an [ErrorResult] on validation or database failure.
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
