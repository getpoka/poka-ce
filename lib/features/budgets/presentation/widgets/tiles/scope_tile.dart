import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/theme/theme.dart';

class ScopeTile extends StatelessWidget {
  const ScopeTile({
    required this.defaultIcon,
    required this.label,
    required this.value,
    required this.hasValue,
    required this.onTap,
    this.prefixWidget,
    this.onClear,
    super.key,
  });

  final IconData defaultIcon;
  final Widget? prefixWidget;
  final String label;
  final String value;
  final bool hasValue;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            prefixWidget ??
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: theme.colors.muted,
                    borderRadius: theme.style.borderRadius.sm,
                  ),
                  child: Center(
                    child: Icon(defaultIcon, size: 18, color: theme.colors.mutedForeground),
                  ),
                ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                  ),
                  Text(
                    value,
                    style: theme.typography.bodyPrimary.copyWith(
                      fontWeight: FontWeight.w500,
                      color: hasValue ? theme.colors.foreground : theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            if (hasValue && onClear != null)
              GestureDetector(
                onTap: () {
                  // Prevent the tap from bubbling up to the main tile
                  onClear!();
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Icon(FPhosphorIcons.x, size: 16, color: theme.colors.mutedForeground),
                ),
              )
            else
              Icon(FPhosphorIcons.caretRight, size: 14, color: theme.colors.mutedForeground),
          ],
        ),
      ),
    );
  }
}
