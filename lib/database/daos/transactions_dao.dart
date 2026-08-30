import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/budgets_table.dart';
import 'package:poka_ce/database/tables/debts_table.dart';
import 'package:poka_ce/database/tables/transactions_table.dart';

part 'transactions_dao.g.dart';

class TransactionWithItems {
  TransactionWithItems(this.transaction, this.items);
  final Transaction transaction;
  final List<TransactionItem> items;
}

@DriftAccessor(tables: [Transactions, TransactionItems, Accounts, Budgets, BudgetRecords, Debts])
class TransactionsDao extends DatabaseAccessor<AppDatabase> with _$TransactionsDaoMixin {
  TransactionsDao(super.attachedDatabase);

  Future<List<Transaction>> getAllTransactions() =>
      (select(transactions)..orderBy([(t) => OrderingTerm.desc(t.transactionDate)])).get();

  Stream<List<Transaction>> watchAllTransactions() =>
      (select(transactions)..orderBy([(t) => OrderingTerm.desc(t.transactionDate)])).watch();

  Future<List<TransactionWithItems>> getAllTransactionsWithItems() async {
    final query = select(transactions).join([
      leftOuterJoin(transactionItems, transactionItems.transactionId.equalsExp(transactions.id)),
    ])..orderBy([OrderingTerm.desc(transactions.transactionDate)]);

    final rows = await query.get();

    final grouped = <String, TransactionWithItems>{};
    for (final row in rows) {
      final tx = row.readTable(transactions);
      final item = row.readTableOrNull(transactionItems);

      final entry = grouped.putIfAbsent(
        tx.id,
        () => TransactionWithItems(tx, []),
      );

      if (item != null) {
        entry.items.add(item);
      }
    }
    return grouped.values.toList();
  }

  Stream<List<TransactionWithItems>> watchAllTransactionsWithItems() {
    final query = select(transactions).join([
      leftOuterJoin(transactionItems, transactionItems.transactionId.equalsExp(transactions.id)),
    ])..orderBy([OrderingTerm.desc(transactions.transactionDate)]);

    return query.watch().map((rows) {
      final grouped = <String, TransactionWithItems>{};
      for (final row in rows) {
        final tx = row.readTable(transactions);
        final item = row.readTableOrNull(transactionItems);

        final entry = grouped.putIfAbsent(
          tx.id,
          () => TransactionWithItems(tx, []),
        );

        if (item != null) {
          entry.items.add(item);
        }
      }
      return grouped.values.toList();
    });
  }

  Stream<List<TransactionWithItems>> watchTransactionsFiltered({
    DateTime? startDate,
    DateTime? endDate,
    Set<String> accountIds = const {},
    Set<String> categoryIds = const {},
    Set<TransactionType> types = const {},
    Set<String> debtIds = const {},
    Set<String> recurringIds = const {},
  }) {
    final query = select(transactions).join([
      leftOuterJoin(transactionItems, transactionItems.transactionId.equalsExp(transactions.id)),
    ]);

    if (startDate != null) {
      query.where(transactions.transactionDate.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where(transactions.transactionDate.isSmallerOrEqualValue(endDate));
    }
    if (accountIds.isNotEmpty) {
      query.where(transactions.accountId.isIn(accountIds) | transactions.destinationAccountId.isIn(accountIds));
    }
    // Transaction type filter
    if (types.isNotEmpty) {
      query.where(transactions.type.isIn(types.map((e) => e.name).toList()));
    }
    if (debtIds.isNotEmpty) {
      query.where(transactions.debtId.isIn(debtIds));
    }
    if (recurringIds.isNotEmpty) {
      query.where(transactions.recurringTransactionId.isIn(recurringIds));
    }
    // For categories, since a transaction might have multiple items, and we want to include the whole transaction if ANY item matches the category.
    // However, joining and applying where directly on transactionItems.categoryId will filter out other items of the same transaction.
    // Instead, we use an EXISTS subquery or an IN clause with a subquery.
    if (categoryIds.isNotEmpty) {
      final subquery = selectOnly(transactionItems)
        ..addColumns([transactionItems.transactionId])
        ..where(transactionItems.categoryId.isIn(categoryIds));
      query.where(transactions.id.isInQuery(subquery));
    }

    query.orderBy([OrderingTerm.desc(transactions.transactionDate)]);

    return query.watch().map((rows) {
      final grouped = <String, TransactionWithItems>{};
      for (final row in rows) {
        final tx = row.readTable(transactions);
        final item = row.readTableOrNull(transactionItems);

        final entry = grouped.putIfAbsent(
          tx.id,
          () => TransactionWithItems(tx, []),
        );

        if (item != null) {
          entry.items.add(item);
        }
      }
      return grouped.values.toList();
    });
  }

  Future<Transaction?> getTransaction(String id) =>
      (select(transactions)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<TransactionItem>> getTransactionItems(String transactionId) =>
      (select(transactionItems)..where((t) => t.transactionId.equals(transactionId))).get();

  Future<void> insertTransactionWithItems(
    TransactionsCompanion transactionHeader,
    List<TransactionItemsCompanion> items,
  ) async {
    return transaction(() async {
      final headerStr = transactionHeader.id.value;
      await into(transactions).insert(transactionHeader);

      for (final item in items) {
        await into(transactionItems).insert(
          item.copyWith(transactionId: Value(headerStr)),
        );
      }

      final accountId = transactionHeader.accountId.value;
      final account = await (select(accounts)..where((a) => a.id.equals(accountId))).getSingle();

      // Accessing string value directly since it was mapped by EnumNameConverter
      // We will assume the type string equals to lowercase enum name
      final typeStr = transactionHeader.type.value.toString().split('.').last;
      final amount = transactionHeader.amount.value;

      if (typeStr == 'income') {
        await (update(
          accounts,
        )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance + amount)));
      } else if (typeStr == 'expense') {
        await (update(
          accounts,
        )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance - amount)));

        // Accurate Deduction for budgets
        final date = transactionHeader.transactionDate.value;
        for (final item in items) {
          final itemAmount = item.amount.value;
          final catId = item.categoryId.present ? item.categoryId.value : null;

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
      } else if (typeStr == 'transfer') {
        await (update(
          accounts,
        )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance - amount)));

        if (transactionHeader.destinationAccountId.present && transactionHeader.destinationAccountId.value != null) {
          final destId = transactionHeader.destinationAccountId.value!;
          final destAccount = await (select(accounts)..where((a) => a.id.equals(destId))).getSingle();
          await (update(
            accounts,
          )..where((a) => a.id.equals(destId))).write(AccountsCompanion(balance: Value(destAccount.balance + amount)));
        }
      }

