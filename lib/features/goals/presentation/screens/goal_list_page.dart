import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_list_view_notifier.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/cards/goal_card.dart';
import 'package:poka_ce/features/goals/presentation/widgets/cards/goal_summary_card.dart';
import 'package:poka_ce/features/goals/presentation/widgets/forms/goal_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

/// Goal list page — displays all user savings goals with progress.
/// Each goal is linked to a dedicated Pocket account whose balance reflects
/// the amount saved so far (per PLANS.md §5).
class GoalListPage extends HookConsumerWidget {
  const GoalListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 0 = active, 1 = past
    final filterIndex = useState(0);

    final goalStates = ref.watch(goalListStatesProvider);
    final asyncGoals = ref.watch(goalProvider);

    return FScaffold(
      header: PokaHeader(
        title: context.t.dashboard.goals,
        showBack: true,
        suffixes: [
          // Filter toggle: Active / Past
          _GoalFilterChip(
            label: t.goals.active,
            isSelected: filterIndex.value == 0,
            onTap: () => filterIndex.value = 0,
          ),
          const SizedBox(width: 6),
          _GoalFilterChip(
            label: t.goals.past,
            isSelected: filterIndex.value == 1,
            onTap: () => filterIndex.value = 1,
          ),
          const SizedBox(width: 4),
        ],
      ),
      child: asyncGoals.when(
        data: (_) {
          if (goalStates.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Builder(
                builder: (context) => PokaEmptyView(
                  icon: FPhosphorIcons.piggyBank,
                  title: t.goals.noGoalsYet,
                  subtitle: t.goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal,
                  actionLabel: t.goals.createGoal,
                  actionKey: const Key('goal-add-button'),
                  onAction: () => GoalFormSheet.show(context),
                ),
              ),
            );
          }
          return _GoalContent(filterIndex: filterIndex.value);
        },
        loading: () => const Center(child: FCircularProgress()),
        error: (error, _) => Center(child: Text(t.goals.errorPrefix(error: error.toString()))),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Filter chip for header
// ─────────────────────────────────────────────────────────────────────────────

class _GoalFilterChip extends StatelessWidget {
  const _GoalFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.primary : theme.colors.muted,
          borderRadius: theme.style.borderRadius.sm,
        ),
        child: Text(
          label,
          style: theme.typography.labelField.copyWith(
            color: isSelected ? theme.colors.primaryForeground : theme.colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main content: summary card + goal list
// ─────────────────────────────────────────────────────────────────────────────

class _GoalContent extends ConsumerWidget {
  const _GoalContent({required this.filterIndex});

  final int filterIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(goalListViewProvider);
    final activeGoals = viewState.activeGoals;
    final pastGoals = viewState.pastGoals;
    final displayedGoals = filterIndex == 0 ? activeGoals : pastGoals;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GoalSummaryCard(totalGoals: activeGoals.length).animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PokaSectionLabel(title: context.t.dashboard.goals),
              Builder(
                builder: (context) => GestureDetector(
                  key: const Key('goal-add-button'),
                  onTap: () => GoalFormSheet.show(context),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      Icon(FPhosphorIcons.plus, size: 14, color: context.theme.colors.primary),
                      const SizedBox(width: 4),
                      Text(
                        t.goals.addGoal,
                        style: context.theme.typography.bodySecondary.copyWith(
                          color: context.theme.colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).animate().fade(duration: 300.ms, delay: 80.ms).slideY(begin: 0.05, end: 0),
          const SizedBox(height: 8),
          if (displayedGoals.isEmpty)
            Builder(
              builder: (context) => filterIndex == 0
                  ? PokaEmptyView(
                      icon: FPhosphorIcons.piggyBank,
                      title: t.goals.noGoalsYet,
                      subtitle: t.goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal,
                      actionLabel: t.goals.createGoal,
                      actionKey: const Key('goal-add-button'),
                      onAction: () => GoalFormSheet.show(context),
                    )
                  : PokaEmptyView(
                      icon: FPhosphorIcons.checkCircle,
                      title: t.goals.noCompletedGoalsYet,
                      subtitle: t.goals.completedGoalsWillAppearHere,
                    ),
            ).animate().fade(duration: 300.ms, delay: 120.ms)
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: displayedGoals.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final delay = (80 + index * 50).clamp(0, 320);
                  return GoalCard(state: displayedGoals[index])
                      .animate()
                      .fade(duration: 280.ms, delay: delay.ms)
                      .slideY(begin: 0.05, end: 0, duration: 280.ms, delay: delay.ms);
                },
              ),
            ),
        ],
      ),
    );
  }
}
