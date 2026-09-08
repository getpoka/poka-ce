import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/budgets_table.dart';
import 'package:poka_ce/database/tables/debts_table.dart';
import 'package:poka_ce/database/tables/transactions_table.dart';

part 'transactions_dao.g.dart';

/// Holds a [Transaction] header alongside its associated child [TransactionItem] line items.
class TransactionWithItems {
  /// Creates a [TransactionWithItems] bundle.
  TransactionWithItems(this.transaction, this.items);

  /// The parent transaction receipt header.
  final Transaction transaction;

  /// The child detail items for this transaction.
  final List<TransactionItem> items;
}

/// Data Access Object for [Transactions] and [TransactionItems].
/// Serves as the core financial ledger engine, coordinating balance mutations,
/// item-level budget deductions, and debt repayment tracking.
@DriftAccessor(tables: [Transactions, TransactionItems, Accounts, Budgets, BudgetRecords, Debts])
class TransactionsDao extends DatabaseAccessor<AppDatabase> with _$TransactionsDaoMixin {
  /// Creates a [TransactionsDao] attached to [attachedDatabase].
  TransactionsDao(super.attachedDatabase);

  /// Retrieves all transaction headers ordered newest first.
  Future<List<Transaction>> getAllTransactions() =>
      (select(transactions)..orderBy([(t) => OrderingTerm.desc(t.transactionDate)])).get();

  /// Observes all transaction headers ordered newest first.
  Stream<List<Transaction>> watchAllTransactions() =>
      (select(transactions)..orderBy([(t) => OrderingTerm.desc(t.transactionDate)])).watch();

  /// Retrieves all transactions grouped with their detail items, newest first.
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

  /// Observes all transactions grouped with their detail items reactively.
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

  /// Observes transactions filtered by optional dates, accounts, categories, types, debts, and recurring IDs.
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

  /// Retrieves a single transaction header by [id].
  Future<Transaction?> getTransaction(String id) =>
      (select(transactions)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Retrieves all detail line items belonging to [transactionId].
  Future<List<TransactionItem>> getTransactionItems(String transactionId) =>
      (select(transactionItems)..where((t) => t.transactionId.equals(transactionId))).get();

  /// Inserts a transaction header and its line items atomically, adjusting account
  /// balances, deducting item-level budgets, and recording debt repayments.
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
      final account = await (select(accounts)..where((a) => a.id.equals(accountId))).getSingleOrNull();

      // Accessing string value directly since it was mapped by EnumNameConverter
      // We will assume the type string equals to lowercase enum name
      final typeStr = transactionHeader.type.value.toString().split('.').last;
      final amount = transactionHeader.amount.value;

      // Real-time balance mutation: income adds to account, expense/transfer subtracts
      if (account != null) {
        if (typeStr == 'income') {
          await (update(
            accounts,
          )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance + amount)));
        } else if (typeStr == 'expense') {
          await (update(
            accounts,
          )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance - amount)));
        } else if (typeStr == 'transfer') {
          await (update(
            accounts,
          )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance - amount)));
        }
      }

      if (typeStr == 'expense') {
        // Accurate deduction for budgets: progress is deducted based on item details
        // from transaction_items, NOT the transactions header total.
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
        // Transfer destination account balance increment
        if (transactionHeader.destinationAccountId.present && transactionHeader.destinationAccountId.value != null) {
          final destId = transactionHeader.destinationAccountId.value!;
          final destAccount = await (select(accounts)..where((a) => a.id.equals(destId))).getSingleOrNull();
          if (destAccount != null) {
            await (update(
              accounts,
            )..where((a) => a.id.equals(destId))).write(
              AccountsCompanion(balance: Value(destAccount.balance + amount)),
            );
          }
        }
      }

      // Debt repayment tracking: reduce remaining amount on linked debt
      if (transactionHeader.debtId.present && transactionHeader.debtId.value != null) {
        final debtId = transactionHeader.debtId.value!;
        final debtRow = await (select(debts)..where((d) => d.id.equals(debtId))).getSingleOrNull();
        if (debtRow != null) {
          // Since repayment reduces the remaining amount:
          final newRemaining = (debtRow.remainingAmount - amount).clamp(0, debtRow.amount);
          final newStatus = newRemaining == 0 ? DebtStatus.paid : DebtStatus.active;
          await (update(debts)..where((d) => d.id.equals(debtId))).write(
            DebtsCompanion(remainingAmount: Value(newRemaining), status: Value(newStatus)),
          );
        }
      }
    });
  }

  /// Permanently deletes a transaction and completely reverses its balance mutations,
  /// budget deductions, and debt repayment progress prior to deletion.
  Future<void> deleteTransaction(String id) async {
    return transaction(() async {
      final tx = await getTransaction(id);
      if (tx == null) return;

      final accountId = tx.accountId;
      final account = await (select(accounts)..where((a) => a.id.equals(accountId))).getSingleOrNull();

      final typeStr = tx.type.toString().split('.').last;
      final amount = tx.amount;

      if (account != null) {
        if (typeStr == 'income') {
          await (update(
            accounts,
          )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance - amount)));
        } else if (typeStr == 'expense') {
          await (update(
            accounts,
          )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance + amount)));
        } else if (typeStr == 'transfer') {
          await (update(
            accounts,
          )..where((a) => a.id.equals(accountId))).write(AccountsCompanion(balance: Value(account.balance + amount)));
        }
      }

      if (typeStr == 'expense') {
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
        if (tx.destinationAccountId != null) {
          final destId = tx.destinationAccountId!;
          final destAccount = await (select(accounts)..where((a) => a.id.equals(destId))).getSingleOrNull();
          if (destAccount != null) {
            await (update(
              accounts,
            )..where((a) => a.id.equals(destId))).write(
              AccountsCompanion(balance: Value(destAccount.balance - amount)),
            );
          }
        }
      }

      // Revert debt repayment
      if (tx.debtId != null) {
        final debtId = tx.debtId!;
        final debtRow = await (select(debts)..where((d) => d.id.equals(debtId))).getSingleOrNull();
        if (debtRow != null) {
          // Since repayment was deleted, we increase the remaining amount
          final newRemaining = (debtRow.remainingAmount + amount).clamp(0, debtRow.amount);
          final newStatus = newRemaining == 0 ? DebtStatus.paid : DebtStatus.active;
          await (update(debts)..where((d) => d.id.equals(debtId))).write(
            DebtsCompanion(remainingAmount: Value(newRemaining), status: Value(newStatus)),
          );
        }
      }

      await (delete(transactions)..where((t) => t.id.equals(id))).go();
    });
  }

  /// Updates a transaction by reversing the previous version and inserting the new one.
  ///
  /// Reversal-first guarantees that old budget quotas and wallet mutations are perfectly
  /// rolled back before the new line items apply, eliminating drift bugs.
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

  /// Deletes transactions older than [beforeDate] without altering current account balances.
  Future<int> clearOldTransactions(DateTime beforeDate) async {
    // Delete transactions older than beforeDate without touching current balances.
    // The detail items are pruned automatically via SQLite cascade delete.
    return (delete(transactions)..where((t) => t.transactionDate.isSmallerThanValue(beforeDate))).go();
  }
}
