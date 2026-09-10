// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier coordinating user preferences (theme, language, number format, base currency).

@ProviderFor(SettingsNotifier)
final settingsProvider = SettingsNotifierProvider._();

/// Notifier coordinating user preferences (theme, language, number format, base currency).
final class SettingsNotifierProvider extends $NotifierProvider<SettingsNotifier, SettingsState> {
  /// Notifier coordinating user preferences (theme, language, number format, base currency).
  SettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsNotifierHash();

  @$internal
  @override
  SettingsNotifier create() => SettingsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsState>(value),
    );
  }
}

String _$settingsNotifierHash() => r'9668502654e3c0029a681373cccf6d198cb49a1c';

/// Notifier coordinating user preferences (theme, language, number format, base currency).

/// Notifier coordinating user preferences (theme, language, number format, base currency).

abstract class _$SettingsNotifier extends $Notifier<SettingsState> {
  SettingsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SettingsState, SettingsState>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<SettingsState, SettingsState>, SettingsState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
