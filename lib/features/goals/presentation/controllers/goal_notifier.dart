import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goal_notifier.g.dart';

/// StreamNotifier managing the reactive list of savings goals.
@riverpod
class GoalNotifier extends _$GoalNotifier {
  @override
  Stream<List<GoalModel>> build() {
    return ref.watch(goalRepositoryProvider).watchGoals();
  }

  /// Permanently removes a goal by its unique [id] and deletes its paired goal pocket.
  Future<void> deleteGoal(String id) async {
    final repo = ref.read(goalRepositoryProvider);
    await repo.deleteGoal(id);
  }

  /// Persists metadata updates to an existing savings goal [model].
  Future<void> updateGoal(GoalModel model) async {
    final repo = ref.read(goalRepositoryProvider);
    await repo.updateGoal(model);
  }
}

/// Computed view model representing a goal paired with its linked pocket's current balance.
class GoalItemState {
  /// Creates a [GoalItemState].
  const GoalItemState({
    required this.goal,
    required this.currentBalance,
  });

  /// The underlying goal domain model.
  final GoalModel goal;

  /// Current live balance held in the linked goal pocket.
  final int currentBalance;

  /// Whether this goal has been manually marked as completed.
  bool get isCompleted => goal.status == GoalStatus.completed;

  /// Effective amount saved towards the goal.
  int get saved => isCompleted ? goal.targetAmount : currentBalance;

  /// Progress ratio clamped between 0.0 and 1.0.
  double get progress => goal.targetAmount > 0 ? (saved / goal.targetAmount).clamp(0.0, 1.0) : 0.0;

  /// Whether the saved amount meets or exceeds the target.
  bool get isTargetReached => progress >= 1.0;

  /// Remaining amount needed to reach the savings target.
  int get remaining => goal.targetAmount - saved > 0 ? goal.targetAmount - saved : 0;
}

/// Provides a list of [GoalItemState] objects by joining goals with pocket account balances.
@riverpod
List<GoalItemState> goalListStates(Ref ref) {
  final goals = ref.watch(goalProvider).value ?? [];
  final accounts = ref.watch(dashboardProvider).accounts;

  return goals.map((goal) {
    final account = accounts.where((a) => a.id == goal.accountId).firstOrNull;
    final balance = account?.balance ?? 0;
    return GoalItemState(goal: goal, currentBalance: balance);
  }).toList();
}

/// Aggregated metrics across all active savings goals.
class GoalSummaryState {
  /// Creates a [GoalSummaryState].
  const GoalSummaryState({
    required this.totalTarget,
    required this.totalSaved,
    required this.targetReachedCount,
    required this.overallProgress,
    required this.remaining,
  });

  /// Total sum of all target amounts.
  final int totalTarget;

  /// Total funds saved across all active goal pockets.
  final int totalSaved;

  /// Count of goals that have met or exceeded their target.
  final int targetReachedCount;

  /// Macro progress ratio (total saved / total target).
  final double overallProgress;

  /// Remaining funds required across all active goals.
  final int remaining;
}

/// Computes cumulative progress and target aggregates across all active goals.
@riverpod
GoalSummaryState goalSummary(Ref ref) {
  final goals = ref.watch(goalProvider).value ?? [];
  final accounts = ref.watch(dashboardProvider).accounts;

  var totalTarget = 0;
  var totalSaved = 0;
  var targetReachedCount = 0;

  for (final goal in goals) {
    if (goal.status != GoalStatus.active) continue;

    totalTarget += goal.targetAmount;
    final saved = accounts.where((a) => a.id == goal.accountId).firstOrNull?.balance ?? 0;
    totalSaved += saved;
    if (saved >= goal.targetAmount && goal.targetAmount > 0) targetReachedCount++;
  }

  final overallProgress = totalTarget > 0 ? (totalSaved / totalTarget).clamp(0.0, 1.0) : 0.0;
  final remaining = totalTarget - totalSaved > 0 ? totalTarget - totalSaved : 0;

  return GoalSummaryState(
    totalTarget: totalTarget,
    totalSaved: totalSaved,
    targetReachedCount: targetReachedCount,
    overallProgress: overallProgress,
    remaining: remaining,
  );
}
