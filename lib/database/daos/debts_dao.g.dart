// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debts_dao.dart';

// ignore_for_file: type=lint
mixin _$DebtsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DebtsTable get debts => attachedDatabase.debts;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CategoriesTable get categories => attachedDatabase.categories;
  $RecurringTransactionsTable get recurringTransactions => attachedDatabase.recurringTransactions;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $TransactionItemsTable get transactionItems => attachedDatabase.transactionItems;
  DebtsDaoManager get managers => DebtsDaoManager(this);
}

class DebtsDaoManager {
  final _$DebtsDaoMixin _db;
  DebtsDaoManager(this._db);
  $$DebtsTableTableManager get debts => $$DebtsTableTableManager(_db.attachedDatabase, _db.debts);
  $$AccountsTableTableManager get accounts => $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$CategoriesTableTableManager get categories => $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$RecurringTransactionsTableTableManager get recurringTransactions => $$RecurringTransactionsTableTableManager(
    _db.attachedDatabase,
    _db.recurringTransactions,
  );
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
  $$TransactionItemsTableTableManager get transactionItems => $$TransactionItemsTableTableManager(
    _db.attachedDatabase,
    _db.transactionItems,
  );
}
