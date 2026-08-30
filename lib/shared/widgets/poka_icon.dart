import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

enum PokaIconShape { circle, square }

/// Sizing scale for PokaIcon based on modern UI touch target guidelines.
enum PokaIconSize {
  /// Size: 36, Icon: 18. Best for dense lists (Settings/Menu Items).
  small,

  /// Size: 44, Icon: 22. Best for standard data rows (Transaction Categories).
  medium,

  /// Size: 52, Icon: 26. Best for primary touch targets (Quick Actions).
  large,

  /// Size: 64, Icon: 32. Best for large decorative focal points (Dialogs/Hero).
  hero,
}

class PokaIcon extends StatelessWidget {
  const PokaIcon({
    required this.icon,
    super.key,
    this.shape = PokaIconShape.square,
    this.size = PokaIconSize.medium,
    this.color,
    this.hasBorder = false,
    this.useThemeBorderColor = false,
  });

  final IconData icon;
  final PokaIconShape shape;
  final PokaIconSize size;
  final Color? color;
  final bool hasBorder;
  final bool useThemeBorderColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final effectiveColor = color ?? theme.colors.primary;

    // Determine dimensions based on semantic size scale
    double boxSize;
    double iconSize;

    switch (size) {
      case PokaIconSize.small:
        boxSize = 36;
        iconSize = 18;
      case PokaIconSize.medium:
        boxSize = 44;
        iconSize = 22;
      case PokaIconSize.large:
        boxSize = 52;
        iconSize = 26;
      case PokaIconSize.hero:
        boxSize = 64;
        iconSize = 32;
    }

    // Background alpha
    final bgColor = effectiveColor.withValues(alpha: 0.15);

    // Border color logic
    Color borderColor;
    if (useThemeBorderColor) {
      borderColor = theme.colors.border;
    } else {
      borderColor = effectiveColor.withValues(alpha: 0.25);
    }

    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: bgColor,
        shape: shape == PokaIconShape.circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: shape == PokaIconShape.square ? BorderRadius.circular(10) : null,
        border: hasBorder ? Border.all(color: borderColor) : null,
      ),
      child: Center(
        child: Icon(
          icon,
          color: effectiveColor,
          size: iconSize,
        ),
      ),
    );
  }
}
