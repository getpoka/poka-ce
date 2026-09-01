import 'package:poka_ce/features/settings/data/settings_repository.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_notifier.g.dart';

class SettingsState {
  const SettingsState({
    this.settings,
    this.isLoading = false,
    this.error,
  });

  final SettingsModel? settings;
  final bool isLoading;
  final String? error;

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

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  bool _disposed = false;

  @override
  SettingsState build() {
    ref.onDispose(() {
      _disposed = true;
    });
    Future.microtask(_loadSettings);
    return const SettingsState(isLoading: true);
  }

  Future<void> _loadSettings() async {
    if (_disposed) return;
    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(settingsRepositoryProvider);
      final settings = await repo.getSettings();
      if (_disposed) return;
      state = state.copyWith(settings: settings, isLoading: false);
    } on Exception catch (e) {
      if (_disposed) return;
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

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
