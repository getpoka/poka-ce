import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

/// A lightweight, custom-painted sparkline widget for displaying smooth trend curves.
/// Designed specifically for background layering in hero cards and summary panels.
class PokaSparkline extends StatelessWidget {
  /// Creates a [PokaSparkline].
  const PokaSparkline({
    required this.points,
    this.lineColor,
    this.fillGradient,
    this.strokeWidth = 2.0,
    this.showEndDot = true,
    this.isCurved = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    super.key,
  });

  /// The series of numeric values to plot.
  final List<double> points;

  /// The color of the sparkline stroke. Defaults to theme's primaryForeground with 0.30 alpha.
  final Color? lineColor;

  /// The gradient used to fill the area under the curve. Defaults to [PokaGradients.sparklineFill].
  final Gradient? fillGradient;

  /// Width of the line stroke.
  final double strokeWidth;

  /// Whether to display a subtle glowing indicator dot at the latest (last) data point.
  final bool showEndDot;

  /// Whether to use smooth cubic Bézier curves (spline interpolation) instead of straight lines.
  final bool isCurved;

  /// Insets from the bounding box to keep the line strokes and dots within bounds.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = context.theme;
    final strokeColor = lineColor ?? theme.colors.primaryForeground.withValues(alpha: 0.30);
    final gradient = fillGradient ?? PokaGradients.sparklineFill(theme.colors.primaryForeground);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, animValue, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: _PokaSparklinePainter(
            points: points,
            lineColor: strokeColor,
            fillGradient: gradient,
            strokeWidth: strokeWidth,
            showEndDot: showEndDot,
            isCurved: isCurved,
            padding: padding,
            animationProgress: animValue,
          ),
        );
      },
    );
  }
}

class _PokaSparklinePainter extends CustomPainter {
  _PokaSparklinePainter({
    required this.points,
    required this.lineColor,
    required this.fillGradient,
    required this.strokeWidth,
    required this.showEndDot,
    required this.isCurved,
    required this.padding,
    required this.animationProgress,
  });

  final List<double> points;
  final Color lineColor;
  final Gradient fillGradient;
  final double strokeWidth;
  final bool showEndDot;
  final bool isCurved;
  final EdgeInsets padding;
  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final contentWidth = size.width - padding.left - padding.right;
    final contentHeight = size.height - padding.top - padding.bottom;
    if (contentWidth <= 0 || contentHeight <= 0) return;

    var minVal = points.first;
    var maxVal = points.first;
    for (final p in points) {
      if (p < minVal) minVal = p;
      if (p > maxVal) maxVal = p;
    }
    final range = maxVal - minVal;

    final pts = <Offset>[];
    for (var i = 0; i < points.length; i++) {
      final x = points.length == 1
          ? padding.left + contentWidth / 2
          : padding.left + (i / (points.length - 1)) * contentWidth;
      final normalizedY = range == 0 ? 0.5 : (points[i] - minVal) / range;
      final targetY = padding.top + (1.0 - normalizedY) * contentHeight;
      // Animate upward from bottom baseline
      final baselineY = size.height - padding.bottom;
      final y = baselineY - (baselineY - targetY) * animationProgress;
      pts.add(Offset(x, y));
    }

    if (pts.length == 1) {
      if (showEndDot) {
        _drawEndDot(canvas, pts.first);
      }
      return;
    }

    final linePath = Path()..moveTo(pts.first.dx, pts.first.dy);

    if (isCurved) {
      for (var i = 1; i < pts.length; i++) {
        final p0 = pts[i - 1];
        final p1 = pts[i];
        final cp1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
        final cp2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
        linePath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
      }
    } else {
      for (var i = 1; i < pts.length; i++) {
        linePath.lineTo(pts[i].dx, pts[i].dy);
      }
    }

    // 1. Draw area gradient fill under the line
    final fillPath = Path.from(linePath)
      ..lineTo(pts.last.dx, size.height)
      ..lineTo(pts.first.dx, size.height)
      ..close();

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = fillGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // 2. Draw line stroke
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = lineColor;

    canvas.drawPath(linePath, strokePaint);

    // 3. Draw end dot (indicator for the latest point)
    if (showEndDot && animationProgress > 0.5) {
      final dotProgress = ((animationProgress - 0.5) / 0.5).clamp(0.0, 1.0);
      _drawEndDot(canvas, pts.last, progress: dotProgress);
    }
  }

  void _drawEndDot(Canvas canvas, Offset position, {double progress = 1.0}) {
    canvas
      // Outer glow / aura
      ..drawCircle(
        position,
        5.0 * progress,
        Paint()..color = lineColor.withValues(alpha: 0.25 * progress),
      )
      // Inner bright dot
      ..drawCircle(
        position,
        3.0 * progress,
        Paint()..color = lineColor.withValues(alpha: 0.85 * progress),
      );
  }

  @override
  bool shouldRepaint(covariant _PokaSparklinePainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.points != points ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.showEndDot != showEndDot ||
        oldDelegate.isCurved != isCurved;
  }
}
