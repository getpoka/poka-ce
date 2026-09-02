// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recurringTransactions)
final recurringTransactionsProvider = RecurringTransactionsFamily._();

final class RecurringTransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TransactionModel>>,
          List<TransactionModel>,
          Stream<List<TransactionModel>>
        >
    with
        $FutureModifier<List<TransactionModel>>,
        $StreamProvider<List<TransactionModel>> {
  RecurringTransactionsProvider._({
    required RecurringTransactionsFamily super.from,
    required RecurringTransactionModel super.argument,
  }) : super(
         retry: null,
         name: r'recurringTransactionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$recurringTransactionsHash();

  @override
  String toString() {
    return r'recurringTransactionsProvider'
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
    final argument = this.argument as RecurringTransactionModel;
    return recurringTransactions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RecurringTransactionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recurringTransactionsHash() =>
    r'26a9c0db7a7ea9cc1baa6c895e61c60f15d3ec5d';

final class RecurringTransactionsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<TransactionModel>>,
          RecurringTransactionModel
        > {
  RecurringTransactionsFamily._()
    : super(
        retry: null,
        name: r'recurringTransactionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RecurringTransactionsProvider call(RecurringTransactionModel recurring) =>
      RecurringTransactionsProvider._(argument: recurring, from: this);

  @override
  String toString() => r'recurringTransactionsProvider';
}
