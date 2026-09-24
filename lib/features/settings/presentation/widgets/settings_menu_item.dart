import 'package:flutter/material.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

class SettingsMenuItem extends StatelessWidget with FItemMixin {
  const new({
    required this.title,
    required this.icon,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.enabled = true,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final item = FItem(
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.theme.typography.bodySecondary.copyWith(color: context.theme.colors.mutedForeground),
            )
          : null,
      prefix: PokaIcon(icon: icon, size: PokaIconSize.small),
      suffix: trailing ?? Icon(FPhosphorIcons.caretRight, color: context.theme.colors.mutedForeground),
      onPress: onTap,
    );

    if (!enabled) {
      return Opacity(opacity: 0.5, child: item);
    }

    return item;
  }
}
