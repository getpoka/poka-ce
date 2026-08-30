import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goal_notifier.g.dart';

@riverpod
class GoalNotifier extends _$GoalNotifier {
  @override
  Stream<List<GoalModel>> build() {
    return ref.watch(goalRepositoryProvider).watchGoals();
  }

  Future<void> deleteGoal(String id) async {
    final repo = ref.read(goalRepositoryProvider);
    await repo.deleteGoal(id);
  }

  Future<void> updateGoal(GoalModel model) async {
    final repo = ref.read(goalRepositoryProvider);
    await repo.updateGoal(model);
  }
}

class GoalItemState {
  const GoalItemState({
    required this.goal,
    required this.currentBalance,
  });

  final GoalModel goal;
  final int currentBalance;

  bool get isCompleted => goal.status == GoalStatus.completed;
  int get saved => isCompleted ? goal.targetAmount : currentBalance;
  double get progress => goal.targetAmount > 0 ? (saved / goal.targetAmount).clamp(0.0, 1.0) : 0.0;
  bool get isTargetReached => progress >= 1.0;
  int get remaining => goal.targetAmount - saved > 0 ? goal.targetAmount - saved : 0;
}

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

class GoalSummaryState {
  const GoalSummaryState({
    required this.totalTarget,
    required this.totalSaved,
    required this.targetReachedCount,
    required this.overallProgress,
    required this.remaining,
  });

  final int totalTarget;
  final int totalSaved;
  final int targetReachedCount;
  final double overallProgress;
  final int remaining;
}

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
