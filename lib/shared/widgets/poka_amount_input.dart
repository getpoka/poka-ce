import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_numpad.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

/// PokaAmountInput is a custom input field for entering currency amounts.
/// Tapping it opens a bottom sheet with a Numpad for numeric entry.
class PokaAmountInput extends StatefulWidget {
  /// Creates a PokaAmountInput.
  const PokaAmountInput({
    required this.amount,
    required this.onAmountChanged,
    required this.type,
    super.key,
  });

  /// The current amount to display.
  final int amount;

  /// Callback when the amount is confirmed in the Numpad.
  final ValueChanged<int> onAmountChanged;

  /// The transaction type, which dictates the color coding.
  final TransactionType type;

  @override
  State<PokaAmountInput> createState() => _PokaAmountInputState();
}

class _PokaAmountInputState extends State<PokaAmountInput> {
  void _showNumpad(BuildContext context) {
    var currentAmount = widget.amount;

    showPokaSheet<void>(
      context: context,
      builder: (context) => PokaSheet(
        title: t.shared.enterAmount,
        child: StatefulBuilder(
          builder: (context, setStateSheet) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: PokaAmountText(
                      amount: currentAmount,
                      type: widget.type,
                      style: context.theme.typography.amountSection,
                    ),
                  ),
                ),
                PokaNumpad(
                  onNumberPressed: (number) {
                    setStateSheet(() {
                      currentAmount = currentAmount * 10 + number;
                    });
                  },
                  onBackspacePressed: () {
                    setStateSheet(() {
                      currentAmount = currentAmount ~/ 10;
                    });
                  },
                  onConfirmPressed: () {
                    widget.onAmountChanged(currentAmount);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showNumpad(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: context.theme.colors.background,
          border: Border.all(color: context.theme.colors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.shared.amount,
              style: context.theme.typography.bodyPrimary.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            ),
            PokaAmountText(
              amount: widget.amount,
              type: widget.type,
              style: context.theme.typography.titleCard,
            ),
          ],
        ),
      ),
    );
  }
}
