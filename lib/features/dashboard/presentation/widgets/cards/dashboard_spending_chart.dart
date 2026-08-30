import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/daily_budget_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/sheets/dashboard_budget_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class DashboardSpendingChart extends HookConsumerWidget {
  const DashboardSpendingChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(dashboardProvider);

    final totalExpenseFormatted = state.totalExpense.toCompactFormat();
    final avgExpenseFormatted = (state.totalExpense / 7).toCompactFormat();

    // Get daily budget
    final dailyBudget = ref.watch(dailyBudgetProvider);
    final dailyBudgetFormatted = dailyBudget > 0 ? dailyBudget.toCompactFormat() : context.t.dashboard.notSet;

    // Use pre-computed state from DashboardState
    final dailySpending = state.dailySpending;
    final normalizedSpending = state.normalizedDailySpending;

    // Overbudget check (today is index 6)
    final todaySpending = dailySpending.last;
    final isOverbudget = dailyBudget > 0 && todaySpending > dailyBudget;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.t.dashboard.spendingActivity, style: theme.typography.titleCard),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(context, context.t.dashboard.total, totalExpenseFormatted),
                  _buildStat(context, context.t.dashboard.average, avgExpenseFormatted),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.t.dashboard.budgetPerDay,
                        style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => DashboardBudgetSheet.show(context, currentBudget: dailyBudget),
                        child: Row(
                          children: [
                            Text(
                              dailyBudgetFormatted,
                              style: theme.typography.bodyPrimary.copyWith(
                                fontWeight: FontWeight.w700,
                                color: isOverbudget ? theme.colors.destructive : theme.colors.foreground,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              FPhosphorIcons.pencilSimple,
                              size: 12,
                              color: theme.colors.mutedForeground,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (dailyBudget > 0) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.t.dashboard.todaysBudget,
                      style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                    ),
                    if (isOverbudget)
                      Text(
                        context.t.dashboard.overbudget,
                        style: theme.typography.bodySecondary.copyWith(
                          color: theme.colors.destructive,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                FDeterminateProgress(value: (todaySpending / dailyBudget).clamp(0.0, 1.0)),
              ],
              const Spacer(),
              // Mock bar chart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar(
                    context,
                    _getDayLabel(context, DateTime.now().subtract(const Duration(days: 6))),
                    normalizedSpending[0],
                    false,
                  ),
                  _buildBar(
                    context,
                    _getDayLabel(context, DateTime.now().subtract(const Duration(days: 5))),
                    normalizedSpending[1],
                    false,
                  ),
                  _buildBar(
                    context,
                    _getDayLabel(context, DateTime.now().subtract(const Duration(days: 4))),
                    normalizedSpending[2],
                    false,
                  ),
                  _buildBar(
                    context,
                    _getDayLabel(context, DateTime.now().subtract(const Duration(days: 3))),
                    normalizedSpending[3],
                    false,
                  ),
                  _buildBar(
                    context,
                    _getDayLabel(context, DateTime.now().subtract(const Duration(days: 2))),
                    normalizedSpending[4],
                    false,
                  ),
                  _buildBar(
                    context,
                    _getDayLabel(context, DateTime.now().subtract(const Duration(days: 1))),
                    normalizedSpending[5],
                    false,
                  ),
                  _buildBar(context, _getDayLabel(context, DateTime.now()), normalizedSpending[6], true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDayLabel(BuildContext context, DateTime date) {
    final days = [
      context.t.dashboard.days.mon,
      context.t.dashboard.days.tue,
      context.t.dashboard.days.wed,
      context.t.dashboard.days.thu,
      context.t.dashboard.days.fri,
      context.t.dashboard.days.sat,
      context.t.dashboard.days.sun,
    ];
    return days[date.weekday - 1];
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground)),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.typography.bodyPrimary.copyWith(fontWeight: FontWeight.w500, color: theme.colors.primary),
        ),
      ],
    );
  }

  Widget _buildBar(BuildContext context, String day, double heightRatio, bool isActive) {
    final theme = context.theme;
    final targetHeight = 12 + (48 * heightRatio);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: targetHeight),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (context, height, _) {
            return Container(
              width: 32,
              height: height,
              decoration: BoxDecoration(
                color: isActive ? theme.colors.primary : theme.colors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: theme.typography.bodySecondary.copyWith(
            color: isActive ? theme.colors.foreground : theme.colors.mutedForeground,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
          ),
        ).animate().fade(duration: 400.ms, delay: 300.ms),
      ],
    );
  }
}
