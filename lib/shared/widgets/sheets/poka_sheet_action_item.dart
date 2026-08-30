import 'package:flutter/material.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

class PokaSheetActionItem extends StatelessWidget with FItemMixin {
  const PokaSheetActionItem({
    required this.title,
    required this.icon,
    this.subtitle,
    this.trailing,
    this.iconColor,
    this.titleColor,
    this.onTap,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;

  /// Optional override for the icon box color. Defaults to the theme primary.
  final Color? iconColor;

  /// Optional override for the title text color. Useful for destructive actions.
  final Color? titleColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FItem(
      title: Text(
        title,
        style: titleColor != null ? context.theme.typography.titleItem.copyWith(color: titleColor) : null,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: context.theme.typography.bodySecondary,
            )
          : null,
      prefix: PokaIcon(
        icon: icon,
        size: PokaIconSize.small,
        color: iconColor,
      ),
      suffix: trailing,
      onPress: onTap,
    );
  }
}
