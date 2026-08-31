/// Recurring transactions list screen — shows all scheduled automations
/// with a summary card, status/date chips, and an inline active toggle.
///
/// Per PLANS.md §6: recurring transactions are blueprints that auto-generate
/// real transactions whenever `nextDate` <= today.
library;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/widgets/cards/recurring_card.dart';
import 'package:poka_ce/features/recurring/presentation/widgets/cards/recurring_summary_card.dart';
import 'package:poka_ce/features/recurring/presentation/widgets/forms/recurring_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

/// Main page that lists all recurring transactions.
class RecurringListPage extends ConsumerWidget {
  const RecurringListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recurringListProvider);

    return FScaffold(
      header: PokaHeader(
        title: t.recurring.recurring,
        showBack: true,
      ),
      child: state.isLoading && state.recurrings.isEmpty
          ? const Center(child: FCircularProgress())
          : state.recurrings.isEmpty
          ? Builder(
              builder: (context) => PokaEmptyViewCentered(
                icon: FPhosphorIcons.repeat,
                title: t.recurring.noRecurringTransactions,
                subtitle: t.recurring.automateBillsLikeSubscriptionsOrSalary,
                actionLabel: t.recurring.addSchedule,
                actionKey: const Key('recurring-add-button'),
                onAction: () => RecurringFormSheet.show(context),
              ),
            )
          : _RecurringContent(
              recurrings: state.recurrings,
              onRefresh: () => ref.read(recurringListProvider.notifier).refresh(),
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Content area — summary card + list
// ─────────────────────────────────────────────────────────────────────────────

class _RecurringContent extends StatelessWidget {
  const _RecurringContent({
    required this.recurrings,
    required this.onRefresh,
  });

  final List<RecurringTransactionModel> recurrings;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RecurringSummaryCard(recurrings: recurrings)
                .animate()
                .fade(duration: 300.ms)
                .slideY(begin: 0.05, end: 0),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PokaSectionLabel(title: t.recurring.schedules),
                Builder(
                  builder: (context) => GestureDetector(
                    key: const Key('recurring-add-button'),
                    onTap: () => RecurringFormSheet.show(context),
                    child: Row(
                      children: [
                        Icon(
                          FPhosphorIcons.plus,
                          size: 14,
                          color: context.theme.colors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          t.recurring.addSchedule,
                          style: context.theme.typography.bodySecondary.copyWith(
                            color: context.theme.colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ).animate().fade(duration: 300.ms, delay: 80.ms).slideY(begin: 0.05, end: 0),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverList.separated(
              itemCount: recurrings.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final delay = (80 + index * 50).clamp(0, 320);
                return RecurringCard(recurring: recurrings[index])
                    .animate()
                    .fade(duration: 280.ms, delay: delay.ms)
                    .slideY(begin: 0.05, end: 0, duration: 280.ms, delay: delay.ms);
              },
            ),
          ),
        ],
      ),
    );
  }
}
