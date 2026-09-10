// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Watches transactions linked to the specified [debt] (disbursements and repayments).

@ProviderFor(debtTransactions)
final debtTransactionsProvider = DebtTransactionsFamily._();

/// Watches transactions linked to the specified [debt] (disbursements and repayments).

final class DebtTransactionsProvider
    extends
        $FunctionalProvider<AsyncValue<List<TransactionModel>>, List<TransactionModel>, Stream<List<TransactionModel>>>
    with $FutureModifier<List<TransactionModel>>, $StreamProvider<List<TransactionModel>> {
  /// Watches transactions linked to the specified [debt] (disbursements and repayments).
  DebtTransactionsProvider._({
    required DebtTransactionsFamily super.from,
    required DebtModel super.argument,
  }) : super(
         retry: null,
         name: r'debtTransactionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$debtTransactionsHash();

  @override
  String toString() {
    return r'debtTransactionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<TransactionModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TransactionModel>> create(Ref ref) {
    final argument = this.argument as DebtModel;
    return debtTransactions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DebtTransactionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$debtTransactionsHash() => r'c7a343ff8ab18e30fdda8263ba69aff33d656dff';

/// Watches transactions linked to the specified [debt] (disbursements and repayments).

final class DebtTransactionsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<TransactionModel>>, DebtModel> {
  DebtTransactionsFamily._()
    : super(
        retry: null,
        name: r'debtTransactionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Watches transactions linked to the specified [debt] (disbursements and repayments).

  DebtTransactionsProvider call(DebtModel debt) => DebtTransactionsProvider._(argument: debt, from: this);

  @override
  String toString() => r'debtTransactionsProvider';
}

/// Notifier handling detail-level actions on debts including deletion and forgiveness write-offs.

@ProviderFor(DebtDetailNotifier)
final debtDetailProvider = DebtDetailNotifierProvider._();

/// Notifier handling detail-level actions on debts including deletion and forgiveness write-offs.
final class DebtDetailNotifierProvider extends $NotifierProvider<DebtDetailNotifier, void> {
  /// Notifier handling detail-level actions on debts including deletion and forgiveness write-offs.
  DebtDetailNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debtDetailProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debtDetailNotifierHash();

  @$internal
  @override
  DebtDetailNotifier create() => DebtDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$debtDetailNotifierHash() => r'e746cd7de6ab99f0151ba0b0403b6b1e64d6f500';

/// Notifier handling detail-level actions on debts including deletion and forgiveness write-offs.

abstract class _$DebtDetailNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<void, void>, void, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
