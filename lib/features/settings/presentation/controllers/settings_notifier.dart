import 'package:poka_ce/features/settings/data/settings_repository.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_notifier.g.dart';

/// Immutable UI state encapsulating current application settings and loading status.
class SettingsState {
  /// Creates a [SettingsState].
  const SettingsState({
    this.settings,
    this.isLoading = false,
    this.error,
  });

  /// Active settings model or `null` while loading.
  final SettingsModel? settings;

  /// Whether settings are currently being loaded or updated.
  final bool isLoading;

  /// Error message on failure.
  final String? error;

  /// Creates a copy of this state with specified fields updated.
  SettingsState copyWith({
    SettingsModel? settings,
    bool? isLoading,
    String? error,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Notifier coordinating user preferences (theme, language, number format, base currency).
@Riverpod(keepAlive: true)
class SettingsNotifier extends _$SettingsNotifier {
  @override
  SettingsState build() {
    Future.microtask(_loadSettings);
    return const SettingsState(isLoading: true);
  }

  Future<void> _loadSettings() async {
    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(settingsRepositoryProvider);
      final settings = await repo.getSettings();
      state = state.copyWith(settings: settings, isLoading: false);
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Updates and reloads the active application theme mode.
  Future<void> setThemeMode(String mode) async {
    try {
      final repo = ref.read(settingsRepositoryProvider);
      await repo.setThemeMode(mode);
      await _loadSettings();
    } on Exception catch (_) {
      // Handle error
    }
  }

  Future<void> setLanguage(String language) async {
    try {
      final repo = ref.read(settingsRepositoryProvider);
      await repo.setLanguage(language);
      await _loadSettings();
    } on Exception catch (_) {
      // Handle error
    }
  }

  Future<void> setNumberFormat(String numberFormat) async {
    try {
      final repo = ref.read(settingsRepositoryProvider);
      await repo.setNumberFormat(numberFormat);
      await _loadSettings();
    } on Exception catch (_) {
      // Handle error
    }
  }

  Future<void> setBaseCurrency(String currencyId) async {
    try {
      final repo = ref.read(settingsRepositoryProvider);
      await repo.setBaseCurrency(currencyId);
      await _loadSettings();
    } on Exception catch (_) {
      // Handle error
    }
  }

  Future<List<CurrencyModel>> getAvailableCurrencies() async {
    final repo = ref.read(settingsRepositoryProvider);
    return repo.getCurrencies();
  }
}
