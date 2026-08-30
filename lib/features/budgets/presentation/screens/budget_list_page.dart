import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/cards/budget_card.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/cards/budget_summary_card.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/forms/budget_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

/// Budget list page — displays all user budgets with spending progress.
/// Intentionally budget-only; goals have their own dedicated page.
class BudgetListPage extends ConsumerWidget {
  const BudgetListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(budgetListProvider);

    return FScaffold(
      header: PokaHeader(
        title: t.budgets.budgets,
        showBack: true,
      ),
      child: state.when(
        data: (budgets) => _BudgetContent(budgets: budgets),
        error: (err, _) => Center(child: Text(err.toString())),
        loading: () => const Center(child: FCircularProgress()),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main content: summary card + budget list
// ─────────────────────────────────────────────────────────────────────────────

class _BudgetContent extends ConsumerWidget {
  const _BudgetContent({required this.budgets});

  final List<BudgetModel> budgets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (budgets.isEmpty) {
      return Builder(
        builder: (context) => PokaEmptyView(
          icon: FPhosphorIcons.chartPieSlice,
          title: t.budgets.noBudgetsYet,
          subtitle: t.budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod,
          actionLabel: t.budgets.createBudget,
          actionKey: const Key('budget-add-button'),
          onAction: () => BudgetFormSheet.show(context),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(budgetListProvider.notifier).refresh(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BudgetSummaryCard(budgets: budgets).animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PokaSectionLabel(title: t.budgets.allBudgets),
                Builder(
                  builder: (context) => GestureDetector(
                    key: const Key('budget-add-button'),
                    onTap: () => BudgetFormSheet.show(context),
                    child: Row(
                      children: [
                        Icon(FPhosphorIcons.plus, size: 14, color: context.theme.colors.primary),
                        const SizedBox(width: 4),
                        Text(
                          t.budgets.addBudget,
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
              itemCount: budgets.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final budget = budgets[index];
                final delay = (80 + index * 50).clamp(0, 320);
                return BudgetCard(budget: budget)
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
