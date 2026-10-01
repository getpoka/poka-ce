// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance_builder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides an optional [AccountBalanceBuilder] override for rendering account
/// balances inside selectors (e.g. [PokaPocketSelector]).
///
/// Returns `null` by default — callers fall back to [PokaAmountText] with the
/// app's base currency from Settings.
///
/// Downstream consumers (e.g. Poka PE) can override this provider via
/// `ProviderScope(overrides: [...])` to inject per-account, currency-aware
/// balance rendering without modifying CE source files.

@ProviderFor(accountBalanceBuilder)
final accountBalanceBuilderProvider = AccountBalanceBuilderProvider._();

/// Provides an optional [AccountBalanceBuilder] override for rendering account
/// balances inside selectors (e.g. [PokaPocketSelector]).
///
/// Returns `null` by default — callers fall back to [PokaAmountText] with the
/// app's base currency from Settings.
///
/// Downstream consumers (e.g. Poka PE) can override this provider via
/// `ProviderScope(overrides: [...])` to inject per-account, currency-aware
/// balance rendering without modifying CE source files.

final class AccountBalanceBuilderProvider
    extends $FunctionalProvider<AccountBalanceBuilder?, AccountBalanceBuilder?, AccountBalanceBuilder?>
    with $Provider<AccountBalanceBuilder?> {
  /// Provides an optional [AccountBalanceBuilder] override for rendering account
  /// balances inside selectors (e.g. [PokaPocketSelector]).
  ///
  /// Returns `null` by default — callers fall back to [PokaAmountText] with the
  /// app's base currency from Settings.
  ///
  /// Downstream consumers (e.g. Poka PE) can override this provider via
  /// `ProviderScope(overrides: [...])` to inject per-account, currency-aware
  /// balance rendering without modifying CE source files.
  AccountBalanceBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountBalanceBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountBalanceBuilderHash();

  @$internal
  @override
  $ProviderElement<AccountBalanceBuilder?> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AccountBalanceBuilder? create(Ref ref) {
    return accountBalanceBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountBalanceBuilder? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AccountBalanceBuilder?>(value));
  }
}

String _$accountBalanceBuilderHash() => r'2e0cf7943dc08bc8704b6efafc8372605a7c8042';
