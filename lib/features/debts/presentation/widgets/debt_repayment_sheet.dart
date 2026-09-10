import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/pickers/account_selector_shelf.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_repayment_notifier.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_amount_display.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_calculator_numpad.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_date_nav.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtRepaymentSheet extends HookConsumerWidget {
  const DebtRepaymentSheet({
    required this.debt,
    super.key,
  });

  final DebtModel debt;

  static Future<bool?> show(BuildContext context, DebtModel debt) {
    return showPokaSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => PokaSheet(
        title: t.debts.addRepayment,
        padding: EdgeInsets.zero,
        child: DebtRepaymentSheet(debt: debt),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final accounts = ref.watch(dashboardProvider).accounts;
    final state = ref.watch(debtRepaymentProvider);
    final notifier = ref.read(debtRepaymentProvider.notifier);
    final settings = ref.watch(settingsProvider).settings;
    final currencyCode = settings?.baseCurrency?.symbol;

    useEffect(() {
      if (accounts.isNotEmpty && state.accountId == null) {
        Future.microtask(() => notifier.setAccountId(accounts.first.id));
      }
      return null;
    }, [accounts]);

    // For debt (we borrowed), repayment means our money goes OUT (Expense).
    // For loan (we lent), repayment means money comes IN (Income).
    final isPayable = debt.type == DebtType.debt;
    final typeColor = isPayable ? theme.colors.app.expense : theme.colors.app.income;
    final currentAmount = int.tryParse(state.amountExpression) ?? 0;
    final isFullAmount = currentAmount == debt.remainingAmount && debt.remainingAmount > 0;

    Future<void> handleSave() async {
      final amount = int.tryParse(state.amountExpression) ?? 0;
      if (amount > debt.remainingAmount) {
        if (context.mounted) {
          await showFDialog<void>(
            context: context,
            builder: (ctx, style, animation) => FDialog(
              animation: animation,
              builder: (dialogCtx, dialogStyle) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.debts.actionDenied,
                        style: ctx.theme.typography.display.sm.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        t.debts.paymentCannotExceedRemaining,
                        style: ctx.theme.typography.body.md,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      FButton(onPress: () => Navigator.of(ctx).pop(), child: Text(t.debts.ok)),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return;
      }

      final success = await notifier.saveRepayment(debt: debt);
      if (success && context.mounted) {
        Navigator.of(context).pop(true);
      }
    }

    Future<void> showNoteEditor() async {
      final controller = TextEditingController(text: state.note);
      await showFDialog<void>(
        context: context,
        builder: (ctx, style, animation) => FDialog(
          animation: animation,
          builder: (dialogCtx, dialogStyle) {
            final dialogTheme = ctx.theme;
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.debts.addNote,
                    style: dialogTheme.typography.display.sm.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 14),
                  FTextField(
                    focusNode: FocusNode()..requestFocus(),
                    control: FTextFieldControl.managed(controller: controller),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: FButton(
                          onPress: () => Navigator.of(ctx).pop(),
                          variant: FButtonVariant.outline,
                          child: Text(t.debts.cancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FButton(
                          onPress: () {
                            notifier.setNote(controller.text.trim());
                            Navigator.of(ctx).pop();
                          },
                          child: Text(t.debts.save),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              TransactionDateNav(
                selectedDate: state.date,
                onStepDate: (step) {
                  notifier.setDate(state.date.add(Duration(days: step)));
                },
                onDateChanged: notifier.setDate,
                onTimeChanged: notifier.setDate,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        AccountSelectorShelf(
          accounts: accounts,
          selectedAccountId: state.accountId,
          onAccountSelected: (acc) => notifier.setAccountId(acc.id),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 14),
              TransactionAmountDisplay(
                amountExpression: state.amountExpression,
                historyExpression: state.historyExpression,
                currencyCode: currencyCode,
              ),
              _DebtRepaymentMetaBar(
                note: state.note,
                isFullAmount: isFullAmount,
                typeColor: typeColor,
                remainingAmount: debt.remainingAmount,
                onPickNote: showNoteEditor,
                onPayInFull: () {
                  HapticFeedback.selectionClick();
                  if (isFullAmount) {
                    notifier
                      ..setAmountExpression('0')
                      ..setHistoryExpression(null);
                  } else {
                    notifier
                      ..setAmountExpression(debt.remainingAmount.toString())
                      ..setHistoryExpression(null);
                  }
                },
              ),
              const SizedBox(height: 6),
              if (state.isSaving)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: FCircularProgress()),
                )
              else
                TransactionCalculatorNumpad(
                  value: state.amountExpression,
                  onKeyPressed: (key) {
                    if (key == 'OK') {
                      HapticFeedback.mediumImpact();
                      handleSave();
                    } else {
                      notifier.onKeyPressed(key);
                    }
                  },
                  typeColor: typeColor,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Meta bar component rendering note trigger and quick "Pay in Full" action.
class _DebtRepaymentMetaBar extends StatelessWidget {
  const _DebtRepaymentMetaBar({
    required this.note,
    required this.isFullAmount,
    required this.typeColor,
    required this.remainingAmount,
    required this.onPickNote,
    required this.onPayInFull,
  });

  final String note;
  final bool isFullAmount;
  final Color typeColor;
  final int remainingAmount;
  final VoidCallback onPickNote;
  final VoidCallback onPayInFull;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 6),
      child: SizedBox(
        height: 32,
        child: Row(
          children: [
            // Note Section
            Expanded(
              child: GestureDetector(
                onTap: onPickNote,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Icon(
                      FPhosphorIcons.notePencil,
                      size: 18,
                      color: note.isEmpty ? theme.colors.mutedForeground : theme.colors.foreground,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        note.isEmpty ? t.transactions.addNoteEllipsis : note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.typography.bodyPrimary.copyWith(
                          color: note.isEmpty ? theme.colors.mutedForeground : theme.colors.foreground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (remainingAmount > 0) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onPayInFull,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isFullAmount ? typeColor.withValues(alpha: 0.15) : theme.colors.background,
                    borderRadius: theme.style.borderRadius.lg,
                    border: Border.all(
                      color: isFullAmount ? typeColor.withValues(alpha: 0.5) : theme.colors.border,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FPhosphorIcons.lightning,
                        size: 16,
                        color: isFullAmount ? typeColor : theme.colors.mutedForeground,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        t.debts.payInFull,
                        style: theme.typography.bodySecondary.copyWith(
                          color: isFullAmount ? typeColor : theme.colors.mutedForeground,
                          fontWeight: isFullAmount ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
