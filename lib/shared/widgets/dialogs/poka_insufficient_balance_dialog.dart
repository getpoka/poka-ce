import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

/// Shows a warning confirmation dialog when transaction amount exceeds account balance.
///
/// Returns `true` if the user confirms to proceed anyway, `false` (or `null`) if cancelled.
///
/// - [accountName]       : Name of the wallet/account being deducted.
/// - [formattedAmount]   : Formatted transaction amount (e.g. "$50.00").
/// - [formattedBalance]  : Formatted current account balance (e.g. "$10.00").
/// - [confirmText]       : Optional override for confirm button label.
/// - [cancelText]        : Optional override for cancel button label.
Future<bool?> showPokaInsufficientBalanceDialog(
  BuildContext context, {
  required String accountName,
  required String formattedAmount,
  required String formattedBalance,
  String? confirmText,
  String? cancelText,
}) {
  return showFDialog<bool>(
    context: context,
    builder: (ctx, style, animation) => FDialog(
      animation: animation,
      builder: (dialogCtx, dialogStyle) {
        final theme = ctx.theme;
        final colors = theme.colors;
        final typography = theme.typography;
        final t = ctx.t.transactions;

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Warning icon
              Center(
                child: PokaIcon(
                  icon: FPhosphorIcons.warning,
                  shape: PokaIconShape.circle,
                  color: colors.app.warning,
                  size: PokaIconSize.hero,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                t.insufficientBalance,
                style: typography.display.sm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.foreground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Body explanation
              Text(
                t.insufficientBalanceWarning(
                  amount: formattedAmount,
                  account: accountName,
                  balance: formattedBalance,
                ),
                style: typography.body.md.copyWith(
                  color: colors.mutedForeground,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Note about negative balance
              Text(
                t.insufficientBalanceConsequence,
                style: typography.bodyPrimary.copyWith(
                  color: colors.app.warning,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Actions
              // Note: In forui 0.26, FButton places `child` directly inside an internal Row.
              // Flexible is required so the Row constrains the child; without it, FittedBox
              // receives unconstrained width (infinity) from the Row and overflows by 14px in tests.
              Row(
                children: [
                  Expanded(
                    child: FButton(
                      onPress: () => Navigator.of(ctx).pop(false),
                      variant: FButtonVariant.outline,
                      child: Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(cancelText ?? t.checkAgain),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FButton(
                      onPress: () => Navigator.of(ctx).pop(true),
                      child: Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(confirmText ?? t.continueAnyway),
                        ),
                      ),
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
