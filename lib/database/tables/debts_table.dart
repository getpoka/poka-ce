// coverage:ignore-file
import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/converters/local_date_converter.dart';
import 'package:uuid/uuid.dart';

/// Database table definition for interpersonal debts and loans.
class Debts extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get personName => text()();
  TextColumn get type => text().map(const EnumNameConverter(DebtType.values))();
  IntColumn get amount => integer()();
  IntColumn get remainingAmount => integer()();
  TextColumn get status => text().map(const EnumNameConverter(DebtStatus.values))();
  TextColumn get dueDate => text().nullable().map(const LocalDateConverter())();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
