import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

class SettingsMenuItem extends StatelessWidget with FItemMixin {
  const SettingsMenuItem({
    required this.title,
    required this.icon,
    this.subtitle,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FItem(
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.theme.typography.bodySecondary.copyWith(color: context.theme.colors.mutedForeground),
            )
          : null,
      prefix: PokaIcon(
        icon: icon,
        size: PokaIconSize.small,
      ),
      suffix: trailing ?? Icon(FPhosphorIcons.caretRight, color: context.theme.colors.mutedForeground),
      onPress: onTap,
    );
  }
}
