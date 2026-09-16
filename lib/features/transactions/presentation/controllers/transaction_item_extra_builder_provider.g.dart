// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item_extra_builder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides a custom builder for customizing the transaction tile's time slot.
///
/// By default (in CE), this returns null, falling back to standard formatted time text.
/// Poka PE overrides this to inject custom layouts (e.g., sync indicators) without coupling CE to sync logic.

@ProviderFor(transactionTimeBuilder)
final transactionTimeBuilderProvider = TransactionTimeBuilderProvider._();

/// Provides a custom builder for customizing the transaction tile's time slot.
///
/// By default (in CE), this returns null, falling back to standard formatted time text.
/// Poka PE overrides this to inject custom layouts (e.g., sync indicators) without coupling CE to sync logic.

final class TransactionTimeBuilderProvider
    extends $FunctionalProvider<TransactionTimeBuilder?, TransactionTimeBuilder?, TransactionTimeBuilder?>
    with $Provider<TransactionTimeBuilder?> {
  TransactionTimeBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionTimeBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionTimeBuilderHash();

  @$internal
  @override
  $ProviderElement<TransactionTimeBuilder?> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  TransactionTimeBuilder? create(Ref ref) {
    return transactionTimeBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionTimeBuilder? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<TransactionTimeBuilder?>(value));
  }
}

String _$transactionTimeBuilderHash() => r'c3d4e5f60718293a4b5c6d7e8f90123456789abc';
