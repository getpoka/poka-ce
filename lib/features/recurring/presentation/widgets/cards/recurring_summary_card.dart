import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_hero_card.dart';
import 'package:poka_ce/theme/theme.dart';

class RecurringSummaryCard extends StatelessWidget {
  const RecurringSummaryCard({required this.recurrings, super.key});

  final List<RecurringTransactionModel> recurrings;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    var monthlyExpense = 0;
    var monthlyIncome = 0;
    var activeCount = 0;

    for (final r in recurrings) {
      if (!r.isActive) continue;
      activeCount++;
      final monthly = _toMonthlyAmount(r.amount, r.period);
      if (r.type == TransactionType.income) {
        monthlyIncome += monthly;
      } else if (r.type == TransactionType.expense) {
        monthlyExpense += monthly;
      }
    }

    final netMonthly = monthlyIncome - monthlyExpense;

    return PokaHeroCard(
      pills: [
        PokaHeroCardPill(
          icon: FPhosphorIcons.repeat,
          label: t.recurring.schedulesCount(count: recurrings.length),
        ),
        if (activeCount < recurrings.length)
          PokaHeroCardPill(
            icon: FPhosphorIcons.pause,
            label: t.recurring.pausedCount(count: recurrings.length - activeCount),
          ),
      ],
      title: t.recurring.estMonthlyNet,
      amount: PokaAmountText(
        amount: netMonthly.abs(),
        type: netMonthly >= 0 ? TransactionType.income : TransactionType.expense,
        style: theme.typography.display.sm.copyWith(
          color: theme.colors.primaryForeground,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 1,
        ),
      ),
      leftSubAmount: PokaHeroCardSubAmount(
        label: t.recurring.monthlyIn,
        amount: monthlyIncome,
        icon: FPhosphorIcons.arrowDown,
        type: TransactionType.income,
      ),
      rightSubAmount: PokaHeroCardSubAmount(
        label: t.recurring.monthlyOut,
        amount: monthlyExpense,
        icon: FPhosphorIcons.arrowUp,
        type: TransactionType.expense,
      ),
    );
  }

  /// Converts [amount] to a monthly equivalent for the given [period].
  int _toMonthlyAmount(int amount, RecurringPeriod period) => switch (period) {
    RecurringPeriod.daily => amount * 30,
    RecurringPeriod.weekly => amount * 4,
    RecurringPeriod.monthly => amount,
    RecurringPeriod.yearly => (amount / 12).round(),
  };
}
