import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

/// A custom Numpad widget designed for entering amounts in transactions.
/// It features a grid of numbers and action buttons (like backspace and confirm).
class PokaNumpad extends StatelessWidget {
  /// Creates a PokaNumpad.
  const PokaNumpad({
    required this.onNumberPressed,
    required this.onBackspacePressed,
    required this.onConfirmPressed,
    super.key,
  });

  /// Callback when a number button is pressed (0-9).
  final ValueChanged<int> onNumberPressed;

  /// Callback when the backspace button is pressed.
  final VoidCallback onBackspacePressed;

  /// Callback when the confirm button is pressed.
  final VoidCallback onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(context, [1, 2, 3]),
          const SizedBox(height: 16),
          _buildRow(context, [4, 5, 6]),
          const SizedBox(height: 16),
          _buildRow(context, [7, 8, 9]),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                context: context,
                child: const Icon(FPhosphorIcons.backspace),
                onPressed: onBackspacePressed,
              ),
              _buildNumberButton(context, 0),
              _buildActionButton(
                context: context,
                child: const Icon(FPhosphorIcons.check),
                onPressed: onConfirmPressed,
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<int> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((n) => _buildNumberButton(context, n)).toList(),
    );
  }

  Widget _buildNumberButton(BuildContext context, int number) {
    return FButton(
      onPress: () => onNumberPressed(number),
      child: Text(
        number.toString(),
        style: context.theme.typography.body.xl.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return FButton(
      onPress: onPressed,
      child: child,
    );
  }
}
