import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_hero_card.dart';
import 'package:poka_ce/theme/theme.dart';

/// Hero card showing the period's net balance, income, and expense totals.
/// Uses the primary gradient background following the budget summary card pattern.
class TransactionListSummaryCard extends ConsumerWidget {
  const TransactionListSummaryCard({required this.state, super.key});

  final TransactionListState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isVisible = ref.watch(balanceVisibilityProvider);
    final net = state.periodNet;
    final isPositive = net >= 0;

    return PokaHeroCard(
      pills: [
        PokaHeroCardPill(
          icon: FPhosphorIcons.receipt,
          label: t.transactions.transactionsCount(count: state.transactions.length),
        ),
        PokaHeroCardPill(
          icon: switch (state.viewMode) {
            TransactionViewMode.day => FPhosphorIcons.calendarDot,
            TransactionViewMode.week => FPhosphorIcons.calendarDots,
            TransactionViewMode.month => FPhosphorIcons.calendar,
          },
          label: state.periodShortLabel,
        ),
        if (state.filter.isActive)
          PokaHeroCardPill(
            icon: FPhosphorIcons.funnelSimple,
            label: t.transactions.filtered,
          ),
      ],
      trailing: GestureDetector(
        onTap: () => ref.read(balanceVisibilityProvider.notifier).toggle(),
        child: Icon(
          isVisible ? FPhosphorIcons.eye : FPhosphorIcons.eyeClosed,
          color: theme.colors.primaryForeground.withValues(alpha: 0.8),
          size: 20,
        ),
      ),
      title: t.transactions.netBalance,
      amount: PokaAmountText(
        amount: net.abs(),
        type: isPositive ? TransactionType.income : TransactionType.expense,
        style: theme.typography.amountSection.copyWith(
          color: theme.colors.primaryForeground,
        ),
      ),
      // No progress bar
      leftSubAmount: PokaHeroCardSubAmount(
        label: t.transactions.income,
        amount: state.periodIncome,
        icon: FPhosphorIcons.arrowCircleUp,
        type: TransactionType.income,
      ),
      rightSubAmount: PokaHeroCardSubAmount(
        label: t.transactions.expense,
        amount: state.periodExpense,
        icon: FPhosphorIcons.arrowCircleDown,
        type: TransactionType.expense,
      ),
    );
  }
}
