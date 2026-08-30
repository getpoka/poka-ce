import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Shown when no transactions match the current date window + filter.
class TransactionListEmptyState extends StatelessWidget {
  const TransactionListEmptyState({
    required this.state,
    required this.onToday,
    super.key,
  });

  final TransactionListState state;
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                  FPhosphorIcons.receipt,
                  size: 48,
                  color: theme.colors.mutedForeground,
                )
                .animate()
                .fade(duration: 400.ms)
                .scale(begin: const Offset(0.7, 0.7), end: const Offset(1, 1), curve: Curves.easeOutBack),
            const SizedBox(height: 16),
            Text(
              t.transactions.noTransactions1,
              style: theme.typography.body.lg.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ).animate().fade(duration: 300.ms, delay: 100.ms).slideY(begin: 0.1, end: 0),
            const SizedBox(height: 8),
            Text(
              state.filter.isActive ? 'Try adjusting your filters.' : 'No transactions found for this period.',
              textAlign: TextAlign.center,
              style: theme.typography.bodyPrimary.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ).animate().fade(duration: 300.ms, delay: 160.ms),
            if (!state.isCurrentPeriod && !state.filter.isActive) ...[
              const SizedBox(height: 24),
              GestureDetector(
                onTap: onToday,
                child: Text(
                  t.transactions.backToToday,
                  style: theme.typography.bodyPrimary.copyWith(
                    color: theme.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ).animate().fade(duration: 300.ms, delay: 220.ms),
            ],
          ],
        ),
      ),
    );
  }
}
