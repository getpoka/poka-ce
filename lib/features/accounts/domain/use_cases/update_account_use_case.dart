import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';

/// Use case responsible for validating and persisting modifications to an existing [AccountModel].
class UpdateAccountUseCase {
  /// Creates an [UpdateAccountUseCase] with the required [IAccountRepository] and optional [IUnitOfWork].
  const new(this._repository, [this._unitOfWork]);

  final IAccountRepository _repository;
  final IUnitOfWork? _unitOfWork;

  /// Validates and updates the account properties, category restrictions, and initial balance.
  ///
  /// Returns [Success] with the updated [AccountModel], or an [ErrorResult] on validation or database failure.
  Future<Result<AccountModel, Failure>> execute({
    required AccountModel account,
    required String name,
    required String? icon,
    required String? color,
    required bool isActive,
    required List<String> restrictedCategoryIds,
    int? initialBalance,
  }) async {
    if (name.trim().isEmpty) {
      return const ErrorResult(ValidationFailure('Account name cannot be empty'));
    }
    if (initialBalance != null && initialBalance < 0) {
      return const ErrorResult(ValidationFailure('Initial balance cannot be negative'));
    }

    final now = DateTimeUtils.nowUtc();

    Future<Result<AccountModel, Failure>> updateOperation() async {
      if (!account.isPocket) {
        final accountsRes = await _repository.getAccounts();
        final allAccounts = accountsRes.fold((s) => s, (f) => <AccountModel>[]);
        final mainPocket = allAccounts.where((a) => a.parentId == account.id && a.isDefault).firstOrNull;

        if (mainPocket != null) {
          final newInit = initialBalance ?? mainPocket.initialBalance;
          final delta = newInit - mainPocket.initialBalance;
          final updatedMainPocket = mainPocket.copyWith(
            initialBalance: newInit,
            balance: mainPocket.balance + delta,
            updatedAt: now,
          );
          final pocketRes = await _repository.updateAccount(updatedMainPocket);
          if (pocketRes is ErrorResult<void, Failure>) {
            return ErrorResult(pocketRes.error);
          }

          final updatedRoot = account.copyWith(
            name: name,
            icon: icon,
            color: color,
            isActive: isActive,
            restrictedCategoryIds: restrictedCategoryIds,
            updatedAt: now,
          );
          final rootRes = await _repository.updateAccount(updatedRoot);
          if (rootRes is ErrorResult<void, Failure>) {
            return ErrorResult(rootRes.error);
          }
          return Success(updatedRoot);
        } else {
          final newInit = initialBalance ?? account.initialBalance;
          final delta = newInit - account.initialBalance;
          final updatedRoot = account.copyWith(
            name: name,
            icon: icon,
            color: color,
            isActive: isActive,
            restrictedCategoryIds: restrictedCategoryIds,
            initialBalance: newInit,
            balance: account.balance + delta,
            updatedAt: now,
          );
          final rootRes = await _repository.updateAccount(updatedRoot);
          if (rootRes is ErrorResult<void, Failure>) {
            return ErrorResult(rootRes.error);
          }
          return Success(updatedRoot);
        }
      } else {
        final newInit = initialBalance ?? account.initialBalance;
        final delta = newInit - account.initialBalance;
        final updatedPocket = account.copyWith(
          name: name,
          icon: icon,
          color: color,
          isActive: isActive,
          restrictedCategoryIds: restrictedCategoryIds,
          initialBalance: newInit,
          balance: account.balance + delta,
          updatedAt: now,
        );
        final pocketRes = await _repository.updateAccount(updatedPocket);
        if (pocketRes is ErrorResult<void, Failure>) {
          return ErrorResult(pocketRes.error);
        }
        return Success(updatedPocket);
      }
    }

    if (_unitOfWork != null) {
      return await _unitOfWork.execute(updateOperation);
    }
    return await updateOperation();
  }
}
