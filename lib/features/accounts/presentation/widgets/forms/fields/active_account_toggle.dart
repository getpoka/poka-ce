import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_switch.dart';
import 'package:poka_ce/theme/theme.dart';

class ActiveAccountToggle extends StatelessWidget {
  const ActiveAccountToggle({
    required this.isActive,
    required this.onChanged,
    super.key,
  });

  final bool isActive;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: context.theme.colors.muted.withValues(alpha: 0.4),
        borderRadius: context.theme.style.borderRadius.md,
        border: Border.all(color: context.theme.colors.border),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isActive
                  ? context.theme.colors.primary.withValues(alpha: 0.12)
                  : context.theme.colors.muted.withValues(alpha: 0.6),
              borderRadius: context.theme.style.borderRadius.sm,
            ),
            child: Icon(
              isActive ? FPhosphorIcons.checkCircle : FPhosphorIcons.pause,
              size: 18,
              color: isActive ? context.theme.colors.primary : context.theme.colors.mutedForeground,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.accounts.activeAccount,
                  style: context.theme.typography.titleCard,
                ),
                const SizedBox(height: 1),
                Text(
                  t.accounts.inactiveAccountsWillBeHidden,
                  style: context.theme.typography.bodySecondary.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          PokaSwitch(
            value: isActive,
            onChange: onChanged,
          ),
        ],
      ),
    );
  }
}
