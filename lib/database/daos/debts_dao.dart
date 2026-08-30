import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/debts_table.dart';
import 'package:poka_ce/database/tables/transactions_table.dart';

part 'debts_dao.g.dart';

@DriftAccessor(tables: [Debts, Transactions, TransactionItems, Accounts])
class DebtsDao extends DatabaseAccessor<AppDatabase> with _$DebtsDaoMixin {
  DebtsDao(super.attachedDatabase);

  Future<List<Debt>> getAllDebts() => select(debts).get();

  Stream<List<Debt>> watchAllDebts() => select(debts).watch();

  Future<List<Debt>> getActiveDebts() => (select(debts)..where((t) => t.status.equals('active'))).get();

  Future<Debt?> getDebt(String id) => (select(debts)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertDebt(DebtsCompanion debt) => into(debts).insert(debt);

  Future<bool> updateDebt(DebtsCompanion debt) => update(debts).replace(debt);

  Future<int> deleteDebt(String id) => (delete(debts)..where((t) => t.id.equals(id))).go();

  Future<void> insertDebtWithTransaction(
    DebtsCompanion debt,
    TransactionsCompanion transactionHeader,
    TransactionItemsCompanion transactionItem,
  ) {
    return transaction(() async {
      await into(debts).insert(debt);
      await into(transactions).insert(transactionHeader);
      await into(transactionItems).insert(transactionItem);

      final accountId = transactionHeader.accountId.value;
      final amount = transactionHeader.amount.value;
      final typeStr = transactionHeader.type.value.toString().split('.').last;

      final account = await (select(accounts)..where((a) => a.id.equals(accountId))).getSingle();
      if (typeStr == 'income') {
        await (update(
          accounts,
        )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance + amount)));
      } else if (typeStr == 'expense') {
        await (update(
          accounts,
        )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance - amount)));
      }
    });
  }

  Future<void> deleteDebtWithTransactionReversal(String id) {
    return transaction(() async {
      final debt = await getDebt(id);
      if (debt == null) return;

      final relatedTransactions = await (select(transactions)..where((t) => t.debtId.equals(id))).get();

      for (final tx in relatedTransactions) {
        final account = await (select(accounts)..where((a) => a.id.equals(tx.accountId))).getSingle();
        final typeStr = tx.type.toString().split('.').last;
        if (typeStr == 'income') {
          await (update(accounts)..where((a) => a.id.equals(tx.accountId))).write(
            AccountsCompanion(balance: Value(account.balance - tx.amount)),
          );
        } else if (typeStr == 'expense') {
          await (update(accounts)..where((a) => a.id.equals(tx.accountId))).write(
            AccountsCompanion(balance: Value(account.balance + tx.amount)),
          );
        }
      }

      await (delete(transactions)..where((t) => t.debtId.equals(id))).go();
      await (delete(debts)..where((t) => t.id.equals(id))).go();
    });
  }
}
