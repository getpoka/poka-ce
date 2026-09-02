// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goalTransactions)
final goalTransactionsProvider = GoalTransactionsFamily._();

final class GoalTransactionsProvider
    extends
        $FunctionalProvider<AsyncValue<List<TransactionModel>>, List<TransactionModel>, Stream<List<TransactionModel>>>
    with $FutureModifier<List<TransactionModel>>, $StreamProvider<List<TransactionModel>> {
  GoalTransactionsProvider._({
    required GoalTransactionsFamily super.from,
    required GoalModel super.argument,
  }) : super(
         retry: null,
         name: r'goalTransactionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$goalTransactionsHash();

  @override
  String toString() {
    return r'goalTransactionsProvider'
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
    final argument = this.argument as GoalModel;
    return goalTransactions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GoalTransactionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$goalTransactionsHash() => r'eab7d2207015a5435fcda57c96943a84b88908e2';

final class GoalTransactionsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<TransactionModel>>, GoalModel> {
  GoalTransactionsFamily._()
    : super(
        retry: null,
        name: r'goalTransactionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GoalTransactionsProvider call(GoalModel goal) => GoalTransactionsProvider._(argument: goal, from: this);

  @override
  String toString() => r'goalTransactionsProvider';
}

@ProviderFor(GoalDetailNotifier)
final goalDetailProvider = GoalDetailNotifierProvider._();

final class GoalDetailNotifierProvider extends $NotifierProvider<GoalDetailNotifier, void> {
  GoalDetailNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalDetailProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalDetailNotifierHash();

  @$internal
  @override
  GoalDetailNotifier create() => GoalDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$goalDetailNotifierHash() => r'7434a4afd1b45e0de3e512f56673aa7c4a049ffb';

abstract class _$GoalDetailNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<void, void>, void, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
