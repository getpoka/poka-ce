import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goal_list_view_notifier.g.dart';

/// Partitioned view model separating currently active goals from completed past goals.
class GoalListViewState {
  /// Creates a [GoalListViewState].
  const GoalListViewState({
    required this.activeGoals,
    required this.pastGoals,
  });

  /// In-progress savings goals.
  final List<GoalItemState> activeGoals;

  /// Completed or archived savings goals.
  final List<GoalItemState> pastGoals;
}

/// Provides partitioned lists of active and past goals for UI tab displays.
@riverpod
GoalListViewState goalListView(Ref ref) {
  final goalStates = ref.watch(goalListStatesProvider);

  final activeGoals = goalStates.where((g) => g.goal.status == GoalStatus.active).toList();
  final pastGoals = goalStates.where((g) => g.goal.status == GoalStatus.completed).toList();

  return GoalListViewState(
    activeGoals: activeGoals,
    pastGoals: pastGoals,
  );
}
