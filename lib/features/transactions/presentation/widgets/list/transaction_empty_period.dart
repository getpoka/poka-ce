import 'package:flutter/material.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/theme/theme.dart';

/// Shown when no transactions match the current date window and filter.
class TransactionEmptyPeriod extends StatelessWidget {
  /// Creates a [TransactionEmptyPeriod].
  const new({required this.state, required this.onToday, super.key});

  /// The active transaction list state providing period information.
  final TransactionListState state;

  /// Callback to navigate back to today's date period.
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PokaEmptyView(
        icon: FPhosphorIcons.receipt,
        title: t.transactions.noTransactions,
        subtitle: t.transactions.nothingRecordedFor(period: state.periodLabel.toLowerCase()),
        actionLabel: state.isCurrentPeriod ? null : t.transactions.goToToday,
        onAction: state.isCurrentPeriod ? null : onToday,
      ),
    );
  }
}
