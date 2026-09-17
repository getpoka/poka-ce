// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item_extra_builder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides a custom builder for customizing the transaction tile's time slot.
///
/// By default, this returns null, falling back to standard formatted time text.
/// Downstream consumers can override this to inject custom time or metadata presentation.

@ProviderFor(transactionTimeBuilder)
final transactionTimeBuilderProvider = TransactionTimeBuilderProvider._();

/// Provides a custom builder for customizing the transaction tile's time slot.
///
/// By default, this returns null, falling back to standard formatted time text.
/// Downstream consumers can override this to inject custom time or metadata presentation.

final class TransactionTimeBuilderProvider
    extends $FunctionalProvider<TransactionTimeBuilder?, TransactionTimeBuilder?, TransactionTimeBuilder?>
    with $Provider<TransactionTimeBuilder?> {
  /// Provides a custom builder for customizing the transaction tile's time slot.
  ///
  /// By default, this returns null, falling back to standard formatted time text.
  /// Downstream consumers can override this to inject custom time or metadata presentation.
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

String _$transactionTimeBuilderHash() => r'20e93d93b845ad138a439e97a726edfd47429edf';

/// Provides a custom builder for customizing the transaction tile's amount presentation.
///
/// By default, this returns null, falling back to standard PokaAmountText.
/// Downstream consumers can override this to inject custom amount presentation.

@ProviderFor(transactionAmountBuilder)
final transactionAmountBuilderProvider = TransactionAmountBuilderProvider._();

/// Provides a custom builder for customizing the transaction tile's amount presentation.
///
/// By default, this returns null, falling back to standard PokaAmountText.
/// Downstream consumers can override this to inject custom amount presentation.

final class TransactionAmountBuilderProvider
    extends $FunctionalProvider<TransactionAmountBuilder?, TransactionAmountBuilder?, TransactionAmountBuilder?>
    with $Provider<TransactionAmountBuilder?> {
  /// Provides a custom builder for customizing the transaction tile's amount presentation.
  ///
  /// By default, this returns null, falling back to standard PokaAmountText.
  /// Downstream consumers can override this to inject custom amount presentation.
  TransactionAmountBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionAmountBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionAmountBuilderHash();

  @$internal
  @override
  $ProviderElement<TransactionAmountBuilder?> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  TransactionAmountBuilder? create(Ref ref) {
    return transactionAmountBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionAmountBuilder? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<TransactionAmountBuilder?>(value));
  }
}

String _$transactionAmountBuilderHash() => r'35b4075df2cda4df5e0dc7052b1e0b6ba22ebbcf';
