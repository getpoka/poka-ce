// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier managing the asynchronous collection of user budgets and associated CRUD lifecycles.

@ProviderFor(BudgetListNotifier)
final budgetListProvider = BudgetListNotifierProvider._();

/// Notifier managing the asynchronous collection of user budgets and associated CRUD lifecycles.
final class BudgetListNotifierProvider extends $AsyncNotifierProvider<BudgetListNotifier, List<BudgetModel>> {
  /// Notifier managing the asynchronous collection of user budgets and associated CRUD lifecycles.
  BudgetListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetListNotifierHash();

  @$internal
  @override
  BudgetListNotifier create() => BudgetListNotifier();
}

String _$budgetListNotifierHash() => r'b367f8af97e0d2c614793f16369585253e7ffbda';

/// Notifier managing the asynchronous collection of user budgets and associated CRUD lifecycles.

abstract class _$BudgetListNotifier extends $AsyncNotifier<List<BudgetModel>> {
  FutureOr<List<BudgetModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<BudgetModel>>, List<BudgetModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BudgetModel>>, List<BudgetModel>>,
              AsyncValue<List<BudgetModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
