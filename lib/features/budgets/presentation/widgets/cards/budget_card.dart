import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_progress_provider.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/forms/budget_form_sheet.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_slidable_action.dart';
import 'package:poka_ce/theme/theme.dart';

class BudgetCard extends ConsumerWidget {
  const BudgetCard({
    required this.budget,
    this.isInteractive = true,
    super.key,
  });

  final BudgetModel budget;
  final bool isInteractive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final spentAsync = ref.watch(budgetProgressProvider(budget));
    final spent = spentAsync.asData?.value ?? 0;
    final progress = budget.amount > 0 ? (spent / budget.amount).clamp(0.0, 1.0) : 0.0;
    final isDanger = progress >= 1.0;
    final isWarning = progress > 0.8;
    final remaining = budget.amount - spent;

    final categoriesAsync = ref.watch(categoryListProvider);
    final category = budget.categoryId != null
        ? categoriesAsync.asData?.value.where((c) => c.id == budget.categoryId).firstOrNull
        : null;

    final accountsAsync = ref.watch(accountListProvider);
    final account = budget.accountId != null
        ? accountsAsync.asData?.value.accounts.where((a) => a.id == budget.accountId).firstOrNull
        : null;

    final progressColor = isDanger
        ? theme.colors.destructive
        : isWarning
        ? theme.colors.app.warning
        : theme.colors.primary;

    final cardContent = FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PokaIcon(
                  icon: category != null ? IconUtil.getIcon(category.icon) : FPhosphorIcons.chartPieSlice,
                  color: category != null ? (category.color?.toColor() ?? progressColor) : progressColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        budget.name,
                        style: theme.typography.titleCard,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          _PeriodBadge(period: budget.period),
                          if (category != null || account != null) ...[
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                [
                                  if (category != null) category.name,
                                  if (account != null) account.name,
                                ].join(' • '),
                                style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PokaAmountText(
                      amount: remaining.abs(),
                      type: remaining >= 0 ? TransactionType.income : TransactionType.expense,
                      style: theme.typography.amountCard,
                    ),
                    Text(
                      remaining >= 0 ? 'left' : 'over',
                      style: theme.typography.bodySecondary.copyWith(
                        color: remaining >= 0 ? theme.colors.mutedForeground : theme.colors.destructive,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            _ProgressBar(progress: progress, color: progressColor),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      t.budgets.spent,
                      style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                    ),
                    PokaAmountText(
                      amount: spent,
                      type: TransactionType.expense,
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
                      t.budgets.percentOf(percent: (progress * 100).toStringAsFixed(0)),
                      style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                    ),
                    PokaAmountText(
                      amount: budget.amount,
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
          ],
        ),
      ),
    );

    if (!isInteractive) {
      return cardContent;
    }

    return Slidable(
      key: ValueKey(budget.id),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.22,
        children: [
          PokaSlidableAction(
            icon: FPhosphorIcons.trash,
            color: theme.colors.destructive,
            isDestructive: true,
            onPressed: () async {
              final confirm = await showPokaConfirmDialog(
                context,
                title: t.budgets.deleteBudget,
                body: t
                    .budgets
                    .areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone,
                confirmText: t.budgets.delete,
              );
              if (confirm == true) {
                unawaited(ref.read(budgetListProvider.notifier).deleteBudget(budget.id));
              }
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
              BudgetFormSheet.show(context, initialBudget: budget);
            },
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => BudgetDetailRoute(budget.id, $extra: budget).push<void>(context),
        child: cardContent,
      ),
    );
  }
}

class _PeriodBadge extends StatelessWidget {
  const _PeriodBadge({required this.period});

  final BudgetPeriod period;

  String get _label => switch (period) {
    BudgetPeriod.monthly => 'Monthly',
    BudgetPeriod.weekly => 'Weekly',
    BudgetPeriod.yearly => 'Yearly',
    BudgetPeriod.custom => 'Custom',
  };

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Text(
        _label.toUpperCase(),
        style: theme.typography.labelBadge.copyWith(color: theme.colors.mutedForeground),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: 6,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (_, value, _) => FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
