// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_visibility_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BalanceVisibility)
final balanceVisibilityProvider = BalanceVisibilityProvider._();

final class BalanceVisibilityProvider extends $NotifierProvider<BalanceVisibility, bool> {
  BalanceVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'balanceVisibilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$balanceVisibilityHash();

  @$internal
  @override
  BalanceVisibility create() => BalanceVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$balanceVisibilityHash() => r'a9cae6c66cd91856f32de714adf8f1f397fcb7f9';

abstract class _$BalanceVisibility extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<bool, bool>, bool, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
