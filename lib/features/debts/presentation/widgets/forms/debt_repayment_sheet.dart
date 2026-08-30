import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/pickers/account_selector_shelf.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_repayment_notifier.dart';
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
                        t.debts.jumlahPembayaranTidakBolehMelebihiSisaUtang,
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
                          child: Text(t.transactions.cancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FButton(
                          onPress: () {
                            notifier.setNote(controller.text.trim());
                            Navigator.of(ctx).pop();
                          },
                          child: Text(t.transactions.save),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(),
                  if (debt.remainingAmount > 0)
                    FButton(
                      variant: FButtonVariant.outline,
                      onPress: () {
                        HapticFeedback.lightImpact();
                        notifier
                          ..setAmountExpression(debt.remainingAmount.toString())
                          ..setHistoryExpression(null);
                      },
                      child: Text(
                        t.debts.payInFull,
                        style: theme.typography.bodyPrimary.copyWith(color: typeColor),
                      ),
                    ),
                ],
              ),
              TransactionAmountDisplay(
                amountExpression: state.amountExpression,
                historyExpression: state.historyExpression,
              ),
              const SizedBox(height: 14),
              if (state.note.isNotEmpty)
                GestureDetector(
                  onTap: showNoteEditor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: theme.colors.muted,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      state.note,
                      style: theme.typography.bodyPrimary,
                    ),
                  ),
                ),
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
