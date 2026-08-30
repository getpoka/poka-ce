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

  group('Budgets table', () {
    test('insert with nullable refs, copyWith, json round trip', () async {
      final start = DateTime(2026, 1, 1);
      await db
          .into(db.budgets)
          .insert(
            BudgetsCompanion.insert(
              id: const Value('b1'),
              name: 'Food',
              amount: 1000000,
              period: BudgetPeriod.monthly,
              startDate: start,
              endDate: const Value(null),
            ),
          );
      final row = await db.select(db.budgets).getSingle();

      expect(row.categoryId, isNull);
      expect(row.accountId, isNull);
      expect(row.resetDay, isNull);
      expect(row.endDate, isNull);
      expect(row.period, BudgetPeriod.monthly);

      final changed = row.copyWith(amount: 2000000, resetDay: const Value(25));
      expect(changed.amount, 2000000);
      expect(changed.resetDay, 25);
      expect(changed == row, isFalse);

      final same = row.copyWith();
      expect(same, row);
      expect(same.hashCode, row.hashCode);
      expect(row.toString(), contains('Budget'));

      final restored = Budget.fromJson(row.toJson());
      expect(restored, row);
    });

    test('bound to category and account with yearly period', () async {
      final start = DateTime(2026, 2, 1);
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat'), name: 'Food', type: CategoryType.expense));
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc'), name: 'Main', type: AccountType.assets));
      await db
          .into(db.budgets)
          .insert(
            BudgetsCompanion.insert(
              id: const Value('b2'),
              name: 'Yearly',
              amount: 500000,
              categoryId: const Value('cat'),
              accountId: const Value('acc'),
              period: BudgetPeriod.yearly,
              startDate: start,
              endDate: Value(DateTime(2026, 12, 31)),
              resetDay: const Value(1),
            ),
          );

      final row = await (db.select(db.budgets)..where((b) => b.id.equals('b2'))).getSingle();
      expect(row.categoryId, 'cat');
      expect(row.accountId, 'acc');
      expect(row.endDate, DateTime(2026, 12, 31));
      expect(Budget.fromJson(row.toJson()), row);

      await (db.delete(db.budgets)..where((b) => b.id.equals('b2'))).go();
      expect(await db.select(db.budgets).get(), isEmpty);
    });
  });

  group('BudgetRecords table', () {
    test('spent amount defaults to zero and round trips through json', () async {
      final start = DateTime(2026, 3, 1);
      await db
          .into(db.budgets)
          .insert(
            BudgetsCompanion.insert(
              id: const Value('b1'),
              name: 'Food',
              amount: 100,
              period: BudgetPeriod.monthly,
              startDate: start,
            ),
          );
      await db
          .into(db.budgetRecords)
          .insert(
            BudgetRecordsCompanion.insert(
              id: const Value('br1'),
              budgetId: 'b1',
              periodStart: start,
              periodEnd: DateTime(2026, 3, 31),
            ),
          );
      final row = await db.select(db.budgetRecords).getSingle();

      expect(row.spentAmount, 0);
      expect(row.copyWith(spentAmount: 500).spentAmount, 500);
      expect(row.copyWith(), row);
      expect(row.hashCode, isNotNull);
      expect(row.toString(), contains('BudgetRecord'));
      expect(BudgetRecord.fromJson(row.toJson()), row);
    });

    test('update spent amount persists', () async {
      final start = DateTime(2026, 4, 1);
      await db
          .into(db.budgets)
          .insert(
            BudgetsCompanion.insert(
              id: const Value('b9'),
              name: 'Fun',
              amount: 100,
              period: BudgetPeriod.weekly,
              startDate: start,
            ),
          );
      await db
          .into(db.budgetRecords)
          .insert(
            BudgetRecordsCompanion.insert(
              id: const Value('br9'),
              budgetId: 'b9',
              periodStart: start,
              periodEnd: DateTime(2026, 4, 7),
            ),
          );

      await (db.update(
        db.budgetRecords,
      )..where((r) => r.id.equals('br9'))).write(const BudgetRecordsCompanion(spentAmount: Value(120)));
      final row = await db.select(db.budgetRecords).getSingle();
      expect(row.spentAmount, 120);
    });
  });
}
