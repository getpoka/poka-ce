import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/settings_table.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [Settings, Currencies])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.attachedDatabase);

  Future<List<Setting>> getAllSettings() => select(settings).get();

  Future<Setting?> getSetting(String key) => (select(settings)..where((t) => t.key.equals(key))).getSingleOrNull();

  Future<void> setSetting(String key, String value) => into(settings).insert(
    SettingsCompanion.insert(key: key, value: value),
    mode: InsertMode.insertOrReplace,
  );

  Future<List<Currency>> getAllCurrencies() => select(currencies).get();

  Future<Currency?> getCurrency(String id) => (select(currencies)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> addCurrency(CurrenciesCompanion currency) => into(currencies).insert(currency);
}
