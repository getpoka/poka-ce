import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';

part 'accounts_dao.g.dart';

/// Data Access Object for [Accounts] and [AccountCategories] tables.
@DriftAccessor(tables: [Accounts, AccountCategories, Categories])
class AccountsDao extends DatabaseAccessor<AppDatabase> with _$AccountsDaoMixin {
  /// Creates an [AccountsDao] attached to [attachedDatabase].
  AccountsDao(super.attachedDatabase);

  /// Retrieves all accounts regardless of active status.
  Future<List<Account>> getAllAccounts() => select(accounts).get();

  /// Retrieves only accounts marked as active.
  Future<List<Account>> getActiveAccounts() => (select(accounts)..where((t) => t.isActive.equals(true))).get();

  /// Observes all accounts reactively.
  Stream<List<Account>> watchAllAccounts() => select(accounts).watch();

  /// Retrieves an account by its unique [id].
  Future<Account?> getAccount(String id) => (select(accounts)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserts a new account record.
  Future<int> insertAccount(AccountsCompanion account) => into(accounts).insert(account);

  /// Replaces an existing account record.
  Future<bool> updateAccount(AccountsCompanion account) => update(accounts).replace(account);

  /// Soft-deactivates an account by setting `isActive` to false.
  Future<int> deactivateAccount(String id) =>
      (update(accounts)..where((t) => t.id.equals(id))).write(const AccountsCompanion(isActive: Value(false)));

  /// Deletes an account by [id].
  Future<int> deleteAccount(String id) => (delete(accounts)..where((t) => t.id.equals(id))).go();

  /// Updates display sorting order for multiple accounts in a single batch.
  Future<void> updateAccountsSort(List<Account> sortedAccounts) async {
    await batch((batch) {
      for (final account in sortedAccounts) {
        batch.update(
          accounts,
          AccountsCompanion(sort: Value(account.sort)),
          where: (t) => t.id.equals(account.id),
        );
      }
    });
  }

  /// Atomically replaces the category whitelist for an account.
  Future<void> setAccountCategories(String accountId, List<String> categoryIds) async {
    return transaction(() async {
      // Clear existing restrictions before re-inserting the new whitelist
      await (delete(accountCategories)..where((t) => t.accountId.equals(accountId))).go();

      for (final catId in categoryIds) {
        await into(accountCategories).insert(
          AccountCategoriesCompanion.insert(
            accountId: accountId,
            categoryId: catId,
          ),
        );
      }
    });
  }

  /// Retrieves category IDs whitelisted for [accountId].
  Future<List<String>> getAccountCategories(String accountId) async {
    final query = select(accountCategories)..where((t) => t.accountId.equals(accountId));
    final rows = await query.get();
    return rows.map((r) => r.categoryId).toList();
  }

  /// Retrieves a map of account IDs to their whitelisted category IDs.
  Future<Map<String, List<String>>> getAllAccountCategoriesMap() async {
    final rows = await select(accountCategories).get();
    final map = <String, List<String>>{};
    for (final row in rows) {
      map.putIfAbsent(row.accountId, () => []).add(row.categoryId);
    }
    return map;
  }
}
