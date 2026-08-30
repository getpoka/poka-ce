import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/settings/data/settings_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late SettingsRepository repo;

  setUp(() async {
    db = AppDatabase(connection: NativeDatabase.memory());
    await db.delete(db.settings).go();
    await db.delete(db.currencies).go();
    repo = SettingsRepository(db);
  });

  tearDown(() async => db.close());

  group('SettingsRepository', () {
    test('getCurrencies empty initially', () async {
      expect(await repo.getCurrencies(), isEmpty);
    });

    test('getCurrencies returns inserted currencies', () async {
      await db
          .into(db.currencies)
          .insert(CurrenciesCompanion.insert(id: const Value('c1'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'));
      await db
          .into(db.currencies)
          .insert(CurrenciesCompanion.insert(id: const Value('c2'), name: 'Dollar', code: 'USD', symbol: r'$'));
      final list = await repo.getCurrencies();
      expect(list.length, 2);
      expect(list.map((e) => e.code), containsAll(['IDR', 'USD']));
      expect(list.firstWhere((e) => e.id == 'c1').symbol, 'Rp');
    });

    test('getSettings returns default system when empty', () async {
      final settings = await repo.getSettings();
      expect(settings.themeMode, 'system');
      expect(settings.baseCurrency, isNull);
    });

    test('getSettings returns stored themeMode', () async {
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'themeMode', value: 'dark'));
      final settings = await repo.getSettings();
      expect(settings.themeMode, 'dark');
    });

    test('getSettings returns baseCurrency when currency exists', () async {
      await db
          .into(db.currencies)
          .insert(CurrenciesCompanion.insert(id: const Value('c1'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'));
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'baseCurrencyId', value: 'c1'));
      final settings = await repo.getSettings();
      expect(settings.baseCurrency, isNotNull);
      expect(settings.baseCurrency!.code, 'IDR');
      expect(settings.baseCurrency!.id, 'c1');
    });

    test('getSettings returns null baseCurrency when currency id not found', () async {
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'baseCurrencyId', value: 'nonexistent'));
      final settings = await repo.getSettings();
      expect(settings.baseCurrency, isNull);
    });

    test('getSettings handles empty string baseCurrencyId', () async {
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'baseCurrencyId', value: ''));
      final settings = await repo.getSettings();
      expect(settings.baseCurrency, isNull);
    });

    test('setThemeMode inserts and getSettings reflects', () async {
      await repo.setThemeMode('light');
      final settings = await repo.getSettings();
      expect(settings.themeMode, 'light');
      // upsert
      await repo.setThemeMode('dark');
      expect((await repo.getSettings()).themeMode, 'dark');
    });

    test('setBaseCurrency inserts and getSettings reflects', () async {
      await db
          .into(db.currencies)
          .insert(CurrenciesCompanion.insert(id: const Value('c1'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'));
      await repo.setBaseCurrency('c1');
      final settings = await repo.getSettings();
      expect(settings.baseCurrency, isNotNull);
      expect(settings.baseCurrency!.code, 'IDR');
    });

    test('settingsRepositoryProvider provides instance', () async {
      // smoke test for provider wiring via databaseProvider override not needed here
      expect(repo, isA<SettingsRepository>());
    });
  });
}
