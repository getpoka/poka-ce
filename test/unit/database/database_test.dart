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

    test('ensureSchema auto-migrates missing disbursed_amount column on legacy database without data loss', () async {
      // Recreate legacy debts table without disbursed_amount to simulate an existing v1.0/v1.1 database
      await db.customStatement('DROP TABLE debts;');
      await db.customStatement('''
        CREATE TABLE debts (
          id TEXT NOT NULL PRIMARY KEY,
          person_name TEXT NOT NULL,
          type TEXT NOT NULL,
          amount INTEGER NOT NULL,
          remaining_amount INTEGER NOT NULL,
          status TEXT NOT NULL,
          due_date TEXT,
          note TEXT,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        );
      ''');
      // Insert legacy debt row
      await db.customStatement('''
        INSERT INTO debts (id, person_name, type, amount, remaining_amount, status, created_at, updated_at)
        VALUES ('legacy-debt-1', 'Budi', 'debt', 100000000, 100000000, 'active', 1700000000, 1700000000);
      ''');

      // Verify disbursed_amount column does NOT exist yet in legacy table
      var tableInfo = await db.customSelect('PRAGMA table_info("debts")').get();
      var columns = tableInfo.map((r) => r.data['name'] as String).toSet();
      expect(columns.contains('disbursed_amount'), isFalse);

      // Trigger schema repair / migration
      await db.ensureSchema();

      // Verify PRAGMA table_info confirms disbursed_amount now exists
      tableInfo = await db.customSelect('PRAGMA table_info("debts")').get();
      columns = tableInfo.map((r) => r.data['name'] as String).toSet();
      expect(columns.contains('disbursed_amount'), isTrue);

      // Verify querying debts via DAO succeeds and preserves legacy data
      final debts = await db.debtsDao.getAllDebts();
      expect(debts.length, 1);
      expect(debts.first.id, 'legacy-debt-1');
      expect(debts.first.personName, 'Budi');
      expect(debts.first.amount, 100000000);
      expect(debts.first.disbursedAmount, isNull);
    });
  });
}
