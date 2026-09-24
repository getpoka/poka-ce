import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_toast.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bottom sheet dialog allowing users to reconcile their app account balance with real-world funds.
class AccountReconcileSheet extends HookConsumerWidget {
  /// Creates an [AccountReconcileSheet].
  const new({required this.account, required this.currentBalance, super.key});

  /// The target account or pocket to reconcile.
  final AccountModel account;

  /// The baseline balance currently tracked in Poka.
  final int currentBalance;

  /// Displays the [AccountReconcileSheet] inside a modal [PokaSheet].
  static Future<void> show(BuildContext context, {required AccountModel account, required int currentBalance}) {
    return showPokaSheet(
      context: context,
      persistent: true,
      builder: (context) => AccountReconcileSheet(account: account, currentBalance: currentBalance),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final accentColor = account.color?.toColor() ?? theme.colors.primary;
    final accountIcon = IconUtil.getIcon(account.icon);

    final precision = ref.watch(settingsProvider).settings?.baseCurrency?.precision ?? 0;
    final targetBalanceController = useTextEditingController(
      text: currentBalance.toMajorExpression(precision: precision),
    );
    final noteController = useTextEditingController();
    final targetBalanceState = useState<int>(currentBalance);
    final isSubmitting = useState<bool>(false);

    useEffect(() {
      void listener() {
        final parsed = targetBalanceController.text.toMinorUnits(precision: precision);
        targetBalanceState.value = parsed;
      }

      targetBalanceController.addListener(listener);
      return () => targetBalanceController.removeListener(listener);
    }, [targetBalanceController, precision]);

    final delta = targetBalanceState.value - currentBalance;

    Future<void> onSave() async {
      if (isSubmitting.value) return;
      isSubmitting.value = true;

      final useCase = ref.read(reconcileAccountBalanceUseCaseProvider);
      final result = await useCase.execute(
        account: account,
        currentBalance: currentBalance,
        targetBalance: targetBalanceState.value,
        note: noteController.text.trim().isNotEmpty ? noteController.text.trim() : null,
      );

      isSubmitting.value = false;

      if (!context.mounted) return;

      switch (result) {
        case Success():
          Navigator.of(context).pop();
        case ErrorResult(:final error):
          showPokaToast(context: context, title: Text(error.message), variant: FToastVariant.destructive);
      }
    }

    return PokaSheet(
      title: t.accounts.reconcileBalance,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Current Account info & balance card
          FCard(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  PokaIcon(icon: accountIcon, color: accentColor, size: PokaIconSize.small),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.name,
                          style: theme.typography.body.sm.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          t.accounts.currentBalanceInPoka,
                          style: theme.typography.caption.copyWith(color: theme.colors.mutedForeground),
                        ),
                      ],
                    ),
                  ),
                  PokaAmountText(
                    amount: currentBalance,
                    type: currentBalance >= 0 ? TransactionType.income : TransactionType.expense,
                    style: theme.typography.amountCard,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Target Balance Input
          FTextFormField(
            control: FTextFieldControl.managed(controller: targetBalanceController),
            label: Text(t.accounts.actualBalance),
            keyboardType: const TextInputType.numberWithOptions(signed: true),
          ),
          const SizedBox(height: 12),

          // Difference preview indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: delta == 0
                  ? theme.colors.muted
                  : delta < 0
                  ? theme.colors.destructive.withValues(alpha: 0.08)
                  : theme.colors.primary.withValues(alpha: 0.08),
              borderRadius: theme.style.borderRadius.md,
              border: Border.all(
                color: delta == 0
                    ? theme.colors.border
                    : delta < 0
                    ? theme.colors.destructive.withValues(alpha: 0.2)
                    : theme.colors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      delta == 0
                          ? FPhosphorIcons.checkCircle
                          : delta < 0
                          ? FPhosphorIcons.arrowDownRight
                          : FPhosphorIcons.arrowUpRight,
                      size: 16,
                      color: delta == 0
                          ? theme.colors.mutedForeground
                          : delta < 0
                          ? theme.colors.destructive
                          : theme.colors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      delta == 0
                          ? t.accounts.balancesMatch
                          : delta < 0
                          ? t.accounts.adjustmentExpense
                          : t.accounts.adjustmentIncome,
                      style: theme.typography.caption.copyWith(
                        color: delta == 0
                            ? theme.colors.mutedForeground
                            : delta < 0
                            ? theme.colors.destructive
                            : theme.colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (delta != 0)
                  PokaAmountText(
                    amount: delta.abs(),
                    type: delta < 0 ? TransactionType.expense : TransactionType.income,
                    style: theme.typography.body.sm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: delta < 0 ? theme.colors.destructive : theme.colors.primary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Optional note
          FTextFormField(
            control: FTextFieldControl.managed(controller: noteController),
            label: Text(t.accounts.noteOptional),
            hint: t.accounts.balanceAdjustment,
          ),
          const SizedBox(height: 20),

          // Save Button
          FButton(onPress: isSubmitting.value ? null : onSave, child: Text(t.accounts.saveAdjustment)),
        ],
      ),
    );
  }
}
