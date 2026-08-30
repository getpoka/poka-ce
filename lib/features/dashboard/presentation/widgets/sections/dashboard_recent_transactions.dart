import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

class DashboardRecentTransactions extends ConsumerWidget {
  const DashboardRecentTransactions({
    required this.transactions,
    super.key,
  });

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);

    final state = ref.watch(dashboardProvider);
    final categoriesById = state.categoriesById;
    final accountsById = state.accountsById;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PokaSectionLabel(title: context.t.dashboard.recentTransactions),
            GestureDetector(
              onTap: () => const TransactionListRoute().go(context),
              child: Text(
                context.t.dashboard.seeAll,
                style: theme.typography.bodySecondary.copyWith(
                  color: theme.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // ── List or empty state ───────────────────────────────────────────
        if (transactions.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Center(child: Text(context.t.dashboard.noRecentTransactions)),
          ).animate().fade(duration: 300.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1))
        else
          _buildFlatTransactions(
            context,
            theme,
            categoriesById,
            accountsById,
            isBalanceVisible,
          ),
      ],
    );
  }

  Widget _buildFlatTransactions(
    BuildContext context,
    FThemeData theme,
    Map<String, CategoryModel> categoriesById,
    Map<String, AccountModel> accountsById,
    bool isBalanceVisible,
  ) {
    // Limit to 5 most recent transactions
    final flatTransactions = transactions.take(5).toList();
    final tiles = <RecentTransactionTile>[];

    for (var i = 0; i < flatTransactions.length; i++) {
      final t = flatTransactions[i];

      // Resolve first item's category
      final firstItemCategoryId = t.items.isNotEmpty ? t.items.first.categoryId : null;
      final category = firstItemCategoryId != null ? categoriesById[firstItemCategoryId] : null;
      final account = accountsById[t.accountId];

      tiles.add(
        RecentTransactionTile(
          transaction: t,
          isBalanceVisible: isBalanceVisible,
          category: category,
          account: account,
          isFirst: i == 0,
          isLast: i == flatTransactions.length - 1,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: tiles.asMap().entries.map((entry) {
        final index = entry.key;
        final tile = entry.value;
        final animatedTile = tile
            .animate()
            .fade(duration: 280.ms, delay: (index * 50).ms)
            .slideY(begin: 0.06, end: 0, duration: 280.ms, delay: (index * 50).ms);
        if (tile == tiles.last) return animatedTile;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: animatedTile,
        );
      }).toList(),
    );
  }
}
