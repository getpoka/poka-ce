import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_calculator_keys.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/utils/math_evaluator.dart';
import 'package:poka_ce/theme/theme.dart';

class TransactionCalculatorNumpad extends StatelessWidget {
  const TransactionCalculatorNumpad({
    required this.value,
    required this.onKeyPressed,
    required this.typeColor,
    this.onTemplatePressed,
    this.showSplitButton = false,
    this.onSplitPressed,
    super.key,
  });

  /// The current math expression string to evaluate key presses against
  final String value;

  /// Called when the user presses any numpad key (including OK/Done)
  final ValueChanged<String> onKeyPressed;

  /// The active transaction type color — used to accent the Done key.
  final Color typeColor;

  /// Opens the transaction template list. When null the receipt key stays inert
  /// (e.g. in the split item editor where templates do not apply).
  final VoidCallback? onTemplatePressed;

  /// Whether to show the split transaction button.
  final bool showSplitButton;

  /// Callback when the split button is pressed.
  final VoidCallback? onSplitPressed;

  void _press(String key) {
    HapticFeedback.lightImpact();
    onKeyPressed(key);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final hasOperator = MathEvaluator.hasUnresolvedOperator(value);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: operators + backspace
          TransactionCalculatorRow(
            children: [
              TransactionCalculatorKey(
                label: '÷',
                theme: theme,
                variant: TransactionCalculatorKeyVariant.operator,
                onTap: () => _press('/'),
              ),
              TransactionCalculatorKey(key: const Key('numpad-7'), label: '7', theme: theme, onTap: () => _press('7')),
              TransactionCalculatorKey(key: const Key('numpad-8'), label: '8', theme: theme, onTap: () => _press('8')),
              TransactionCalculatorKey(key: const Key('numpad-9'), label: '9', theme: theme, onTap: () => _press('9')),
              TransactionCalculatorKey(
                theme: theme,
                variant: TransactionCalculatorKeyVariant.operator,
                icon: FPhosphorIcons.backspace,
                color: theme.colors.destructive,
                onTap: () => _press('⌫'),
                onLongPress: () {
                  HapticFeedback.mediumImpact();
                  _press('C'); // Clear all
                },
              ),
            ],
          ),
          // Row 2
          TransactionCalculatorRow(
            children: [
              TransactionCalculatorKey(
                label: '×',
                theme: theme,
                variant: TransactionCalculatorKeyVariant.operator,
                onTap: () => _press('*'),
              ),
              TransactionCalculatorKey(key: const Key('numpad-4'), label: '4', theme: theme, onTap: () => _press('4')),
              TransactionCalculatorKey(key: const Key('numpad-5'), label: '5', theme: theme, onTap: () => _press('5')),
              TransactionCalculatorKey(key: const Key('numpad-6'), label: '6', theme: theme, onTap: () => _press('6')),
              if (onTemplatePressed != null)
                TransactionCalculatorKey(
                  icon: FPhosphorIcons.receipt,
                  theme: theme,
                  variant: TransactionCalculatorKeyVariant.operator,
                  color: theme.colors.primary,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onTemplatePressed!();
                  },
                )
              else
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
          // Row 3
          TransactionCalculatorRow(
            children: [
              TransactionCalculatorKey(
                label: '−',
                theme: theme,
                variant: TransactionCalculatorKeyVariant.operator,
                onTap: () => _press('-'),
              ),
              TransactionCalculatorKey(key: const Key('numpad-1'), label: '1', theme: theme, onTap: () => _press('1')),
              TransactionCalculatorKey(key: const Key('numpad-2'), label: '2', theme: theme, onTap: () => _press('2')),
              TransactionCalculatorKey(key: const Key('numpad-3'), label: '3', theme: theme, onTap: () => _press('3')),
              if (showSplitButton && onSplitPressed != null)
                TransactionCalculatorKey(
                  icon: FPhosphorIcons.gitBranch,
                  theme: theme,
                  variant: TransactionCalculatorKeyVariant.operator,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onSplitPressed!();
                  },
                )
              else
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
          // Row 4
          TransactionCalculatorRow(
            children: [
              TransactionCalculatorKey(
                label: '+',
                theme: theme,
                variant: TransactionCalculatorKeyVariant.operator,
                onTap: () => _press('+'),
              ),
              TransactionCalculatorKey(label: t.transactions.empty, theme: theme, onTap: () => _press('+/-')),
              TransactionCalculatorKey(
                key: const Key('numpad-0'),
                label: '0',
                theme: theme,
                onTap: () => _press('0'),
                onLongPress: () {
                  HapticFeedback.mediumImpact();
                  _press('000');
                },
              ),
              TransactionCalculatorKey(label: '.', theme: theme, onTap: () => _press('.')),
              TransactionCalculatorActionKey(
                key: const Key('numpad-ok'),
                theme: theme,
                typeColor: typeColor,
                isEvaluate: hasOperator,
                onTap: () => _press(hasOperator ? '=' : 'OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
