import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('AppDatabase', () {
    test('schemaVersion is 1', () {
      expect(db.schemaVersion, 1);
    });

    test('database opens with foreign_keys pragma', () async {
      final result = await db.customSelect('PRAGMA foreign_keys').getSingle();
      expect(result.data.values.first, 1);
    });

    test('all DAOs are accessible', () {
      expect(db.accountsDao, isNotNull);
      expect(db.categoriesDao, isNotNull);
      expect(db.budgetsDao, isNotNull);
      expect(db.goalsDao, isNotNull);
      expect(db.recurringDao, isNotNull);
      expect(db.debtsDao, isNotNull);
      expect(db.transactionsDao, isNotNull);
      expect(db.settingsDao, isNotNull);
    });

    test('can insert and retrieve across tables', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('a1'), name: 'W', type: AccountType.assets));
      final acc = await db.accountsDao.getAccount('a1');
      expect(acc, isNotNull);
    });

    test('database contains all 11 tables via DB inspection', () async {
      final tables = await db.customSelect("SELECT name FROM sqlite_master WHERE type='table'").get();
      final names = tables.map((r) => r.data['name'] as String).toSet();
      expect(names.contains('accounts'), true);
      expect(names.contains('categories'), true);
      expect(names.contains('budgets'), true);
      expect(names.contains('transactions'), true);
      expect(names.contains('transaction_items'), true);
      expect(names.contains('goals'), true);
      expect(names.contains('debts'), true);
      expect(names.contains('recurring_transactions'), true);
      expect(names.contains('currencies'), true);
      expect(names.contains('settings'), true);
    });
  });
}
