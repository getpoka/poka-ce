import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/theme/theme.dart';

class PinDots extends StatelessWidget {
  const PinDots({
    required this.pinLength,
    super.key,
    this.maxLength = 6,
  });

  final int pinLength;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxLength, (index) {
        final isFilled = index < pinLength;
        return AnimatedScale(
          scale: isFilled && index == pinLength - 1 ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutBack,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFilled ? context.theme.colors.primary : context.theme.colors.muted,
              border: Border.all(
                color: isFilled
                    ? context.theme.colors.primary
                    : context.theme.colors.mutedForeground.withValues(alpha: 0.3),
              ),
            ),
          ),
        );
      }),
    );
  }
}
