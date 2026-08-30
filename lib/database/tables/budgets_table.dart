// coverage:ignore-file
import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';
import 'package:uuid/uuid.dart';

class Budgets extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get name => text()();
  IntColumn get amount => integer()();
  TextColumn get categoryId => text().nullable().references(Categories, #id, onDelete: KeyAction.setNull)();
  TextColumn get accountId => text().nullable().references(Accounts, #id)();
  TextColumn get period => text().map(const EnumNameConverter(BudgetPeriod.values))();
  IntColumn get resetDay => integer().nullable()();
  IntColumn get alertThreshold => integer().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class BudgetRecords extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get budgetId => text().references(Budgets, #id, onDelete: KeyAction.cascade)();
  IntColumn get spentAmount => integer().withDefault(const Constant(0))();
  DateTimeColumn get periodStart => dateTime()();
  DateTimeColumn get periodEnd => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
