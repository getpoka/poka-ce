import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/account_transaction_list.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

class RecentTransactionsSection extends HookConsumerWidget {
  const RecentTransactionsSection({
    required this.accountId,
    required this.accountIds,
    required this.accountTransactions,
    super.key,
  });

  final String accountId;
  final Set<String> accountIds;
  final List<TransactionModel> accountTransactions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                    .applyFilter(TransactionFilter(accountIds: accountIds));
                const TransactionListRoute().push<void>(context);
              },
              child: Row(
                children: [
                  Text(
                    'View all',
                    style: theme.typography.bodySecondary.copyWith(
                      color: theme.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(FPhosphorIcons.arrowRight, size: 14, color: theme.colors.primary),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (accountTransactions.isEmpty)
          PokaEmptyView(
            icon: FPhosphorIcons.receipt,
            title: t.accounts.noTransactionsYet,
            hasBorder: true,
          ).animate().fade(duration: 300.ms, delay: 120.ms).slideY(begin: 0.05, end: 0)
        else
          AccountTransactionList(
            accountId: accountId,
            transactions: accountTransactions.take(10).toList(), // Show max 10
          ),
      ],
    );
  }
}
