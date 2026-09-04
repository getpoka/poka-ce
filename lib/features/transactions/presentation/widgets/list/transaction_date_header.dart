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
    super.key,
  });

  final String dateStr;
  final int income;
  final int expense;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final total = income - expense;
    final totalType = total >= 0 ? TransactionType.income : TransactionType.expense;

    return Row(
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
              Text(
                dateStr,
                style: theme.typography.bodyPrimary.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              if (income > 0 || expense > 0) ...[
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (income > 0) ...[
                      Text(
                        t.transactions.incoming,
                        style: theme.typography.bodySecondary.copyWith(color: theme.colors.app.income),
                      ),
                      PokaAmountText(
                        amount: income,
                        type: TransactionType.income,
                        style: theme.typography.caption,
                      ),
                    ],
                    if (income > 0 && expense > 0) const SizedBox(width: 8),
                    if (expense > 0) ...[
                      Text(
                        t.transactions.out,
                        style: theme.typography.bodySecondary.copyWith(color: theme.colors.app.expense),
                      ),
                      PokaAmountText(
                        amount: expense,
                        type: TransactionType.expense,
                        style: theme.typography.caption,
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
                        style: theme.typography.caption,
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
