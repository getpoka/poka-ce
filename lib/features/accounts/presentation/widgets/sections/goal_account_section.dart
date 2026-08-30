import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_mini_card.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

class GoalAccountSection extends HookConsumerWidget {
  const GoalAccountSection({
    required this.aggregates,
    required this.totalAssets,
    super.key,
  });

  final List<AccountAggregate> aggregates;
  final double totalAssets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    final goals = ref.watch(goalProvider).value ?? [];

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => isExpanded.value = !isExpanded.value,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(child: PokaSectionLabel(title: t.accounts.goalsAndSavings)),
                  Icon(
                    isExpanded.value ? FPhosphorIcons.caretUp : FPhosphorIcons.caretDown,
                    size: 16,
                    color: context.theme.colors.mutedForeground,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded.value) ...[
            const SizedBox(height: 12),
            GridView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              children: aggregates.map((aggregate) {
                return AccountMiniCard(
                  key: ValueKey(aggregate.account.id),
                  account: aggregate.account,
                  balance: aggregate.totalBalance,
                  ratio: aggregate.calculateRatio(totalAssets),
                  ratioLabel: aggregate.formatRatioLabel(totalAssets),
                  pocketCount: aggregate.pockets.length,
                  onTap: () {
                    final goal = goals.where((g) => g.accountId == aggregate.account.id).firstOrNull;
                    if (goal != null) {
                      GoalDetailRoute(goal.id).push<void>(context);
                    } else {
                      AccountDetailRoute(aggregate.account.id).push<void>(context);
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
