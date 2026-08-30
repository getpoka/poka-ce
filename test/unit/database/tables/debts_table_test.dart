import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('Debts table', () {
    test('insert debt with defaults and nullable fields', () async {
      await db
          .into(db.debts)
          .insert(
            DebtsCompanion.insert(
              id: const Value('d1'),
              personName: 'Budi',
              type: DebtType.debt,
              amount: 500000,
              remainingAmount: 500000,
              status: DebtStatus.active,
              dueDate: const Value(null),
              note: const Value(null),
            ),
          );
      final row = await db.select(db.debts).getSingle();

      expect(row.type, DebtType.debt);
      expect(row.status, DebtStatus.active);
      expect(row.dueDate, isNull);
      expect(row.note, isNull);

      final changed = row.copyWith(remainingAmount: 250000);
      expect(changed.remainingAmount, 250000);
      expect(changed == row, isFalse);
      expect(row.copyWith(), row);
      expect(row.hashCode, isNotNull);
      expect(row.toString(), contains('Debt'));
    });

    test('json round trip preserves loan enum and dates', () async {
      await db
          .into(db.debts)
          .insert(
            DebtsCompanion.insert(
              id: const Value('d2'),
              personName: 'Sinta',
              type: DebtType.loan,
              amount: 1000000,
              remainingAmount: 400000,
              status: DebtStatus.paid,
              dueDate: Value(DateTime(2026, 9, 30)),
              note: const Value('cicilan'),
            ),
          );
      final row = await db.select(db.debts).getSingle();

      final restored = Debt.fromJson(row.toJson());
      expect(restored, row);
      expect(restored.type, DebtType.loan);
      expect(restored.status, DebtStatus.paid);
      expect(restored.dueDate, DateTime(2026, 9, 30));
    });

    test('update and delete persist correctly', () async {
      await db
          .into(db.debts)
          .insert(
            DebtsCompanion.insert(
              id: const Value('d3'),
              personName: 'Andi',
              type: DebtType.debt,
              amount: 300000,
              remainingAmount: 300000,
              status: DebtStatus.active,
            ),
          );

      await (db.update(db.debts)..where((d) => d.id.equals('d3'))).write(
        const DebtsCompanion(remainingAmount: Value(100000), status: Value(DebtStatus.paid)),
      );
      var row = await db.select(db.debts).getSingle();
      expect(row.remainingAmount, 100000);
      expect(row.status, DebtStatus.paid);

      await (db.delete(db.debts)..where((d) => d.id.equals('d3'))).go();
      expect(await db.select(db.debts).get(), isEmpty);
    });
  });
}
