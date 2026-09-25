import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_hero_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_reconcile_sheet.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/sections/account_goals_section.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/sections/account_pockets_section.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/sections/recent_transactions_section.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/theme/theme.dart';

/// Detail page presenting the balance overview, child pockets, and transaction activity for a single account.
class AccountDetailPage extends HookConsumerWidget {
  const new({required this.accountId, super.key});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final aggregate = ref.watch(accountAggregateProvider(accountId));
    if (aggregate == null) {
      return FScaffold(
        header: PokaHeader(title: t.accounts.account),
        child: const Center(child: FCircularProgress()),
      );
    }

    final account = aggregate.account;
    final pockets = aggregate.pockets;
    final accentColor = account.color?.toColor() ?? theme.colors.primary;
    final accountIcon = IconUtil.getIcon(account.icon);
    final totalBalance = aggregate.totalBalance;

    final accountIds = {accountId, ...pockets.map((p) => p.id)};
    final accountTransactions = ref.watch(accountTransactionsProvider(accountIds));

    final linkedGoal = account.type == AccountType.goal
        ? ref.watch(goalProvider.select((g) => g.value?.where((item) => item.accountId == accountId).firstOrNull))
        : null;

    final operationalPockets = pockets.where((p) => p.type != AccountType.goal).toList();
    // Custom pockets only: excludes the auto-generated Main Pocket so the badge
    // reflects user-created pockets rather than the invisible default pocket.
    final customPocketCount = operationalPockets.where((p) => !p.isDefault).length;

    return FScaffold(
      header: PokaHeader(
        title: account.name,
        showBack: true,
        suffixes: [
          if (account.type != AccountType.goal) ...[
            FHeaderAction(
              icon: const Icon(FPhosphorIcons.scales, size: 20),
              onPress: () => AccountReconcileSheet.show(context, account: account, currentBalance: totalBalance),
            ),
            FHeaderAction(
              icon: const Icon(FPhosphorIcons.pencilSimple, size: 20),
              onPress: () => AccountFormSheet.show(context, initialAccount: account),
            ),
          ],
          if (account.type == AccountType.goal && linkedGoal != null)
            FHeaderAction(
              icon: const Icon(FPhosphorIcons.target, size: 20),
              onPress: () => GoalDetailRoute(linkedGoal.id).push<void>(context),
            ),
        ],
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AccountHeroCard(
              account: account,
              balance: totalBalance,
              accentColor: accentColor,
              accountIcon: accountIcon,
              label: account.isPocket ? t.accounts.balance : t.accounts.totalBalance,
              pocketCount: account.isPocket ? null : customPocketCount,
              transactionCount: accountTransactions.length,
            ).animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),

            const SizedBox(height: 20),

            if (account.type != AccountType.goal && !account.isPocket) ...[
              AccountPocketsSection(accountId: accountId, pockets: operationalPockets, totalBalance: totalBalance),
              AccountGoalsSection(accountId: accountId),
              const SizedBox(height: 20),
            ],

            RecentTransactionsSection(
              accountId: accountId,
              accountIds: accountIds,
              accountTransactions: accountTransactions,
            ).animate().fade(duration: 300.ms, delay: 100.ms).slideY(begin: 0.05, end: 0),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
