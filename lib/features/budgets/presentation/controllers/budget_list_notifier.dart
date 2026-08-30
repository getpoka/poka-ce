import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_list_notifier.g.dart';

@riverpod
class BudgetListNotifier extends _$BudgetListNotifier {
  @override
  Future<List<BudgetModel>> build() async {
    final repo = ref.read(budgetRepositoryProvider);
    final result = await repo.getBudgets();
    return switch (result) {
      Success(value: final budgets) => budgets,
      ErrorResult(error: final failure) => throw Exception(failure.message),
    };
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(budgetRepositoryProvider);
      final result = await repo.getBudgets();
      return switch (result) {
        Success(value: final budgets) => budgets,
        ErrorResult(error: final failure) => throw Exception(failure.message),
      };
    });
  }

  Future<void> deleteBudget(String id) async {
    final repo = ref.read(budgetRepositoryProvider);
    final result = await repo.deleteBudget(id);
    if (result is Success) {
      await refresh();
    }
  }
}
