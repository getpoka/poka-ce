import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Horizontal scrollable period chip bar + custom date range support.
class ReportPeriodSelector extends ConsumerWidget {
  const ReportPeriodSelector({super.key});

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

          return _PeriodChip(
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
      builder: (context, style, animation) => _CustomRangeDialog(
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

// ─────────────────────────────────────────────────────────────────────────────

class _CustomRangeDialog extends StatefulWidget {
  const _CustomRangeDialog({
    required this.initial,
    required this.now,
    required this.animation,
  });
  final (DateTime, DateTime)? initial;
  final DateTime now;
  final Animation<double> animation;

  @override
  State<_CustomRangeDialog> createState() => _CustomRangeDialogState();
}

class _CustomRangeDialogState extends State<_CustomRangeDialog> {
  (DateTime, DateTime)? _range;

  @override
  void initState() {
    super.initState();
    _range = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      animation: widget.animation,
      builder: (context, style) {
        return FCalendar.grid(
          control: FGridCalendarControl(
            start: DateTime.utc(widget.now.year - 3),
            end: DateTime.utc(widget.now.year, widget.now.month, widget.now.day),
          ),
          selectionControl: FDateSelectionControl.managedOpenRange(
            initial: _range != null ? (_range!.$1, _range!.$2) : (null, null),
            onChange: (range) {
              if (range.$1 != null && range.$2 != null) {
                setState(() => _range = (range.$1!, range.$2!));
                Future.delayed(const Duration(milliseconds: 400), () {
                  if (!context.mounted) return;
                  Navigator.of(context).pop((range.$1!, range.$2!));
                });
              } else if (range.$1 != null) {
                setState(() => _range = (range.$1!, range.$1!));
              }
            },
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.primary : theme.colors.muted,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colors.primary : theme.colors.border.withValues(alpha: 0.6),
          ),
        ),
        child: Text(
          label,
          style: theme.typography.caption.copyWith(
            color: isSelected ? theme.colors.primaryForeground : theme.colors.mutedForeground,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

/// Shows custom date range label when period is custom.
class ReportCustomDateLabel extends ConsumerWidget {
  const ReportCustomDateLabel({super.key});

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
      child: Text(
        label,
        style: theme.typography.bodySecondary.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
    );
  }
}
