import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/period/report_custom_range_dialog.dart';
import 'package:poka_ce/features/reports/presentation/widgets/period/report_period_chip.dart';
import 'package:poka_ce/i18n/strings.g.dart';

export 'package:poka_ce/features/reports/presentation/widgets/period/report_custom_date_label.dart';

/// Horizontal scrollable period chip bar supporting predefined periods and custom date ranges.
class ReportPeriodSelector extends ConsumerWidget {
  /// Creates a [ReportPeriodSelector].
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(reportProvider.select((s) => s.period));
    final t = context.t.reports;

    final periods = [
      (ReportPeriod.thisMonth, t.thisMonth),
      (ReportPeriod.lastMonth, t.lastMonth),
      (ReportPeriod.last3Months, t.last3Months),
      (ReportPeriod.last6Months, t.last6Months),
      (ReportPeriod.custom, t.custom),
    ];

    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: periods.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final (period, label) = periods[index];
          final isSelected = selected == period;

          return ReportPeriodChip(
            label: label,
            isSelected: isSelected,
            onTap: () {
              if (period == ReportPeriod.custom) {
                _showCustomRangePicker(context, ref);
              } else {
                ref.read(reportProvider.notifier).setPeriod(period);
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _showCustomRangePicker(BuildContext context, WidgetRef ref) async {
    final state = ref.read(reportProvider);
    final now = DateTime.now();

    final picked = await showFDialog<(DateTime, DateTime)?>(
      context: context,
      builder: (context, style, animation) => ReportCustomRangeDialog(
        initial: state.customDateStart != null && state.customDateEnd != null
            ? (state.customDateStart!, state.customDateEnd!)
            : null,
        now: now,
        animation: animation,
      ),
    );

    if (picked != null) {
      ref.read(reportProvider.notifier).setCustomRange(picked.$1, picked.$2);
    }
  }
}
