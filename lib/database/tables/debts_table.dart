// coverage:ignore-file
import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:uuid/uuid.dart';

class Debts extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get personName => text()();
  TextColumn get type => text().map(const EnumNameConverter(DebtType.values))();
  IntColumn get amount => integer()();
  IntColumn get remainingAmount => integer()();
  TextColumn get status => text().map(const EnumNameConverter(DebtStatus.values))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
