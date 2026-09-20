import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

/// Progress bar for budgets and utilization with smooth animation support.
class ReportProgressBar extends StatelessWidget {
  /// Creates a [ReportProgressBar].
  const new({required this.progress, required this.color, this.animated = true, super.key});

  /// The normalized progress value between 0.0 and 1.0.
  final double progress;

  /// The color of the active progress bar indicator.
  final Color color;

  /// Whether changes to [progress] should animate.
  final bool animated;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: 5,
        width: constraints.maxWidth,
        decoration: BoxDecoration(color: theme.colors.muted, borderRadius: BorderRadius.circular(3)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: animated
              ? TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (_, value, _) => FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                )
              : FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
                  ),
                ),
        ),
      ),
    );
  }
}
