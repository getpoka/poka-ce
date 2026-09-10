import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_list_view_notifier.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_card.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_form_sheet.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_summary_card.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

/// Goal list page — displays all user savings goals with progress.
/// Each goal is linked to a dedicated Pocket account whose balance reflects
/// the amount saved so far (per PLANS.md §5).
class GoalListPage extends ConsumerWidget {
  const GoalListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalStates = ref.watch(goalListStatesProvider);
    final asyncGoals = ref.watch(goalProvider);

    return FScaffold(
      header: PokaHeader(
        title: context.t.dashboard.goals,
        showBack: true,
      ),
      child: asyncGoals.when(
        data: (_) {
          if (goalStates.isEmpty) {
            return Builder(
              builder: (context) => PokaEmptyViewCentered(
                icon: FPhosphorIcons.piggyBank,
                title: t.goals.noGoalsYet,
                subtitle: t.goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal,
                actionLabel: t.goals.createGoal,
                actionKey: const Key('goal-add-button'),
                onAction: () => GoalFormSheet.show(context),
              ),
            );
          }
          return const _GoalContent();
        },
        loading: () => const Center(child: FCircularProgress()),
        error: (error, _) => Center(child: Text(t.goals.errorPrefix(error: error.toString()))),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main content: summary card + active goals + completed goals
// ─────────────────────────────────────────────────────────────────────────────

class _GoalContent extends ConsumerWidget {
  const _GoalContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(goalListViewProvider);
    final activeGoals = viewState.activeGoals;
    final pastGoals = viewState.pastGoals;
    final hasPastGoals = pastGoals.isNotEmpty;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GoalSummaryCard(totalGoals: activeGoals.length).animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
          const SizedBox(height: 20),

          // ── Active Goals Section ──────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PokaSectionLabel(
                title: hasPastGoals ? t.goals.activeGoals : context.t.dashboard.goals,
              ),
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

          if (activeGoals.isEmpty)
            Builder(
              builder: (context) => PokaEmptyView(
                icon: FPhosphorIcons.piggyBank,
                title: t.goals.noActiveGoalsYet,
                subtitle: t.goals.noActiveGoalsSubtitle,
                actionLabel: t.goals.createGoal,
                actionKey: const Key('goal-add-button'),
                onAction: () => GoalFormSheet.show(context),
                hasBorder: hasPastGoals,
              ),
            ).animate().fade(duration: 300.ms, delay: 120.ms)
          else
            Padding(
              padding: EdgeInsets.only(bottom: hasPastGoals ? 0 : 20),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: activeGoals.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final delay = (80 + index * 50).clamp(0, 320);
                  return GoalCard(state: activeGoals[index])
                      .animate()
                      .fade(duration: 280.ms, delay: delay.ms)
                      .slideY(begin: 0.05, end: 0, duration: 280.ms, delay: delay.ms);
                },
              ),
            ),

          // ── Completed / Past Goals Section ────────────────────────────────
          if (hasPastGoals) ...[
            const SizedBox(height: 20),
            PokaSectionLabel(title: t.goals.completedGoals)
                .animate()
                .fade(duration: 300.ms, delay: 80.ms)
                .slideY(begin: 0.05, end: 0),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: pastGoals.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final delay = (80 + index * 50).clamp(0, 320);
                  return GoalCard(state: pastGoals[index])
                      .animate()
                      .fade(duration: 280.ms, delay: delay.ms)
                      .slideY(begin: 0.05, end: 0, duration: 280.ms, delay: delay.ms);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
