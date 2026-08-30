// coverage:ignore-file
import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/tables/categories_table.dart';
import 'package:uuid/uuid.dart';

class Accounts extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get name => text()();
  TextColumn get icon => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get type => text().map(const EnumNameConverter(AccountType.values))();
  IntColumn get balance => integer().withDefault(const Constant(0))();
  IntColumn get initialBalance => integer().withDefault(const Constant(0))();
  TextColumn get parentId => text().nullable().references(Accounts, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sort => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class AccountCategories extends Table {
  TextColumn get accountId => text().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get categoryId => text().references(Categories, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {accountId, categoryId};
}
