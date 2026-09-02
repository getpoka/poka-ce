// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransactionFormNotifier)
final transactionFormProvider = TransactionFormNotifierFamily._();

final class TransactionFormNotifierProvider
    extends $NotifierProvider<TransactionFormNotifier, TransactionFormState> {
  TransactionFormNotifierProvider._({
    required TransactionFormNotifierFamily super.from,
    required TransactionFormArgs super.argument,
  }) : super(
         retry: null,
         name: r'transactionFormProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionFormNotifierHash();

  @override
  String toString() {
    return r'transactionFormProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TransactionFormNotifier create() => TransactionFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionFormState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionFormNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionFormNotifierHash() =>
    r'4713c39d5436609e2f5336f0763452d1abc491d5';

final class TransactionFormNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TransactionFormNotifier,
          TransactionFormState,
          TransactionFormState,
          TransactionFormState,
          TransactionFormArgs
        > {
  TransactionFormNotifierFamily._()
    : super(
        retry: null,
        name: r'transactionFormProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TransactionFormNotifierProvider call(TransactionFormArgs args) =>
      TransactionFormNotifierProvider._(argument: args, from: this);

  @override
  String toString() => r'transactionFormProvider';
}

abstract class _$TransactionFormNotifier
    extends $Notifier<TransactionFormState> {
  late final _$args = ref.$arg as TransactionFormArgs;
  TransactionFormArgs get args => _$args;

  TransactionFormState build(TransactionFormArgs args);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TransactionFormState, TransactionFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TransactionFormState, TransactionFormState>,
              TransactionFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
