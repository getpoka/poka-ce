// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_alert_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgetAlertService)
final budgetAlertServiceProvider = BudgetAlertServiceProvider._();

final class BudgetAlertServiceProvider
    extends $FunctionalProvider<BudgetAlertService, BudgetAlertService, BudgetAlertService>
    with $Provider<BudgetAlertService> {
  BudgetAlertServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetAlertServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetAlertServiceHash();

  @$internal
  @override
  $ProviderElement<BudgetAlertService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BudgetAlertService create(Ref ref) {
    return budgetAlertService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetAlertService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetAlertService>(value),
    );
  }
}

String _$budgetAlertServiceHash() => r'bc8fdb21d6fd583caa44609a10706f8600506c85';
