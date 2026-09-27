// coverage:ignore-file
import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/converters/local_date_converter.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';
import 'package:uuid/uuid.dart';

/// Database table definition for spending limits across categories or accounts.
class Budgets extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get name => text()();
  IntColumn get amount => integer()();
  TextColumn get categoryId => text().nullable().references(Categories, #id, onDelete: KeyAction.setNull)();
  TextColumn get accountId => text().nullable().references(Accounts, #id, onDelete: KeyAction.setNull)();
  TextColumn get period => text().map(const EnumNameConverter(BudgetPeriod.values))();
  IntColumn get resetDay => integer().nullable()();
  IntColumn get alertThreshold => integer().nullable()();
  TextColumn get startDate => text().map(const LocalDateConverter())();
  TextColumn get endDate => text().nullable().map(const LocalDateConverter())();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Database table tracking cyclical budget expenditures.
class BudgetRecords extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get budgetId => text().references(Budgets, #id, onDelete: KeyAction.cascade)();
  IntColumn get spentAmount => integer().withDefault(const Constant(0))();
  TextColumn get periodStart => text().map(const LocalDateConverter())();
  TextColumn get periodEnd => text().map(const LocalDateConverter())();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
