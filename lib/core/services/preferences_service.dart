import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider exposing the raw platform [SharedPreferences] instance.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

/// Provider exposing the [PreferencesService] abstraction.
final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PreferencesService(prefs);
});

/// Wrapper service around [SharedPreferences] for typed key-value storage.
class PreferencesService {
  /// Creates a [PreferencesService] wrapping [_prefs].
  const PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  /// Persists a string [value] for [key].
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  /// Retrieves the string value for [key], or null if absent.
  String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Persists a boolean [value] for [key].
  // required by preferences library
  // ignore: avoid_positional_boolean_parameters
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  /// Retrieves the boolean value for [key], or null if absent.
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Persists an integer [value] for [key].
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  /// Retrieves the integer value for [key], or null if absent.
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Removes the value associated with [key].
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  /// Clears all preferences stored in the app.
  Future<void> clear() async {
    await _prefs.clear();
  }
}
