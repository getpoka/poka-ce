import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

/// Compact section header showing the date and daily income/expense totals.
class TransactionDateHeader extends StatelessWidget {
  const TransactionDateHeader({
    required this.dateStr,
    required this.income,
    required this.expense,
    this.isExpanded = true,
    this.itemCount = 0,
    this.onToggle,
    super.key,
  });

  final String dateStr;
  final int income;
  final int expense;
  final bool isExpanded;
  final int itemCount;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final total = income - expense;
    final totalType = total >= 0 ? TransactionType.income : TransactionType.expense;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onToggle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: theme.colors.primary,
              borderRadius: theme.style.borderRadius.xs,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dateStr,
                      style: theme.typography.titleItem,
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: isExpanded ? 0 : -0.25,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Icon(
                        FPhosphorIcons.caretDown,
                        size: 13,
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                    if (!isExpanded && itemCount > 0) ...[
                      const SizedBox(width: 6),
                      Text(
                        '•  ${t.transactions.itemsCount(count: itemCount)}',
                        style: theme.typography.caption.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ],
                  ],
                ),
                if (income > 0 || expense > 0) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      if (income > 0) ...[
                        Text(
                          t.transactions.incoming,
                          style: theme.typography.labelBadge.copyWith(
                            color: theme.colors.app.income,
                          ),
                        ),
                        PokaAmountText(
                          amount: income,
                          type: TransactionType.income,
                          style: theme.typography.amountTile,
                        ),
                      ],
                      if (income > 0 && expense > 0) const SizedBox(width: 8),
                      if (expense > 0) ...[
                        Text(
                          t.transactions.out,
                          style: theme.typography.labelBadge.copyWith(
                            color: theme.colors.app.expense,
                          ),
                        ),
                        PokaAmountText(
                          amount: expense,
                          type: TransactionType.expense,
                          style: theme.typography.amountTile,
                        ),
                      ],
                      const Spacer(),
                      if (total != 0) ...[
                        Icon(
                          FPhosphorIcons.sigma,
                          size: 12,
                          color: theme.colors.mutedForeground,
                        ),
                        const SizedBox(width: 4),
                        PokaAmountText(
                          amount: total.abs(),
                          type: totalType,
                          style: theme.typography.amountTile,
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
