// coverage:ignore-file
import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';
import 'package:uuid/uuid.dart';

class RecurringTransactions extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  @ReferenceName('recurringSource')
  TextColumn get accountId => text().references(Accounts, #id)();

  @ReferenceName('recurringDestination')
  TextColumn get destinationAccountId => text().nullable().references(Accounts, #id)();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get allocation => text().map(const EnumNameConverter(TransactionAllocation.values)).nullable()();
  TextColumn get type => text().map(const EnumNameConverter(TransactionType.values))();
  IntColumn get amount => integer()();
  TextColumn get note => text().nullable()();
  TextColumn get period => text().map(const EnumNameConverter(RecurringPeriod.values))();
  DateTimeColumn get nextDate => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
