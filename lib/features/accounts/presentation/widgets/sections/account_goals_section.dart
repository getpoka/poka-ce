import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_card.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';

/// Section in AccountDetailPage presenting savings goals nested under this account.
/// Automatically hides itself when there are no goals associated with the account.
class AccountGoalsSection extends HookConsumerWidget {
  const new({required this.accountId, super.key});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allGoals = ref.watch(goalListStatesProvider);
    final accountGoals = allGoals.where((s) => s.goal.parentAccountId == accountId).toList();

    if (accountGoals.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PokaSectionLabel(title: '${t.goals.goals} (${accountGoals.length})')
              .animate()
              .fade(duration: 300.ms, delay: 60.ms)
              .slideY(begin: 0.05, end: 0),
          const SizedBox(height: 8),
          Column(
            children: [
              for (var i = 0; i < accountGoals.length; i++) ...[
                GoalCard(state: accountGoals[i], showParentBadge: false),
                if (i < accountGoals.length - 1) const SizedBox(height: 10),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
