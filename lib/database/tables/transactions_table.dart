// coverage:ignore-file
import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';
import 'package:poka_ce/database/tables/debts_table.dart';
import 'package:poka_ce/database/tables/recurring_table.dart';
import 'package:uuid/uuid.dart';

/// Database table definition for physical transaction receipts (parent header).
class Transactions extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  @ReferenceName('transactionSource')
  TextColumn get accountId => text().references(Accounts, #id, onDelete: KeyAction.cascade)();

  @ReferenceName('transactionDestination')
  TextColumn get destinationAccountId => text().nullable().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text().map(const EnumNameConverter(TransactionType.values))();
  IntColumn get amount => integer()();
  DateTimeColumn get transactionDate => dateTime()();
  TextColumn get note => text().nullable()();
  TextColumn get recurringTransactionId =>
      text().nullable().references(RecurringTransactions, #id, onDelete: KeyAction.setNull)();
  TextColumn get debtId => text().nullable().references(Debts, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Database table definition for receipt detail line items (child items).
class TransactionItems extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get transactionId => text().references(Transactions, #id, onDelete: KeyAction.cascade)();
  TextColumn get categoryId => text().nullable().references(Categories, #id, onDelete: KeyAction.setNull)();
  TextColumn get allocation => text().map(const EnumNameConverter(TransactionAllocation.values)).nullable()();
  IntColumn get amount => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
