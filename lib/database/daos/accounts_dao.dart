import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';

part 'accounts_dao.g.dart';

@DriftAccessor(tables: [Accounts, AccountCategories, Categories])
class AccountsDao extends DatabaseAccessor<AppDatabase> with _$AccountsDaoMixin {
  AccountsDao(super.attachedDatabase);

  Future<List<Account>> getAllAccounts() => select(accounts).get();

  Future<List<Account>> getActiveAccounts() => (select(accounts)..where((t) => t.isActive.equals(true))).get();

  Stream<List<Account>> watchAllAccounts() => select(accounts).watch();

  Future<Account?> getAccount(String id) => (select(accounts)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertAccount(AccountsCompanion account) => into(accounts).insert(account);

  Future<bool> updateAccount(AccountsCompanion account) => update(accounts).replace(account);

  Future<int> deactivateAccount(String id) =>
      (update(accounts)..where((t) => t.id.equals(id))).write(const AccountsCompanion(isActive: Value(false)));

  Future<int> deleteAccount(String id) => (delete(accounts)..where((t) => t.id.equals(id))).go();

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

  Future<void> setAccountCategories(String accountId, List<String> categoryIds) async {
    return transaction(() async {
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

  Future<List<String>> getAccountCategories(String accountId) async {
    final query = select(accountCategories)..where((t) => t.accountId.equals(accountId));
    final rows = await query.get();
    return rows.map((r) => r.categoryId).toList();
  }

  Future<Map<String, List<String>>> getAllAccountCategoriesMap() async {
    final rows = await select(accountCategories).get();
    final map = <String, List<String>>{};
    for (final row in rows) {
      map.putIfAbsent(row.accountId, () => []).add(row.categoryId);
    }
    return map;
  }
}
