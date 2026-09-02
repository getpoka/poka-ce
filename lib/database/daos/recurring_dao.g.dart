// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_dao.dart';

// ignore_for_file: type=lint
mixin _$RecurringDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CategoriesTable get categories => attachedDatabase.categories;
  $RecurringTransactionsTable get recurringTransactions =>
      attachedDatabase.recurringTransactions;
  RecurringDaoManager get managers => RecurringDaoManager(this);
}

class RecurringDaoManager {
  final _$RecurringDaoMixin _db;
  RecurringDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$RecurringTransactionsTableTableManager get recurringTransactions =>
      $$RecurringTransactionsTableTableManager(
        _db.attachedDatabase,
        _db.recurringTransactions,
      );
}
