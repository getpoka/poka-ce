import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'budget_form_notifier.freezed.dart';
part 'budget_form_notifier.g.dart';

@freezed
abstract class BudgetFormState with _$BudgetFormState {
  const factory BudgetFormState({
    BudgetModel? initialBudget,
    @Default('') String name,
    @Default(0) int amount,
    @Default(BudgetPeriod.monthly) BudgetPeriod period,
    int? resetDay,
    int? alertThreshold,
    DateTime? endDate,
    String? categoryId,
    String? accountId,
    @Default(false) bool isSaving,
    @Default(false) bool isSuccess,
    String? error,
  }) = _BudgetFormState;
}

@riverpod
class BudgetFormNotifier extends _$BudgetFormNotifier {
  @override
  BudgetFormState build() {
    return const BudgetFormState();
  }

  void init(BudgetModel? budget) {
    if (budget != null) {
      state = BudgetFormState(
        initialBudget: budget,
        name: budget.name,
        amount: budget.amount,
        period: budget.period,
        resetDay: budget.resetDay,
        alertThreshold: budget.alertThreshold,
        endDate: budget.endDate,
        categoryId: budget.categoryId,
        accountId: budget.accountId,
      );
    } else {
      state = const BudgetFormState();
    }
  }

  void setName(String name) => state = state.copyWith(name: name);
  void setAmount(int amount) => state = state.copyWith(amount: amount);
  void setPeriod(BudgetPeriod period) => state = state.copyWith(period: period);
  void setResetDay(int? resetDay) => state = state.copyWith(resetDay: resetDay);
  void setAlertThreshold(int? threshold) => state = state.copyWith(alertThreshold: threshold);
  void setEndDate(DateTime? endDate) => state = state.copyWith(endDate: endDate);
  void setCategoryId(String? categoryId) => state = state.copyWith(categoryId: categoryId);
  void setAccountId(String? accountId) => state = state.copyWith(accountId: accountId);

  Future<void> save() async {
    if (state.name.trim().isEmpty) {
      state = state.copyWith(error: 'Name cannot be empty');
      return;
    }
    if (state.amount <= 0) {
      state = state.copyWith(error: 'Amount must be greater than 0');
      return;
    }

    state = state.copyWith(isSaving: true, error: null);
    final repo = ref.read(budgetRepositoryProvider);

    final now = DateTimeUtils.nowUtc();
    final model =
        state.initialBudget?.copyWith(
          name: state.name.trim(),
          amount: state.amount,
          period: state.period,
          resetDay: state.period == BudgetPeriod.monthly ? (state.resetDay ?? 1) : null,
          alertThreshold: state.alertThreshold,
          endDate: state.period == BudgetPeriod.custom ? state.endDate : null,
          categoryId: state.categoryId,
          accountId: state.accountId,
          updatedAt: now,
        ) ??
        BudgetModel(
          id: const Uuid().v7(),
          name: state.name.trim(),
          amount: state.amount,
          period: state.period,
          startDate: now,
          resetDay: state.period == BudgetPeriod.monthly ? (state.resetDay ?? 1) : null,
          alertThreshold: state.alertThreshold,
          endDate: state.period == BudgetPeriod.custom ? state.endDate : null,
          categoryId: state.categoryId,
          accountId: state.accountId,
          createdAt: now,
          updatedAt: now,
        );

    final result = state.initialBudget == null ? await repo.createBudget(model) : await repo.updateBudget(model);

    switch (result) {
      case Success():
        await ref.read(budgetListProvider.notifier).refresh();
        state = state.copyWith(isSaving: false, isSuccess: true);
      case ErrorResult(error: final failure):
        state = state.copyWith(
          error: failure.message,
          isSaving: false,
        );
    }
  }
}
