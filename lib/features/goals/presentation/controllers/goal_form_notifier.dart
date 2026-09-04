import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'goal_form_notifier.g.dart';

class GoalFormState {
  const GoalFormState({
    this.initialGoal,
    this.name = '',
    this.targetAmount = 0,
    this.targetDate,
    this.isSaving = false,
    this.isSuccess = false,
    this.error,
  });

  final GoalModel? initialGoal;
  final String name;
  final int targetAmount;
  final DateTime? targetDate;
  final bool isSaving;
  final bool isSuccess;
  final String? error;

  GoalFormState copyWith({
    GoalModel? initialGoal,
    String? name,
    int? targetAmount,
    DateTime? targetDate,
    bool? isSaving,
    bool? isSuccess,
    String? error,
  }) {
    return GoalFormState(
      initialGoal: initialGoal ?? this.initialGoal,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      targetDate: targetDate ?? this.targetDate,
      isSaving: isSaving ?? this.isSaving,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

@riverpod
class GoalFormNotifier extends _$GoalFormNotifier {
  @override
  GoalFormState build() {
    return const GoalFormState();
  }

  void init(
    GoalModel? goal, {
    String? initialName,
    int? initialTargetAmount,
    DateTime? initialTargetDate,
  }) {
    if (goal != null) {
      state = GoalFormState(
        initialGoal: goal,
        name: goal.name,
        targetAmount: goal.targetAmount,
        targetDate: goal.targetDate,
      );
    } else {
      state = GoalFormState(
        name: initialName ?? '',
        targetAmount: initialTargetAmount ?? 0,
        targetDate: initialTargetDate,
      );
    }
  }

  void setName(String name) => state = state.copyWith(name: name);
  void setTargetAmount(int amount) => state = state.copyWith(targetAmount: amount);
  void setTargetDate(DateTime? targetDate) {
    if (targetDate == null) {
      // copyWith cannot clear nullable fields; rebuild state explicitly.
      state = GoalFormState(
        initialGoal: state.initialGoal,
        name: state.name,
        targetAmount: state.targetAmount,
        isSaving: state.isSaving,
        isSuccess: state.isSuccess,
        error: state.error,
      );
    } else {
      state = state.copyWith(targetDate: targetDate);
    }
  }

  Future<void> save() async {
    if (state.name.trim().isEmpty) {
      state = state.copyWith(error: 'Name cannot be empty', isSaving: false);
      return;
    }
    if (state.targetAmount <= 0) {
      state = state.copyWith(error: 'Target amount must be greater than 0', isSaving: false);
      return;
    }
    state = state.copyWith(isSaving: true);
    final repo = ref.read(goalRepositoryProvider);

    final now = DateTimeUtils.nowUtc();
    final model =
        state.initialGoal?.copyWith(
          name: state.name.trim(),
          targetAmount: state.targetAmount,
          targetDate: state.targetDate,
          updatedAt: now,
        ) ??
        GoalModel(
          id: const Uuid().v7(),
          name: state.name.trim(),
          targetAmount: state.targetAmount,
          accountId: const Uuid().v7(),
          targetDate: state.targetDate,
          createdAt: now,
          updatedAt: now,
        );

    final result = state.initialGoal == null ? await repo.createGoal(model) : await repo.updateGoal(model);

    switch (result) {
      case Success():
        state = state.copyWith(isSaving: false, isSuccess: true);
      case ErrorResult(error: final failure):
        state = state.copyWith(
          error: failure.message,
          isSaving: false,
        );
    }
  }
}
