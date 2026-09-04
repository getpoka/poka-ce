import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/theme/theme.dart';

/// A widget that displays a monetary amount with color-coding based on transaction type.
/// Income is green (or primary/positive), Expense is red (destructive), Transfer is default.
class PokaAmountText extends ConsumerWidget {
  /// Creates a PokaAmountText.
  const PokaAmountText({
    required this.amount,
    required this.type,
    this.style,
    this.fallbackCurrencySymbol = 'Rp',
    this.isObscured = false,
    super.key,
  });

  /// Whether to obscure the amount value (e.g. for privacy toggle).
  final bool isObscured;

  /// The amount in integer format.
  final int amount;

  /// The type of transaction which determines the text color and sign.
  final TransactionType type;

  /// The base text style to use. Color will be overridden based on [type].
  final TextStyle? style;

  /// Fallback currency symbol if settings are not loaded yet.
  final String fallbackCurrencySymbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final currency = settingsState.settings?.baseCurrency;
    final currencySymbol = currency?.symbol ?? fallbackCurrencySymbol;
    final precision = currency?.precision ?? 0;
    final localeFormat = settingsState.settings?.numberFormat ?? 'system';
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);

    var prefix = '';
    var color = context.theme.colors.foreground;

    switch (type) {
      case TransactionType.income:
        prefix = '+ ';
        color = context.theme.colors.app.income;
      case TransactionType.expense:
        prefix = '- ';
        color = context.theme.colors.app.expense;
      case TransactionType.transfer:
        prefix = '';
        color = context.theme.colors.foreground; // or context.theme.colors.app.transfer if wanted, but transfer amount is usually neutral foreground unless specified
    }

    final shouldObscure = isObscured || !isBalanceVisible;

    final rawBaseStyle = style ?? context.theme.typography.amountTile;
    final baseStyle = rawBaseStyle.copyWith(
      fontFeatures: [
        ...?rawBaseStyle.fontFeatures?.where((f) => f.feature != 'tnum'),
        const FontFeature.tabularFigures(),
      ],
    );
    final hasExplicitColor = style?.color != null && style!.color != context.theme.colors.foreground;

    final effectiveStyle = hasExplicitColor ? baseStyle : baseStyle.copyWith(color: color);

    return Text(
      shouldObscure
          ? '$prefix••••••'
          : '$prefix${amount.abs().toCurrencyFormat(symbol: currencySymbol, precision: precision, locale: localeFormat)}',
      style: effectiveStyle,
    );
  }
}
