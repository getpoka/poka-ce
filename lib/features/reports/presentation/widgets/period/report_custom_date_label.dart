import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/theme/theme.dart';

/// Shows formatted custom date range label when period is set to custom.
class ReportCustomDateLabel extends ConsumerWidget {
  /// Creates a [ReportCustomDateLabel].
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportProvider);
    if (state.period != ReportPeriod.custom || state.customDateStart == null || state.customDateEnd == null) {
      return const SizedBox.shrink();
    }

    final fmt = DateFormat('d MMM y');
    final label = '${fmt.format(state.customDateStart!)} – ${fmt.format(state.customDateEnd!)}';
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Text(label, style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground)),
    );
  }
}
