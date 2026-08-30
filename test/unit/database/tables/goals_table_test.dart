import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:poka_ce/core/enums.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('Goals table', () {
    test('insert with nullable target date, copyWith and json round trip', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Pocket', type: AccountType.assets));
      await db
          .into(db.goals)
          .insert(
            GoalsCompanion.insert(
              id: const Value('g1'),
              accountId: 'acc1',
              name: 'MacBook',
              targetAmount: 25000000,
              targetDate: const Value(null),
              icon: const Value('laptop'),
              color: const Value('#0000FF'),
            ),
          );
      final row = await db.select(db.goals).getSingle();

      expect(row.targetDate, isNull);
      expect(row.icon, 'laptop');
      expect(row.color, '#0000FF');

      final changed = row.copyWith(name: 'iPhone');
      expect(changed.name, 'iPhone');
      expect(changed == row, isFalse);
      expect(row.copyWith(), row);
      expect(row.hashCode, isNotNull);
      expect(row.toString(), contains('Goal'));

      expect(Goal.fromJson(row.toJson()), row);
    });

    test('update progress fields and delete', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc2'), name: 'Pocket2', type: AccountType.goal));
      await db
          .into(db.goals)
          .insert(
            GoalsCompanion.insert(
              id: const Value('g2'),
              accountId: 'acc2',
              name: 'Trip',
              targetAmount: 10000000,
              targetDate: Value(DateTime(2027, 1, 1)),
            ),
          );
      final row = await db.select(db.goals).getSingle();
      expect(row.targetDate, DateTime(2027, 1, 1));

      await (db.update(
        db.goals,
      )..where((g) => g.id.equals('g2'))).write(const GoalsCompanion(targetAmount: Value(12000000)));
      final updated = await db.select(db.goals).getSingle();
      expect(updated.targetAmount, 12000000);

      await (db.delete(db.goals)..where((g) => g.id.equals('g2'))).go();
      expect(await db.select(db.goals).get(), isEmpty);
    });
  });
}
