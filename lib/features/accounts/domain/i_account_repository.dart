import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';

/// Abstract repository for managing Account data.
abstract class IAccountRepository {
  /// Retrieves all accounts.
  Future<Result<List<AccountModel>, Failure>> getAccounts();

  /// Watches all accounts for changes.
  Stream<Result<List<AccountModel>, Failure>> watchAccounts();

  /// Retrieves a specific account by ID.
  Future<Result<AccountModel, Failure>> getAccountById(String id);

  /// Creates a new account.
  Future<Result<void, Failure>> createAccount(AccountModel account);

  /// Updates an existing account.
  Future<Result<void, Failure>> updateAccount(AccountModel account);

  /// Deactivates (soft deletes) an account.
  Future<Result<void, Failure>> deactivateAccount(String id);

  /// Deletes an account.
  Future<Result<void, Failure>> deleteAccount(String id);

  /// Reorders accounts by updating their sort index.
  Future<Result<void, Failure>> reorderAccounts(int oldIndex, int newIndex, {String? parentId});
}
