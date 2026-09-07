import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/budgets_table.dart';
import 'package:poka_ce/database/tables/debts_table.dart';
import 'package:poka_ce/database/tables/transactions_table.dart';

part 'debts_dao.g.dart';

@DriftAccessor(tables: [Debts, Transactions, TransactionItems, Accounts, Budgets, BudgetRecords])
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

      final account = await (select(accounts)..where((a) => a.id.equals(accountId))).getSingleOrNull();
      if (account != null) {
        if (typeStr == 'income') {
          await (update(
            accounts,
          )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance + amount)));
        } else if (typeStr == 'expense') {
          await (update(
            accounts,
          )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance - amount)));
        }
      }

      if (typeStr == 'expense') {
        final date = transactionHeader.transactionDate.value;
        final itemAmount = transactionItem.amount.value;
        final catId = transactionItem.categoryId.present ? transactionItem.categoryId.value : null;

        final matchingRecords =
            await (select(budgetRecords).join([
                    innerJoin(budgets, budgets.id.equalsExp(budgetRecords.budgetId)),
                  ])
                  ..where(budgets.accountId.isNull() | budgets.accountId.equals(accountId))
                  ..where(
                    budgets.categoryId.isNull() |
                        (catId == null ? budgets.categoryId.isNull() : budgets.categoryId.equals(catId)),
                  )
                  ..where(budgetRecords.periodStart.isSmallerOrEqualValue(date))
                  ..where(budgetRecords.periodEnd.isBiggerOrEqualValue(date)))
                .get();

        for (final recordRow in matchingRecords) {
          final record = recordRow.readTable(budgetRecords);
          await (update(budgetRecords)..where((r) => r.id.equals(record.id))).write(
            BudgetRecordsCompanion(spentAmount: Value(record.spentAmount + itemAmount)),
          );
        }
      }
    });
  }

  Future<void> deleteDebtWithTransactionReversal(String id) {
    return transaction(() async {
      final debt = await getDebt(id);
      if (debt == null) return;

      final relatedTransactions = await (select(transactions)..where((t) => t.debtId.equals(id))).get();

      for (final tx in relatedTransactions) {
        final account = await (select(accounts)..where((a) => a.id.equals(tx.accountId))).getSingleOrNull();
        final typeStr = tx.type.toString().split('.').last;
        if (account != null) {
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

        if (typeStr == 'expense') {
          final date = tx.transactionDate;
          final items = await (select(transactionItems)..where((ti) => ti.transactionId.equals(tx.id))).get();

          for (final item in items) {
            final itemAmount = item.amount;
            final catId = item.categoryId;

            final matchingRecords =
                await (select(budgetRecords).join([
                        innerJoin(budgets, budgets.id.equalsExp(budgetRecords.budgetId)),
                      ])
                      ..where(budgets.accountId.isNull() | budgets.accountId.equals(tx.accountId))
                      ..where(
                        budgets.categoryId.isNull() |
                            (catId == null ? budgets.categoryId.isNull() : budgets.categoryId.equals(catId)),
                      )
                      ..where(budgetRecords.periodStart.isSmallerOrEqualValue(date))
                      ..where(budgetRecords.periodEnd.isBiggerOrEqualValue(date)))
                    .get();

            for (final recordRow in matchingRecords) {
              final record = recordRow.readTable(budgetRecords);
              await (update(budgetRecords)..where((r) => r.id.equals(record.id))).write(
                BudgetRecordsCompanion(spentAmount: Value(record.spentAmount - itemAmount)),
              );
            }
          }
        }
      }

      await (delete(transactions)..where((t) => t.debtId.equals(id))).go();
      await (delete(debts)..where((t) => t.id.equals(id))).go();
    });
  }
}
