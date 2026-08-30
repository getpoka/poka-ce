import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/connection.dart';
import 'package:poka_ce/database/daos/accounts_dao.dart';
import 'package:poka_ce/database/daos/budgets_dao.dart';
import 'package:poka_ce/database/daos/categories_dao.dart';
import 'package:poka_ce/database/daos/debts_dao.dart';
import 'package:poka_ce/database/daos/goals_dao.dart';
import 'package:poka_ce/database/daos/recurring_dao.dart';
import 'package:poka_ce/database/daos/settings_dao.dart';
import 'package:poka_ce/database/daos/transactions_dao.dart';
import 'package:poka_ce/database/seeder.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/budgets_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';
import 'package:poka_ce/database/tables/debts_table.dart';
import 'package:poka_ce/database/tables/goals_table.dart';
import 'package:poka_ce/database/tables/recurring_table.dart';
import 'package:poka_ce/database/tables/settings_table.dart';
import 'package:poka_ce/database/tables/transactions_table.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

/// The main Drift database class for Poka CE.
///
/// This class configures all tables, DAOs, and handles schema versioning
/// and migrations for the SQLite database.
@DriftDatabase(
  tables: [
    Currencies,
    Settings,
    Categories,
    Accounts,
    AccountCategories,
    Budgets,
    BudgetRecords,
    Transactions,
    TransactionItems,
    Goals,
    RecurringTransactions,
    Debts,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Initializes the database with an optional [connection].
  /// If no connection is provided, it opens the default 'poka' database file.
  AppDatabase({QueryExecutor? connection}) : super(connection ?? openConnection('poka'));

  /// Data Access Object for settings.
  late final SettingsDao settingsDao = SettingsDao(this);

  /// Data Access Object for categories.
  late final CategoriesDao categoriesDao = CategoriesDao(this);

  /// Data Access Object for accounts and pockets.
  late final AccountsDao accountsDao = AccountsDao(this);

  /// Data Access Object for budgets.
  late final BudgetsDao budgetsDao = BudgetsDao(this);

  /// Data Access Object for saving goals.
  late final GoalsDao goalsDao = GoalsDao(this);

  /// Data Access Object for recurring transactions.
  late final RecurringDao recurringDao = RecurringDao(this);

  /// Data Access Object for debts and loans.
  late final DebtsDao debtsDao = DebtsDao(this);

  /// Data Access Object for transaction headers and items.
  late final TransactionsDao transactionsDao = TransactionsDao(this);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await DatabaseSeeder.seed(this);
      },
      beforeOpen: (details) async {
        // Enforce foreign key constraints in SQLite.
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  /// Deletes all data across all tables and re-seeds the essential defaults.
  ///
  /// This is an irreversible operation used for factory reset functionality.
  Future<void> resetAllData() async {
    return transaction(() async {
      await delete(transactionItems).go();
      await delete(budgetRecords).go();
      await delete(transactions).go();
      await delete(debts).go();
      await delete(recurringTransactions).go();
      await delete(goals).go();
      await delete(budgets).go();
      await delete(accountCategories).go();
      await delete(accounts).go();
      await delete(categories).go();
      await delete(settings).go();
      await delete(currencies).go();

      await DatabaseSeeder.seed(this, overrideSeedDummyData: false);
    });
  }
}
