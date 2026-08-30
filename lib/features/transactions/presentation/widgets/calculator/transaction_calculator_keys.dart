/// Defines the layout and individual keys for the calculator numpad.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

// ─── Layout helpers ───────────────────────────────────────────────────────────

class TransactionCalculatorRow extends StatelessWidget {
  const TransactionCalculatorRow({required this.children, super.key});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 56,
    child: Row(children: children),
  );
}

// ─── Key variants ─────────────────────────────────────────────────────────────

enum TransactionCalculatorKeyVariant { number, operator }

class TransactionCalculatorKey extends HookWidget {
  const TransactionCalculatorKey({
    required this.theme,
    required this.onTap,
    this.label,
    this.icon,
    this.variant = TransactionCalculatorKeyVariant.number,
    this.color,
    this.onLongPress,
    super.key,
  }) : assert(label != null || icon != null, 'Provide label or icon');

  final FThemeData theme;
  final String? label;
  final IconData? icon;
  final TransactionCalculatorKeyVariant variant;
  final Color? color;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final isOperator = variant == TransactionCalculatorKeyVariant.operator;
    final fg = color ?? (isOperator ? theme.colors.mutedForeground : theme.colors.foreground);
    final isPressed = useState(false);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4), // approx theme.style.app.xs / 2
        child: AnimatedScale(
          scale: isPressed.value ? 0.92 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutQuad,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.border),
              borderRadius: BorderRadius.circular(8),
              color: isPressed.value ? theme.colors.muted.withValues(alpha: 0.5) : Colors.transparent,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) => isPressed.value = true,
              onTapUp: (_) => isPressed.value = false,
              onTapCancel: () => isPressed.value = false,
              onTap: () {
                HapticFeedback.lightImpact();
                onTap();
              },
              onLongPress: onLongPress,
              child: Center(
                child: icon != null
                    ? Icon(icon, size: 20, color: fg)
                    : Text(
                        label!,
                        style: theme.typography.body.lg.copyWith(
                          color: fg,
                          fontWeight: isOperator ? FontWeight.w400 : FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionCalculatorActionKey extends HookWidget {
  const TransactionCalculatorActionKey({
    required this.theme,
    required this.typeColor,
    required this.isEvaluate,
    required this.onTap,
    super.key,
  });

  final FThemeData theme;
  final Color typeColor;
  final bool isEvaluate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isPressed = useState(false);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: AnimatedScale(
          scale: isPressed.value ? 0.92 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutQuad,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.border),
              borderRadius: BorderRadius.circular(8),
              color: isPressed.value ? theme.colors.muted.withValues(alpha: 0.5) : Colors.transparent,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) => isPressed.value = true,
              onTapUp: (_) => isPressed.value = false,
              onTapCancel: () => isPressed.value = false,
              onTap: () {
                HapticFeedback.lightImpact();
                onTap();
              },
              child: Center(
                child: isEvaluate
                    ? Text(
                        '=',
                        style: theme.typography.body.lg.copyWith(
                          color: theme.colors.foreground,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Icon(
                        FPhosphorIcons.check,
                        size: 20,
                        color: typeColor,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
