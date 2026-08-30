import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

/// A summary card for a transaction that has split items.
class TransactionSplitSummaryCard extends StatelessWidget {
  const TransactionSplitSummaryCard({
    required this.splits,
    required this.transactionType,
    required this.onEdit,
    required this.onClear,
    super.key,
  });

  final List<SplitItem> splits;
  final TransactionType transactionType;
  final VoidCallback onEdit;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final total = splits.fold(0, (sum, item) => sum + item.amount);

    return FTileGroup(
      children: [
        FTile(
          prefix: Icon(FPhosphorIcons.arrowsSplit, color: theme.colors.primary),
          title: Text(
            t.transactions.splitItems(count: splits.length),
            style: theme.typography.titleCard,
          ),
          subtitle: PokaAmountText(
            amount: total,
            type: transactionType,
            style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FButton.icon(
                onPress: onEdit,
                variant: FButtonVariant.ghost,
                child: const Icon(FPhosphorIcons.pencilSimple, size: 18),
              ),
              FButton.icon(
                onPress: onClear,
                variant: FButtonVariant.ghost,
                child: Icon(FPhosphorIcons.x, size: 18, color: theme.colors.destructive),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
