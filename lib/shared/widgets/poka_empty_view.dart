import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

/// A reusable empty-state widget styled to match [FTileGroup]'s outer border
/// using the same `RoundedSuperellipseBorder`, `colors.border`, and `style.borderRadius.lg`.
///
/// Usage:
/// ```dart
/// PokaEmptyView(
///   icon: FPhosphorIcons.piggyBank,
///   title: 'No goals yet',
///   subtitle: 'Start saving by creating your first goal.',
///   actionLabel: 'Create Goal',
///   onAction: () => GoalFormSheet.show(context),
/// )
/// ```
class PokaEmptyView extends StatelessWidget {
  const PokaEmptyView({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
    this.actionKey,
    this.hasBorder = false,
    super.key,
  }) : assert(
         (actionLabel == null) == (onAction == null),
         'actionLabel and onAction must both be provided or both be null.',
       );

  /// Phosphor icon data rendered in the icon well.
  final IconData icon;

  /// Short headline displayed below the icon.
  final String title;

  /// Supporting description beneath the title.
  final String subtitle;

  /// Label text for the optional primary CTA button.
  final String? actionLabel;

  /// Callback invoked when the CTA button is tapped.
  final VoidCallback? onAction;

  /// Optional key forwarded to the [FButton] for testing.
  final Key? actionKey;

  /// Whether to show a border around the empty view.
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final style = theme.style;
    final typography = theme.typography;

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          borderRadius: style.borderRadius.lg,
          side: hasBorder ? BorderSide(color: colors.border) : BorderSide.none,
        ),
        color: colors.card,
      ),
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // -- Icon well -------------------------------------------------------
          PokaIcon(
                icon: icon,
                size: PokaIconSize.hero,
                shape: PokaIconShape.circle,
              )
              .animate()
              .fade(duration: 400.ms)
              .scale(
                begin: const Offset(0.6, 0.6),
                end: const Offset(1, 1),
                curve: Curves.easeOutBack,
                duration: 500.ms,
              ),

          const SizedBox(height: 16),

          // -- Title -----------------------------------------------------------
          Text(
            title,
            textAlign: TextAlign.center,
            style: typography.titleItem.copyWith(color: colors.foreground),
          ).animate().fade(duration: 300.ms, delay: 100.ms).slideY(begin: 0.08, end: 0),

          const SizedBox(height: 6),

          // -- Subtitle --------------------------------------------------------
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: typography.bodyPrimary.copyWith(color: colors.mutedForeground),
          ).animate().fade(duration: 300.ms, delay: 160.ms),

          // -- CTA button ------------------------------------------------------
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 20),
            Builder(
              builder: (context) => FButton(
                key: actionKey,
                onPress: onAction,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(FPhosphorIcons.plus, size: 15),
                    const SizedBox(width: 6),
                    Text(actionLabel!),
                  ],
                ),
              ),
            ).animate().fade(duration: 300.ms, delay: 220.ms).slideY(begin: 0.06, end: 0),
          ],
        ],
      ),
    );
  }
}
