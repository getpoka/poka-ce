import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/screens/pocket_detail_page.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/account_transaction_list.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_hero_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_mini_card.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/screens/goal_detail_page.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────

class AccountDetailPage extends HookConsumerWidget {
  const AccountDetailPage({required this.accountId, super.key});

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

    // All account IDs that belong to this account (self + pockets)
    final accountIds = {accountId, ...pockets.map((p) => p.id)};

    // Category / account lookup maps from stream providers
    final categoriesById =
        ref
            .watch(categoriesStreamProvider)
            .value
            ?.fold<Map<String, CategoryModel>>(
              {},
              (map, c) => map..[c.id] = c,
            ) ??
        const {};

    final accountsById =
        ref
            .watch(accountsStreamProvider)
            .value
            ?.fold<Map<String, AccountModel>>(
              {},
              (map, a) => map..[a.id] = a,
            ) ??
        const {};

    final accountTransactions = ref.watch(accountTransactionsProvider(accountIds));

    final isBalanceVisible = ref.watch(balanceVisibilityProvider);

    final goals = ref.watch(goalProvider).value ?? [];
    final linkedGoal = goals.where((g) => g.accountId == accountId).firstOrNull;

    return FScaffold(
      header: PokaHeader(
        title: account.name,
        showBack: true,
        suffixes: [
          if (account.type != AccountType.goal)
            FHeaderAction(
              icon: const Icon(FPhosphorIcons.pencilSimple, size: 20),
              onPress: () => AccountFormSheet.show(context, initialAccount: account),
            ),
          if (account.type == AccountType.goal && linkedGoal != null)
            FHeaderAction(
              icon: const Icon(FPhosphorIcons.target, size: 20),
              onPress: () => Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute<void>(
                  builder: (_) => GoalDetailPage(id: linkedGoal.id),
                ),
              ),
            ),
        ],
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Hero card ────────────────────────────────────────────────
            AccountHeroCard(
              account: account,
              balance: totalBalance,
              accentColor: accentColor,
              accountIcon: accountIcon,
              label: t.accounts.totalBalance,
              pocketCount: pockets.length,
              transactionCount: accountTransactions.length,
            ).animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 20),

            // ── Pockets section label ─────────────────────────────────────
            if (account.type != AccountType.goal) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PokaSectionLabel(title: t.accounts.pockets),
                  GestureDetector(
                    onTap: () => AccountFormSheet.show(context, parentAccountId: accountId),
                    child: Row(
                      children: [
                        Icon(FPhosphorIcons.plus, size: 14, color: theme.colors.primary),
                        const SizedBox(width: 4),
                        Text(
                          t.accounts.addPocket,
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

              // ── Pockets grid (2 columns) ──────────────────────────────────
              if (pockets.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(FPhosphorIcons.wallet, size: 36, color: theme.colors.mutedForeground)
                            .animate()
                            .fade(duration: 300.ms, delay: 120.ms)
                            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutBack),
                        const SizedBox(height: 8),
                        Text(
                          t.accounts.noPocketsYet,
                          style: theme.typography.body.md.copyWith(color: theme.colors.mutedForeground),
                        ).animate().fade(duration: 300.ms, delay: 160.ms).slideY(begin: 0.1, end: 0),
                        const SizedBox(height: 4),
                        Text(
                          t.accounts.pocketsHelpYouSplitYourWalletIntoCategories,
                          textAlign: TextAlign.center,
                          style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                        ).animate().fade(duration: 300.ms, delay: 200.ms),
                      ],
                    ),
                  ),
                )
              else
                ReorderableBuilder<Widget>(
                  dragChildBoxDecoration: const BoxDecoration(),
                  onReorderPositions: (positions) {
                    for (final pos in positions) {
                      ref
                          .read(accountListProvider.notifier)
                          .reorderAccounts(pos.oldIndex, pos.newIndex, parentId: accountId);
                    }
                  },
                  builder: (children) {
                    return GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.3,
                      ),
                      children: children,
                    );
                  },
                  children: pockets.map((pocket) {
                    final ratio = totalBalance > 0 ? (pocket.balance / totalBalance).clamp(0.0, 1.0) : 0.0;
                    final ratioLabel = '${(ratio * 100).toStringAsFixed(0)}% of account';

                    return AccountMiniCard(
                      key: ValueKey(pocket.id),
                      account: pocket,
                      balance: pocket.balance,
                      ratio: ratio,
                      ratioLabel: ratioLabel,
                      pocketCount: 0,
                      onEdit: () => AccountFormSheet.show(context, initialAccount: pocket),
                      onDelete: () async {
                        final confirm = await showPokaConfirmDialog(
                          context,
                          title: t.accounts.deletePocket,
                          body: t.accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp,
                          confirmText: t.accounts.delete,
                        );
                        if (confirm == true) {
                          await ref.read(accountListProvider.notifier).deleteAccount(pocket.id);
                        }
                      },
                      onTap: () => Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute<void>(
                          builder: (_) => PocketDetailPage(
                            pocket: pocket,
                            categoriesById: categoriesById,
                            accountsById: accountsById,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 20),
            ],

            // ── Recent transactions section label ─────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PokaSectionLabel(
                  title: accountTransactions.isEmpty
                      ? 'Recent Transactions'
                      : 'Recent Transactions (${accountTransactions.length})',
                ),
                GestureDetector(
                  onTap: () {
                    ref
                        .read(transactionListNotifierProvider.notifier)
                        .applyFilter(TransactionFilter(accountIds: {accountId}));
                    const TransactionListRoute().go(context);
                    Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    t.accounts.seeAll,
                    style: theme.typography.bodySecondary.copyWith(
                      color: theme.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ).animate().fade(duration: 300.ms, delay: 180.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 8),

            // ── Recent transactions list ───────────────────────────────────
            if (accountTransactions.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Column(
                    children: [
                      Icon(FPhosphorIcons.receipt, size: 36, color: theme.colors.mutedForeground)
                          .animate()
                          .fade(duration: 300.ms, delay: 240.ms)
                          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutBack),
                      const SizedBox(height: 8),
                      Text(
                        t.accounts.noTransactionsYet,
                        style: theme.typography.body.md.copyWith(color: theme.colors.mutedForeground),
                      ).animate().fade(duration: 300.ms, delay: 280.ms).slideY(begin: 0.1, end: 0),
                    ],
                  ),
                ),
              )
            else
              AccountTransactionList(
                transactions: accountTransactions,
                categoriesById: categoriesById,
                accountsById: accountsById,
                isBalanceVisible: isBalanceVisible,
              ).animate().fade(duration: 300.ms, delay: 240.ms).slideY(begin: 0.05, end: 0),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pocket Detail View — transactions filtered to a single pocket
