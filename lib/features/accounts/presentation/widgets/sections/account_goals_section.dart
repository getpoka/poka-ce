import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_card.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

/// Section in AccountDetailPage presenting savings goals nested under this account.
class AccountGoalsSection extends HookConsumerWidget {
  const new({required this.accountId, super.key});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final allGoals = ref.watch(goalListStatesProvider);
    final accountGoals = allGoals.where((s) => s.goal.parentAccountId == accountId).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PokaSectionLabel(title: accountGoals.isEmpty ? t.goals.goals : '${t.goals.goals} (${accountGoals.length})'),
            GestureDetector(
              onTap: () => GoalFormSheet.show(context, initialParentAccountId: accountId),
              child: Row(
                children: [
                  Icon(FPhosphorIcons.plus, size: 14, color: theme.colors.primary),
                  const SizedBox(width: 4),
                  Text(
                    t.goals.addGoal,
                    style: theme.typography.bodySecondary.copyWith(
                      color: theme.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).animate().fade(duration: 300.ms, delay: 60.ms).slideY(begin: 0.05, end: 0),
        const SizedBox(height: 8),
        if (accountGoals.isEmpty)
          PokaEmptyView(
            icon: FPhosphorIcons.target,
            title: t.goals.noGoalsYet,
            subtitle: t.goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal,
            hasBorder: true,
          ).animate().fade(duration: 300.ms, delay: 120.ms).slideY(begin: 0.05, end: 0)
        else
          Column(
            children: [
              for (var i = 0; i < accountGoals.length; i++) ...[
                GoalCard(state: accountGoals[i], showParentBadge: false),
                if (i < accountGoals.length - 1) const SizedBox(height: 10),
              ],
            ],
          ),
      ],
    );
  }
}
