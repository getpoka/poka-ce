import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_hero_card.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtSummaryCard extends StatelessWidget {
  const DebtSummaryCard({required this.debts, required this.isPayable, super.key});

  final List<DebtModel> debts;
  final bool isPayable;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final debtColor = theme.colors.app.expense;
    final loanColor = theme.colors.app.income;
    final cardColor = isPayable ? debtColor : loanColor;

    var totalAmount = 0;
    var totalRemaining = 0;
    var paidCount = 0;

    for (final d in debts) {
      totalAmount += d.amount;
      totalRemaining += d.remainingAmount;
      if (d.status == DebtStatus.paid) paidCount++;
    }

    final overallProgress = totalAmount > 0 ? ((totalAmount - totalRemaining) / totalAmount).clamp(0.0, 1.0) : 0.0;

    return PokaHeroCard(
      cardColor: cardColor,
      pills: [
        PokaHeroCardPill(
          icon: isPayable ? FPhosphorIcons.arrowUpRight : FPhosphorIcons.arrowDownLeft,
          label: '${debts.length} ${isPayable ? 'owed' : 'receivable'}',
        ),
        if (paidCount > 0)
          PokaHeroCardPill(
            icon: FPhosphorIcons.checkCircle,
            label: t.debts.settled(count: paidCount),
          ),
      ],
      title: t.debts.outstanding,
      amount: PokaAmountText(
        amount: totalRemaining,
        type: isPayable ? TransactionType.expense : TransactionType.income,
        style: theme.typography.display.sm.copyWith(
          color: theme.colors.primaryForeground,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 1,
        ),
      ),
      progress: overallProgress,
      leftSubAmount: PokaHeroCardSubAmount(
        label: t.debts.paid,
        amount: totalAmount - totalRemaining,
        icon: FPhosphorIcons.checkCircle,
        type: isPayable ? TransactionType.expense : TransactionType.income,
      ),
      rightSubAmount: PokaHeroCardSubAmount(
        label: t.debts.principal,
        amount: totalAmount,
        icon: FPhosphorIcons.handshake,
        type: isPayable ? TransactionType.expense : TransactionType.income,
      ),
    );
  }
}
