import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/migrations/migration_v2.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
  });

  tearDown(() async => db.close());

  group('MigrationV2', () {
    test('adds disbursed_amount column to debts table without data loss', () async {
      // Recreate legacy debts table without disbursed_amount
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
      await db.customStatement('''
        INSERT INTO debts (id, person_name, type, amount, remaining_amount, status, created_at, updated_at)
        VALUES ('legacy-debt-1', 'Budi', 'debt', 100000000, 100000000, 'active', 1700000000, 1700000000);
      ''');

      // Verify disbursed_amount column does not exist
      var tableInfo = await db.customSelect('PRAGMA table_info("debts")').get();
      var columns = tableInfo.map((r) => r.data['name'] as String).toSet();
      expect(columns.contains('disbursed_amount'), isFalse);

      // Run MigrationV2
      final migrator = db.createMigrator();
      await const MigrationV2().up(migrator, db);

      // Verify disbursed_amount column now exists
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
