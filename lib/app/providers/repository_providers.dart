import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/core/data/drift_unit_of_work.dart';
import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/accounts/data/account_repository_impl.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/budgets/data/budget_repository_impl.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/features/categories/data/category_repository_impl.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/debts/data/debt_repository_impl.dart';
import 'package:poka_ce/features/debts/domain/i_debt_repository.dart';
import 'package:poka_ce/features/goals/data/goal_repository_impl.dart';
import 'package:poka_ce/features/goals/domain/i_goal_repository.dart';
import 'package:poka_ce/features/recurring/data/recurring_repository_impl.dart';
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/transactions/data/transaction_repository_impl.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

/// Provides the singleton instance of the AppDatabase.
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// Provides the [IUnitOfWork] implementation.
final unitOfWorkProvider = Provider<IUnitOfWork>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftUnitOfWork(db);
});

/// Provides the [IAccountRepository] implementation.
final accountRepositoryProvider = Provider<IAccountRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return AccountRepositoryImpl(db.accountsDao);
});

/// Provides the [ITransactionRepository] implementation.
final transactionRepositoryProvider = Provider<ITransactionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TransactionRepositoryImpl(db.transactionsDao);
});

/// Provides the [ICategoryRepository] implementation.
final categoryRepositoryProvider = Provider<ICategoryRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CategoryRepositoryImpl(db.categoriesDao);
});

/// Provides the [IBudgetRepository] implementation.
final budgetRepositoryProvider = Provider<IBudgetRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return BudgetRepositoryImpl(db.budgetsDao);
});

/// Provides the [IGoalRepository] implementation.
final goalRepositoryProvider = Provider<IGoalRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GoalRepositoryImpl(db.goalsDao);
});

/// Provides the [IDebtRepository] implementation.
final debtRepositoryProvider = Provider<IDebtRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DebtRepositoryImpl(db.debtsDao);
});

/// Provides the [IRecurringRepository] implementation.
final recurringRepositoryProvider = Provider<IRecurringRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return RecurringRepositoryImpl(db.recurringDao);
});

// --- Stream Providers for Reactive UI ---

final accountsStreamProvider = StreamProvider<List<AccountModel>>((ref) {
  final repo = ref.watch(accountRepositoryProvider);
  return repo.watchAccounts().map((res) => res.fold((s) => s, (f) => []));
});

final recentTransactionsStreamProvider = StreamProvider<List<TransactionModel>>((ref) {
  final repo = ref.watch(transactionRepositoryProvider);
  return repo.watchTransactions().map((res) => res.fold((s) => s, (f) => []));
});

final categoriesStreamProvider = StreamProvider<List<CategoryModel>>((ref) {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.watchCategories().map((res) => res.fold((s) => s, (f) => []));
});
