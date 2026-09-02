import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_header_provider.g.dart';

/// Defines a builder for a custom Dashboard Header widget.
typedef DashboardHeaderBuilder = Widget Function(BuildContext context);

/// Provides a custom header builder for the Dashboard.
///
/// By default (in CE), this returns null, meaning the default CE header is used.
/// Poka PE overrides this to inject a custom header (e.g., with avatar and greeting).
@riverpod
DashboardHeaderBuilder? dashboardHeaderBuilder(Ref ref) {
  return null;
}
