// coverage:ignore-file
import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:uuid/uuid.dart';

class Goals extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get accountId => text().unique().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  IntColumn get targetAmount => integer()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  TextColumn get icon => text().nullable()();
  TextColumn get color => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get status =>
      text().map(const EnumNameConverter(GoalStatus.values)).withDefault(const Constant('active'))();

  @override
  Set<Column> get primaryKey => {id};
}
