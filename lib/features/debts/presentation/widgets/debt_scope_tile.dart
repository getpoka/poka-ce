import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtScopeTile extends StatelessWidget {
  const DebtScopeTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.hasValue,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool hasValue;
  final VoidCallback onTap;

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
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: theme.colors.muted,
                borderRadius: theme.style.borderRadius.sm,
              ),
              child: Center(
                child: Icon(icon, size: 16, color: theme.colors.mutedForeground),
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
            Icon(FPhosphorIcons.caretRight, size: 14, color: theme.colors.mutedForeground),
          ],
        ),
      ),
    );
  }
}
