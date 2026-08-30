import 'package:drift/drift.dart' hide isNotNull, isNull;
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

  group('SettingsDao', () {
    test('getAllSettings empty initially', () async {
      expect(await db.settingsDao.getAllSettings(), isEmpty);
    });

    test('setSetting and getSetting', () async {
      await db.settingsDao.setSetting('base_currency', 'IDR');
      final s = await db.settingsDao.getSetting('base_currency');
      expect(s, isNotNull);
      expect(s!.value, 'IDR');
      expect(s.key, 'base_currency');
    });

    test('getSetting returns null for unknown key', () async {
      expect(await db.settingsDao.getSetting('none'), isNull);
    });

    test('setSetting upserts (insertOrReplace)', () async {
      await db.settingsDao.setSetting('base_currency', 'IDR');
      await db.settingsDao.setSetting('base_currency', 'USD');
      final s = await db.settingsDao.getSetting('base_currency');
      expect(s!.value, 'USD');
      expect((await db.settingsDao.getAllSettings()).length, 1);
    });

    test('getAllCurrencies empty initially', () async {
      expect(await db.settingsDao.getAllCurrencies(), isEmpty);
    });

    test('addCurrency and getCurrency', () async {
      await db.settingsDao.addCurrency(
        CurrenciesCompanion.insert(id: const Value('c1'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'),
      );
      final c = await db.settingsDao.getCurrency('c1');
      expect(c, isNotNull);
      expect(c!.code, 'IDR');
      expect(c.symbol, 'Rp');
    });

    test('getCurrency returns null for unknown', () async {
      expect(await db.settingsDao.getCurrency('none'), isNull);
    });

    test('getAllCurrencies returns multiple', () async {
      await db.settingsDao.addCurrency(
        CurrenciesCompanion.insert(id: const Value('c1'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'),
      );
      await db.settingsDao.addCurrency(
        CurrenciesCompanion.insert(id: const Value('c2'), name: 'Dollar', code: 'USD', symbol: r'$'),
      );
      expect((await db.settingsDao.getAllCurrencies()).length, 2);
    });

    test('unique code constraint', () async {
      await db.settingsDao.addCurrency(
        CurrenciesCompanion.insert(id: const Value('c1'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'),
      );
      expect(
        () => db.settingsDao.addCurrency(
          CurrenciesCompanion.insert(id: const Value('c2'), name: 'Rupiah2', code: 'IDR', symbol: 'Rp2'),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('getAllSettings returns multiple keys', () async {
      await db.settingsDao.setSetting('k1', 'v1');
      await db.settingsDao.setSetting('k2', 'v2');
      expect((await db.settingsDao.getAllSettings()).length, 2);
    });
  });
}
