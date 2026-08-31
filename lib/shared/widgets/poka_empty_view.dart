import 'dart:async';

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
    this.subtitle,
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
  final String? subtitle;

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
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
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

            // -- Subtitle --------------------------------------------------------
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: typography.bodyPrimary.copyWith(color: colors.mutedForeground),
              ).animate().fade(duration: 300.ms, delay: 160.ms),
            ],

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
      ),
    );
  }
}

/// A wrapper around [PokaEmptyView] that guarantees the empty state is vertically
/// centered relative to the ENTIRE physical screen (from top edge to bottom edge).
///
/// It uses a [GlobalKey] to measure its exact Y-coordinate and dynamically sets
/// its height so that the [Center] widget places the content exactly at `screenHeight / 2`.
class PokaEmptyViewCentered extends StatefulWidget {
  const PokaEmptyViewCentered({
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.actionKey,
    super.key,
  }) : assert(
         (actionLabel == null) == (onAction == null),
         'actionLabel and onAction must both be provided or both be null.',
       );

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Key? actionKey;

  @override
  State<PokaEmptyViewCentered> createState() => _PokaEmptyViewCenteredState();
}

class _PokaEmptyViewCenteredState extends State<PokaEmptyViewCentered> {
  final GlobalKey _key = GlobalKey();
  double? _yOffset;
  Timer? _animTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_checkOffset);

    // Parent widgets (like lists) often have entry animations (e.g. slideY for 300ms).
    // Because those animations use Transform and don't rebuild this widget,
    // the initial offset we measure might be wrong (shifted down).
    // We poll a few times during the first 500ms to catch its final resting position.
    _animTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback(_checkOffset);
      }
      if (timer.tick >= 5) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _animTimer?.cancel();
    super.dispose();
  }

  void _checkOffset(_) {
    if (!mounted) return;
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      // Only rebuild if the offset changed by more than 1 pixel (prevents oscillation)
      if (_yOffset == null || (_yOffset! - position.dy).abs() > 1.0) {
        setState(() {
          _yOffset = position.dy;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_checkOffset);
    final screenHeight = MediaQuery.sizeOf(context).height;

    final child = PokaEmptyView(
      icon: widget.icon,
      title: widget.title,
      subtitle: widget.subtitle,
      actionLabel: widget.actionLabel,
      onAction: widget.onAction,
      actionKey: widget.actionKey,
    );

    // Initial guess to prevent extreme layout shifts before the first frame is measured
    var height = screenHeight * 0.55;

    if (_yOffset != null) {
      // Calculate how far the top of this widget is from the exact center of the screen
      final distanceToCenter = (screenHeight / 2) - _yOffset!;

      if (distanceToCenter > 50) {
        // By making the container exactly twice the distance to the center,
        // the Center() widget will push the empty state exactly to screenHeight / 2.
        height = distanceToCenter * 2;
      } else {
        // Fallback for detail pages where the empty state is placed very low (below a hero card).
        height = 300;
      }
    }

    // Align.topCenter prevents FScaffold from auto-centering the SizedBox
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        key: _key,
        height: height,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
