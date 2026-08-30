import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

class DonutChartPainter extends CustomPainter {
  DonutChartPainter({
    required this.proportions,
    required this.colors,
    this.strokeWidth = 12,
  });
  final List<double> proportions;
  final List<Color> colors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (proportions.isEmpty || colors.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    var startAngle = -1.5708; // -90 degrees in radians

    for (var i = 0; i < proportions.length; i++) {
      final sweepAngle = proportions[i] * 6.28319; // 360 degrees in radians

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      // Add a tiny gap if there are multiple segments
      final actualSweepAngle = (proportions.length > 1 && sweepAngle > 0.1) ? sweepAngle - 0.1 : sweepAngle;

      canvas.drawArc(rect, startAngle, actualSweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant DonutChartPainter oldDelegate) {
    return true;
  }
}

Widget buildCategoryStatRow(BuildContext context, String label, String value, Color color, double progress) {
  final theme = context.theme;
  return Row(
    children: [
      Expanded(
        flex: 4,
        child: Text(label, style: theme.typography.bodyPrimary, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      const SizedBox(width: 8),
      Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.colors.border,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
          ),
        ),
      ),
      const SizedBox(width: 12),
      SizedBox(
        width: 48,
        child: Text(
          value,
          style: theme.typography.bodyPrimary.copyWith(color: theme.colors.mutedForeground),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
