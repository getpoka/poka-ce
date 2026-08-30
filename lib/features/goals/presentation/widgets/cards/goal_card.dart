import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_detail_notifier.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/badges/goal_status_badge.dart';
import 'package:poka_ce/features/goals/presentation/widgets/forms/goal_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_slidable_action.dart';
import 'package:poka_ce/theme/theme.dart';

class GoalCard extends ConsumerWidget {
  const GoalCard({
    required this.state,
    this.isInteractive = true,
    super.key,
  });

  final GoalItemState state;
  final bool isInteractive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final completedColor = theme.colors.app.success;
    final progressColor = (state.isCompleted || state.isTargetReached) ? completedColor : theme.colors.primary;

    final cardContent = FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PokaIcon(
                  icon: (state.isCompleted || state.isTargetReached)
                      ? FPhosphorIcons.checkCircle
                      : FPhosphorIcons.target,
                  color: progressColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.goal.name,
                        style: theme.typography.titleCard,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      if (state.isCompleted)
                        GoalStatusBadge(label: t.goals.completed, color: completedColor)
                      else if (state.isTargetReached)
                        GoalStatusBadge(label: t.goals.fullyFunded, color: completedColor)
                      else if (state.goal.targetDate != null)
                        GoalDeadlineBadge(targetDate: state.goal.targetDate!)
                      else
                        GoalStatusBadge(label: t.goals.inProgress, color: theme.colors.mutedForeground),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PokaAmountText(
                      amount: state.saved,
                      type: TransactionType.income,
                      style: theme.typography.amountCard,
                    ),
                    Text(
                      t.goals.saved,
                      style: theme.typography.bodySecondary.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            _ProgressBar(progress: state.progress, color: progressColor),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.goals.percentOfTarget(percent: (state.progress * 100).toStringAsFixed(0)),
                  style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                ),
                if (state.isCompleted || state.isTargetReached)
                  Row(
                    children: [
                      Icon(FPhosphorIcons.checkCircle, size: 11, color: completedColor),
                      const SizedBox(width: 3),
                      PokaAmountText(
                        amount: state.goal.targetAmount,
                        type: TransactionType.income,
                        style: theme.typography.amountTile.copyWith(
                          color: completedColor,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Text(
                        t.goals.needs,
                        style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                      ),
                      PokaAmountText(
                        amount: state.remaining,
                        type: TransactionType.expense,
                        style: theme.typography.amountTile.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                      Text(
                        t.goals.more,
                        style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );

    if (!isInteractive) {
      return cardContent;
    }

    return Slidable(
      key: ValueKey(state.goal.id),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.22,
        children: [
          PokaSlidableAction(
            icon: FPhosphorIcons.trash,
            color: theme.colors.destructive,
            isDestructive: true,
            onPressed: () =>
                ref.read(goalDetailProvider.notifier).deleteGoal(context, state.goal, currentBalance: state.saved),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.22,
        children: [
          PokaSlidableAction(
            icon: FPhosphorIcons.pencilSimple,
            color: theme.colors.primary,
            onPressed: () {
              GoalFormSheet.show(context, initialGoal: state.goal);
            },
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => GoalDetailRoute(state.goal.id, $extra: state.goal).push<void>(context),
        child: (state.isCompleted || state.isTargetReached)
            ? cardContent
                  .animate()
                  .scale(
                    begin: const Offset(0.92, 0.92),
                    end: const Offset(1, 1),
                    duration: 500.ms,
                    curve: Curves.elasticOut,
                  )
                  .fade(duration: 300.ms)
            : cardContent,
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: 6,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (_, value, _) => FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
