import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'goal_form_notifier.g.dart';

/// Form state tracking inputs, target goals, validation status, and execution progress.
class GoalFormState {
  /// Creates a [GoalFormState].
  const GoalFormState({
    this.initialGoal,
    this.name = '',
    this.targetAmount = 0,
    this.targetDate,
    this.isSaving = false,
    this.isSuccess = false,
    this.error,
  });

  /// Existing goal when in editing mode, or `null` for a new goal.
  final GoalModel? initialGoal;

  /// Goal title / description.
  final String name;

  /// Target funding amount in the smallest currency unit.
  final int targetAmount;

  /// Optional completion deadline date.
  final DateTime? targetDate;

  /// Whether the goal is currently being persisted.
  final bool isSaving;

  /// Whether saving completed successfully.
  final bool isSuccess;

  /// Validation or persistence error message.
  final String? error;

  /// Creates a copy of this state with specified parameters updated.
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

/// Notifier driving the savings goal creation and edit form sheet.
@riverpod
class GoalFormNotifier extends _$GoalFormNotifier {
  @override
  GoalFormState build() {
    return const GoalFormState();
  }

  /// Initializes the form with an existing [goal] or preset parameters.
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

  /// Sets the savings goal title.
  void setName(String name) => state = state.copyWith(name: name);

  /// Sets the target savings goal amount.
  void setTargetAmount(int amount) => state = state.copyWith(targetAmount: amount);

  /// Sets or clears the target deadline date.
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

  /// Validates and saves the goal, generating a linked pocket account on creation.
  Future<void> save() async {
    if (state.name.trim().isEmpty) {
      state = state.copyWith(error: t.goals.nameCannotBeEmpty, isSaving: false);
      return;
    }
    if (state.targetAmount <= 0) {
      state = state.copyWith(error: t.goals.targetAmountGreaterThanZero, isSaving: false);
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
