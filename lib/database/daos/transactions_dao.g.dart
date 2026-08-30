// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_dao.dart';

// ignore_for_file: type=lint
mixin _$TransactionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CategoriesTable get categories => attachedDatabase.categories;
  $RecurringTransactionsTable get recurringTransactions => attachedDatabase.recurringTransactions;
  $DebtsTable get debts => attachedDatabase.debts;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $TransactionItemsTable get transactionItems => attachedDatabase.transactionItems;
  $BudgetsTable get budgets => attachedDatabase.budgets;
  $BudgetRecordsTable get budgetRecords => attachedDatabase.budgetRecords;
  TransactionsDaoManager get managers => TransactionsDaoManager(this);
}

class TransactionsDaoManager {
  final _$TransactionsDaoMixin _db;
  TransactionsDaoManager(this._db);
  $$AccountsTableTableManager get accounts => $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$CategoriesTableTableManager get categories => $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$RecurringTransactionsTableTableManager get recurringTransactions => $$RecurringTransactionsTableTableManager(
    _db.attachedDatabase,
    _db.recurringTransactions,
  );
  $$DebtsTableTableManager get debts => $$DebtsTableTableManager(_db.attachedDatabase, _db.debts);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
  $$TransactionItemsTableTableManager get transactionItems => $$TransactionItemsTableTableManager(
    _db.attachedDatabase,
    _db.transactionItems,
  );
  $$BudgetsTableTableManager get budgets => $$BudgetsTableTableManager(_db.attachedDatabase, _db.budgets);
  $$BudgetRecordsTableTableManager get budgetRecords =>
      $$BudgetRecordsTableTableManager(_db.attachedDatabase, _db.budgetRecords);
}
