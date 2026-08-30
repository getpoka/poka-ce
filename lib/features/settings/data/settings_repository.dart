import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(databaseProvider));
});

class SettingsRepository {
  SettingsRepository(this._db);
  final AppDatabase _db;

  Future<List<CurrencyModel>> getCurrencies() async {
    final rows = await _db.select(_db.currencies).get();
    return rows
        .map(
          (r) => CurrencyModel(
            id: r.id,
            name: r.name,
            code: r.code,
            symbol: r.symbol,
            precision: r.precision,
          ),
        )
        .toList();
  }

  Future<SettingsModel> getSettings() async {
    final themeRow = await (_db.select(_db.settings)..where((tbl) => tbl.key.equals('themeMode'))).getSingleOrNull();
    final languageRow = await (_db.select(_db.settings)..where((tbl) => tbl.key.equals('language'))).getSingleOrNull();
    final numberFormatRow = await (_db.select(
      _db.settings,
    )..where((tbl) => tbl.key.equals('numberFormat'))).getSingleOrNull();
    final currencyRow = await (_db.select(
      _db.settings,
    )..where((tbl) => tbl.key.equals('baseCurrencyId'))).getSingleOrNull();

    CurrencyModel? baseCurrency;
    if (currencyRow != null && currencyRow.value.isNotEmpty) {
      final currency = await (_db.select(
        _db.currencies,
      )..where((tbl) => tbl.id.equals(currencyRow.value))).getSingleOrNull();
      if (currency != null) {
        baseCurrency = CurrencyModel(
          id: currency.id,
          name: currency.name,
          code: currency.code,
          symbol: currency.symbol,
          precision: currency.precision,
        );
      }
    }

    return SettingsModel(
      themeMode: themeRow?.value ?? 'system',
      language: languageRow?.value ?? 'system',
      numberFormat: numberFormatRow?.value ?? 'system',
      baseCurrency: baseCurrency,
    );
  }

  Future<void> setThemeMode(String themeMode) async {
    await _db
        .into(_db.settings)
        .insertOnConflictUpdate(
          SettingsCompanion.insert(key: 'themeMode', value: themeMode),
        );
  }

  Future<void> setLanguage(String language) async {
    await _db
        .into(_db.settings)
        .insertOnConflictUpdate(
          SettingsCompanion.insert(key: 'language', value: language),
        );
  }

  Future<void> setNumberFormat(String numberFormat) async {
    await _db
        .into(_db.settings)
        .insertOnConflictUpdate(
          SettingsCompanion.insert(key: 'numberFormat', value: numberFormat),
        );
  }

  Future<void> setBaseCurrency(String currencyId) async {
    await _db
        .into(_db.settings)
        .insertOnConflictUpdate(
          SettingsCompanion.insert(key: 'baseCurrencyId', value: currencyId),
        );
  }
}
