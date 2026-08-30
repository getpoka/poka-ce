import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poka_ce/theme/theme.dart';

/// Wraps a list of pill chips in a horizontal scroll view, bleeding to the edges.
class PokaPillScrollRow extends StatelessWidget {
  const PokaPillScrollRow({
    required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.spacing = 6.0,
    super.key,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }
}

/// A selectable pill chip for an account, category, or generic filter item.
class PokaPill extends StatelessWidget {
  const PokaPill({
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
    this.isChild = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final bool isChild;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Child pills (e.g. subcategories, pockets) use slightly smaller padding.
    final padding = isChild
        ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 6);

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.15) : theme.colors.background,
          borderRadius: theme.style.borderRadius.lg,
          border: Border.all(
            color: isSelected ? color.withValues(alpha: 0.5) : theme.colors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? color : (isChild ? theme.colors.mutedForeground : color),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.typography.bodySecondary.copyWith(
                color: isSelected ? color : theme.colors.mutedForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
