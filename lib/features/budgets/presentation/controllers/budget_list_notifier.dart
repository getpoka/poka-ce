import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_list_notifier.g.dart';

/// Notifier managing the asynchronous collection of user budgets and associated CRUD lifecycles.
@riverpod
class BudgetListNotifier extends _$BudgetListNotifier {
  Future<List<BudgetModel>> _fetch() async {
    final repo = ref.read(budgetRepositoryProvider);
    final result = await repo.getBudgets();
    return switch (result) {
      Success(value: final budgets) => budgets,
      ErrorResult(error: final failure) => await Future.error(failure, StackTrace.current),
    };
  }

  /// Fetches the initial list of budgets from the database repository.
  @override
  Future<List<BudgetModel>> build() => _fetch();

  /// Reloads the full list of budgets.
  Future<void> refresh() async {
    if (!ref.mounted) return;
    state = const AsyncLoading();
    final next = await AsyncValue.guard(_fetch);
    if (!ref.mounted) return;
    state = next;
  }

  /// Permanently removes a budget by [id] and refreshes the list on success.
  Future<void> deleteBudget(String id) async {
    final repo = ref.read(budgetRepositoryProvider);
    final result = await repo.deleteBudget(id);
    if (!ref.mounted) return;
    if (result is Success) {
      await refresh();
    }
  }
}
