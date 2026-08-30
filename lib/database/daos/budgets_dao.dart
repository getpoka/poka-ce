import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/budgets_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';
import 'package:poka_ce/database/tables/transactions_table.dart';

part 'budgets_dao.g.dart';

/// Data Access Object for managing Budgets and BudgetRecords in Drift.
@DriftAccessor(tables: [Budgets, BudgetRecords, Transactions, TransactionItems, Categories])
class BudgetsDao extends DatabaseAccessor<AppDatabase> with _$BudgetsDaoMixin {
  BudgetsDao(super.attachedDatabase);

  /// Fetches all budgets from the database.
  Future<List<Budget>> getAllBudgets() => select(budgets).get();

  /// Fetches a specific budget by its [id].
  Future<Budget?> getBudget(String id) => (select(budgets)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserts a new budget into the database.
  Future<int> insertBudget(BudgetsCompanion budget) => into(budgets).insert(budget);

  /// Retrieves all frozen budget records (historical data) for a specific [budgetId].
  Future<List<BudgetRecord>> getRecordsForBudget(String budgetId) =>
      (select(budgetRecords)..where((t) => t.budgetId.equals(budgetId))).get();

  /// Freezes a period's spent amount into a budget record.
  Future<int> insertBudgetRecord(BudgetRecordsCompanion record) => into(budgetRecords).insert(record);

  /// Updates an existing budget.
  Future<bool> updateBudget(BudgetsCompanion budget) => update(budgets).replace(budget);

  /// Deletes a budget by its [id]. This will cascade to delete its records.
  Future<int> deleteBudget(String id) => (delete(budgets)..where((t) => t.id.equals(id))).go();

  /// Dynamically calculates the total spent amount for a budget within a specific period.
  ///
  /// This sums up all `expense` transactions between [startDate] and [endDate].
  /// If [categoryId] is provided, it filters transactions matching the category
  /// OR any of its child categories (resolving 1-level hierarchy).
  /// If [accountId] is provided, it further filters by account.
  Future<int> getSpentAmountForBudget({
    required DateTime startDate,
    required DateTime endDate,
    String? categoryId,
    String? accountId,
  }) async {
    final amountExp = transactionItems.amount.sum();

    final query =
        selectOnly(transactionItems).join([
            innerJoin(transactions, transactions.id.equalsExp(transactionItems.transactionId)),
          ])
          ..addColumns([amountExp])
          ..where(transactions.transactionDate.isBetweenValues(startDate, endDate))
          ..where(transactions.type.equals('expense'));

    if (categoryId != null) {
      final categoryIds = [categoryId];
      final childCategories = await (select(categories)..where((t) => t.parentId.equals(categoryId))).get();
      categoryIds.addAll(childCategories.map((c) => c.id));
      query.where(transactionItems.categoryId.isIn(categoryIds));
    }

    if (accountId != null) {
      query.where(transactions.accountId.equals(accountId));
    }

    final result = await query.getSingle();
    return result.read(amountExp) ?? 0;
  }
}
