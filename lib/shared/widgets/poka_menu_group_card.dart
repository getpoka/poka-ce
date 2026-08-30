import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

/// Flat section group card wrapping a list of menu rows.
///
/// Provides a consistent card surface with rounded corners and border,
/// clipping its children to prevent border radius overflow.
class PokaMenuGroupCard extends StatelessWidget {
  /// Creates a [PokaMenuGroupCard].
  const PokaMenuGroupCard({required this.child, super.key});

  /// The child widget — usually a group of menu rows or tiles.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.card,
        borderRadius: context.theme.style.borderRadius.lg,
        border: Border.all(color: context.theme.colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: FTheme(
        data: FThemeData(
          colors: context.theme.colors.copyWith(
            background: Colors.transparent,
          ),
          typography: context.theme.typography,
          style: context.theme.style,
          touch: true,
        ),
        child: child,
      ),
    );
  }
}

class PokaMenuItem {
  /// Creates a [PokaMenuItem].
  const PokaMenuItem({
    required this.icon,
    required this.title,
    required this.onPress,
    this.subtitle,
    this.suffix,
    this.iconAccentColor,
  });

  /// Leading icon displayed inside a tinted PokaMenuIcon container.
  final IconData icon;

  /// Primary label text for the menu row.
  final String title;

  /// Optional secondary label shown below [title] in muted foreground color.
  final String? subtitle;

  /// Optional trailing widget (e.g., FSwitch or a caret icon).
  final Widget? suffix;

  /// Callback invoked when the row is pressed.
  final VoidCallback onPress;

  /// Optional accent color override for the icon container. Defaults to primary.
  final Color? iconAccentColor;
}

class PokaMenuGroupLabel extends StatelessWidget {
  /// Creates a [PokaMenuGroupLabel].
  const PokaMenuGroupLabel(this.text, {super.key});

  /// The section label text (e.g., "Account", "Preferences").
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.only(bottom: context.theme.style.app.sm, top: context.theme.style.app.xs),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(
              color: theme.colors.primary,
              borderRadius: theme.style.borderRadius.xs,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text.toUpperCase(),
            style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}