      // Debt repayment tracking
      if (transactionHeader.debtId.present && transactionHeader.debtId.value != null) {
        final debtId = transactionHeader.debtId.value!;
        final debtRow = await (select(debts)..where((d) => d.id.equals(debtId))).getSingle();
        // Since repayment reduces the remaining amount:
        final newRemaining = (debtRow.remainingAmount - amount).clamp(0, debtRow.amount);
        final newStatus = newRemaining == 0 ? DebtStatus.paid : DebtStatus.active;
        await (update(debts)..where((d) => d.id.equals(debtId))).write(
          DebtsCompanion(remainingAmount: Value(newRemaining), status: Value(newStatus)),
        );
      }
    });
  }

  Future<void> deleteTransaction(String id) async {
    return transaction(() async {
      final tx = await getTransaction(id);
      if (tx == null) return;

      final accountId = tx.accountId;
      final account = await (select(accounts)..where((a) => a.id.equals(accountId))).getSingle();

      final typeStr = tx.type.toString().split('.').last;
      final amount = tx.amount;

      if (typeStr == 'income') {
        await (update(
          accounts,
        )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance - amount)));
      } else if (typeStr == 'expense') {
        await (update(
          accounts,
        )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance + amount)));

        // Revert budget deductions
        final date = tx.transactionDate;
        final items = await getTransactionItems(id);

        for (final item in items) {
          final itemAmount = item.amount;
          final catId = item.categoryId;

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
              BudgetRecordsCompanion(spentAmount: Value(record.spentAmount - itemAmount)),
            );
          }
        }
      } else if (typeStr == 'transfer') {
        await (update(
          accounts,
        )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance + amount)));

        if (tx.destinationAccountId != null) {
          final destId = tx.destinationAccountId!;
          final destAccount = await (select(accounts)..where((a) => a.id.equals(destId))).getSingle();
          await (update(
            accounts,
          )..where((a) => a.id.equals(destId))).write(AccountsCompanion(balance: Value(destAccount.balance - amount)));
        }
      }

      // Revert debt repayment
      if (tx.debtId != null) {
        final debtId = tx.debtId!;
        final debtRow = await (select(debts)..where((d) => d.id.equals(debtId))).getSingle();
        // Since repayment was deleted, we increase the remaining amount
        final newRemaining = (debtRow.remainingAmount + amount).clamp(0, debtRow.amount);
        final newStatus = newRemaining == 0 ? DebtStatus.paid : DebtStatus.active;
        await (update(debts)..where((d) => d.id.equals(debtId))).write(
          DebtsCompanion(remainingAmount: Value(newRemaining), status: Value(newStatus)),
        );
      }

      await (delete(transactions)..where((t) => t.id.equals(id))).go();
    });
  }

  Future<void> updateTransaction(
    TransactionsCompanion transactionHeader,
    List<TransactionItemsCompanion> items,
  ) async {
    return transaction(() async {
      final headerStr = transactionHeader.id.value;
      await deleteTransaction(headerStr);
      await insertTransactionWithItems(transactionHeader, items);
    });
  }

  Future<int> clearOldTransactions(DateTime beforeDate) async {
    // Delete transactions older than beforeDate without touching the balances.
    // The items will be deleted automatically due to cascade delete.
    return (delete(transactions)..where((t) => t.transactionDate.isSmallerThanValue(beforeDate))).go();
  }
}
