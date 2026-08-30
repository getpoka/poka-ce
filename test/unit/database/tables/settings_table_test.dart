import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(connection: NativeDatabase.memory());
    await db.delete(db.settings).go();
    await db.delete(db.currencies).go();
  });
  tearDown(() async => db.close());

  group('Currencies table', () {
    test('insert, copyWith, equality and json round trip', () async {
      await db
          .into(db.currencies)
          .insert(
            CurrenciesCompanion.insert(id: const Value('cur1'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'),
          );
      final row = await db.select(db.currencies).getSingle();

      expect(row.code, 'IDR');
      expect(row.symbol, 'Rp');

      final changed = row.copyWith(symbol: 'rp');
      expect(changed.symbol, 'rp');
      expect(changed == row, isFalse);
      expect(row.copyWith(), row);
      expect(row.hashCode, isNotNull);
      expect(row.toString(), contains('Currency'));

      expect(Currency.fromJson(row.toJson()), row);

      await (db.delete(db.currencies)..where((c) => c.id.equals('cur1'))).go();
      expect(await db.select(db.currencies).get(), isEmpty);
    });
  });

  group('Settings table', () {
    test('key-value row round trips through json', () async {
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'base_currency', value: 'IDR'));
      final row = await db.select(db.settings).getSingle();

      expect(row.key, 'base_currency');
      expect(row.value, 'IDR');

      final changed = row.copyWith(value: 'USD');
      expect(changed.value, 'USD');
      expect(changed == row, isFalse);
      expect(row.copyWith(), row);
      expect(row.hashCode, isNotNull);
      expect(row.toString(), contains('Setting'));

      expect(Setting.fromJson(row.toJson()), row);
    });

    test('upsert replaces value for the same key', () async {
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'theme', value: 'light'));
      await db.into(db.settings).insertOnConflictUpdate(SettingsCompanion.insert(key: 'theme', value: 'dark'));

      final rows = await db.select(db.settings).get();
      expect(rows.length, 1);
      expect(rows.single.value, 'dark');
    });
  });
}
