import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/settings_table.dart';

part 'settings_dao.g.dart';

/// Data Access Object for [Settings] and [Currencies] tables.
@DriftAccessor(tables: [Settings, Currencies])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  /// Creates a [SettingsDao] attached to [attachedDatabase].
  SettingsDao(super.attachedDatabase);

  /// Retrieves all key-value settings.
  Future<List<Setting>> getAllSettings() => select(settings).get();

  /// Retrieves a specific setting by its unique [key].
  Future<Setting?> getSetting(String key) => (select(settings)..where((t) => t.key.equals(key))).getSingleOrNull();

  /// Sets or replaces a key-value setting.
  Future<void> setSetting(String key, String value) => into(settings).insert(
    SettingsCompanion.insert(key: key, value: value),
    mode: InsertMode.insertOrReplace,
  );

  /// Retrieves all supported currencies from the catalog.
  Future<List<Currency>> getAllCurrencies() => select(currencies).get();

  /// Retrieves a currency by its unique [id].
  Future<Currency?> getCurrency(String id) => (select(currencies)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Adds a new currency to the catalog.
  Future<int> addCurrency(CurrenciesCompanion currency) => into(currencies).insert(currency);
}
