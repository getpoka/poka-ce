import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_list_notifier.g.dart';

/// Notifier managing the asynchronous collection of user budgets and associated CRUD lifecycles.
@riverpod
class BudgetListNotifier extends _$BudgetListNotifier {
  /// Fetches the initial list of budgets from the database repository.
  @override
  Future<List<BudgetModel>> build() async {
    final repo = ref.read(budgetRepositoryProvider);
    final result = await repo.getBudgets();
    return switch (result) {
      Success(value: final budgets) => budgets,
      ErrorResult(error: final failure) => await Future.error(failure, StackTrace.current),
    };
  }

  /// Reloads the full list of budgets.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
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
