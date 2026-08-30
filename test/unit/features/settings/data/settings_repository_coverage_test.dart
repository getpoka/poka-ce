import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
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

  group('SettingsRepository coverage', () {
    test('settingsRepositoryProvider returns instance via ProviderContainer', () {
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
        ],
      );
      addTearDown(container.dispose);
      final instance = container.read(settingsRepositoryProvider);
      expect(instance, isA<SettingsRepository>());
    });

    test('getSettings returns stored language', () async {
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'language', value: 'id'));
      final settings = await repo.getSettings();
      expect(settings.language, 'id');
      expect(settings.themeMode, 'system');
    });

    test('getSettings returns default language system when empty', () async {
      final settings = await repo.getSettings();
      expect(settings.language, 'system');
    });

    test('getSettings returns all fields together', () async {
      await db
          .into(db.currencies)
          .insert(CurrenciesCompanion.insert(id: const Value('c1'), name: 'Rupiah', code: 'IDR', symbol: 'Rp'));
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'themeMode', value: 'dark'));
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'language', value: 'en'));
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'baseCurrencyId', value: 'c1'));
      final settings = await repo.getSettings();
      expect(settings.themeMode, 'dark');
      expect(settings.language, 'en');
      expect(settings.baseCurrency!.code, 'IDR');
    });

    test('setLanguage inserts and getSettings reflects', () async {
      await repo.setLanguage('en');
      expect((await repo.getSettings()).language, 'en');
      // upsert
      await repo.setLanguage('id');
      expect((await repo.getSettings()).language, 'id');
    });

    test('setLanguage upsert via insertOnConflictUpdate', () async {
      // insert directly then override via repository
      await db.into(db.settings).insert(SettingsCompanion.insert(key: 'language', value: 'system'));
      await repo.setLanguage('en');
      final row = await (db.select(db.settings)..where((t) => t.key.equals('language'))).getSingle();
      expect(row.value, 'en');
    });
  });
}
