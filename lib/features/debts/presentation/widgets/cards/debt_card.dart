import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/debts/presentation/widgets/cards/components/debt_due_date_chip.dart';
import 'package:poka_ce/features/debts/presentation/widgets/cards/components/debt_progress_bar.dart';
import 'package:poka_ce/features/debts/presentation/widgets/cards/components/debt_status_chip.dart';
import 'package:poka_ce/features/debts/presentation/widgets/forms/debt_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_slidable_action.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtCard extends ConsumerWidget {
  const DebtCard({
    required this.debt,
    this.isInteractive = true,
    super.key,
  });

  final DebtModel debt;
  final bool isInteractive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isPayable = debt.type == DebtType.debt;
    final isPaid = debt.status == DebtStatus.paid;

    final debtColor = theme.colors.app.expense;
    final loanColor = theme.colors.app.income;
    final paidColor = theme.colors.app.success;

    final typeColor = isPaid ? paidColor : (isPayable ? debtColor : loanColor);
    final progress = debt.amount > 0 ? ((debt.amount - debt.remainingAmount) / debt.amount).clamp(0.0, 1.0) : 1.0;

    final cardContent = FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PokaIcon(
                  icon: isPaid
                      ? FPhosphorIcons.checkCircle
                      : (isPayable ? FPhosphorIcons.arrowUpRight : FPhosphorIcons.arrowDownLeft),
                  color: typeColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        debt.personName,
                        style: theme.typography.titleCard,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          DebtStatusChip(status: debt.status),
                          if (debt.dueDate != null && !isPaid) ...[
                            const SizedBox(width: 6),
                            DebtDueDateChip(dueDate: debt.dueDate!),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PokaAmountText(
                      amount: debt.remainingAmount,
                      type: isPayable ? TransactionType.expense : TransactionType.income,
                      style: theme.typography.amountCard,
                    ),
                    Text(
                      t.debts.remaining,
                      style: theme.typography.bodySecondary.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            DebtProgressBar(progress: progress, color: typeColor),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      t.debts.paid1,
                      style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                    ),
                    PokaAmountText(
                      amount: debt.amount - debt.remainingAmount,
                      type: TransactionType.income,
                      style: theme.typography.bodySecondary.copyWith(
                        color: theme.colors.mutedForeground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      t.debts.percentOf(percent: (progress * 100).toStringAsFixed(0)),
                      style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                    ),
                    PokaAmountText(
                      amount: debt.amount,
                      type: TransactionType.income,
                      style: theme.typography.bodySecondary.copyWith(
                        color: theme.colors.mutedForeground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (debt.note != null && debt.note!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colors.muted,
                  borderRadius: theme.style.borderRadius.sm,
                ),
                child: Row(
                  children: [
                    Icon(FPhosphorIcons.note, size: 13, color: theme.colors.mutedForeground),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        debt.note!,
                        style: theme.typography.bodySecondary.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );

    if (!isInteractive) {
      return cardContent;
    }

    return Slidable(
      key: ValueKey(debt.id),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.22,
        children: [
          PokaSlidableAction(
            icon: FPhosphorIcons.trash,
            color: theme.colors.destructive,
            isDestructive: true,
            onPressed: () {
              ref.read(debtListProvider.notifier).deleteDebtWithConfirmation(context, debt);
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.22,
        children: [
          PokaSlidableAction(
            icon: FPhosphorIcons.pencilSimple,
            color: theme.colors.primary,
            onPressed: () {
              DebtFormSheet.show(context, initialDebt: debt);
            },
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => DebtDetailRoute(debt.id, $extra: debt).push<void>(context),
        child: cardContent,
      ),
    );
  }
}
