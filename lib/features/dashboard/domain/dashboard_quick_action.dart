import 'package:flutter/widgets.dart';

/// Represents a single quick action in the dashboard.
class DashboardQuickAction {
  const DashboardQuickAction({
    required this.icon,
    required this.labelBuilder,
    required this.onTap,
  });

  final IconData icon;
  final String Function(BuildContext context) labelBuilder;
  final void Function(BuildContext context) onTap;
}
