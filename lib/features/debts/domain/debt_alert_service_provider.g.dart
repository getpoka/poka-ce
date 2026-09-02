// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_alert_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debtAlertService)
final debtAlertServiceProvider = DebtAlertServiceProvider._();

final class DebtAlertServiceProvider extends $FunctionalProvider<DebtAlertService, DebtAlertService, DebtAlertService>
    with $Provider<DebtAlertService> {
  DebtAlertServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debtAlertServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debtAlertServiceHash();

  @$internal
  @override
  $ProviderElement<DebtAlertService> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  DebtAlertService create(Ref ref) {
    return debtAlertService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebtAlertService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebtAlertService>(value),
    );
  }
}

String _$debtAlertServiceHash() => r'81d6e537e1e202c15ac974c40a2f1c6298de834f';
