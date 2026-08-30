import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_detail_notifier.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/goals/presentation/widgets/cards/goal_card.dart';
import 'package:poka_ce/features/goals/presentation/widgets/forms/goal_form_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

class GoalDetailPage extends ConsumerWidget {
  const GoalDetailPage({
    required this.id,
    this.goal,
    super.key,
  });

  final String id;
  final GoalModel? goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalStateList = ref.watch(goalListStatesProvider);
    final activeGoalState = goalStateList.where((g) => g.goal.id == id).firstOrNull;

    if (activeGoalState == null) {
      return FScaffold(
        header: PokaHeader(title: t.goals.goalDetails, showBack: true),
        child: const Center(child: FCircularProgress()),
      );
    }

    final activeGoal = activeGoalState.goal;

    final categoriesById =
        ref
            .watch(categoryListProvider)
            .asData
            ?.value
            .fold<Map<String, CategoryModel>>(
              <String, CategoryModel>{},
              (map, c) => map..[c.id] = c,
            ) ??
        <String, CategoryModel>{};

    final accountsById =
        ref
            .watch(accountListProvider)
            .asData
            ?.value
            .accounts
            .fold<Map<String, AccountModel>>(
              <String, AccountModel>{},
              (map, a) => map..[a.id] = a,
            ) ??
        <String, AccountModel>{};

    final transactionsAsync = ref.watch(goalTransactionsProvider(activeGoal));

    return FScaffold(
      header: PokaHeader(
        title: t.goals.goalDetails,
        showBack: true,
        suffixes: [
          FHeaderAction(
            icon: const Icon(FPhosphorIcons.pencilSimple, size: 20),
            onPress: () => GoalFormSheet.show(context, initialGoal: activeGoal),
          ),
          FHeaderAction(
            icon: Icon(FPhosphorIcons.trash, size: 20, color: context.theme.colors.destructive),
            onPress: () async {
              final deleted = await ref
                  .read(goalDetailProvider.notifier)
                  .deleteGoal(context, activeGoal, currentBalance: activeGoalState.saved);
              if (deleted && context.mounted) {
                context.pop();
              }
            },
          ),
        ],
      ),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: GoalCard(state: activeGoalState, isInteractive: false),
          ),
          if (activeGoalState.isTargetReached && activeGoal.status == GoalStatus.active)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FButton(
                  onPress: () => ref.read(goalDetailProvider.notifier).fulfillGoal(context, activeGoal),
                  child: Text(t.goals.fulfillGoal),
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: PokaSectionLabel(title: t.goals.transactions),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          transactionsAsync.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                        t.goals.noTransactionsFoundForThisGoal,
                        style: context.theme.typography.bodyPrimary.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final transaction = transactions[index];
                    final firstCatId = transaction.items.isNotEmpty ? transaction.items.first.categoryId : null;
                    final category = firstCatId != null ? categoriesById[firstCatId] : null;
                    final account = accountsById[transaction.accountId];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RecentTransactionTile(
                        transaction: transaction,
                        isBalanceVisible: true,
                        categoriesById: categoriesById,
                        category: category,
                        account: account,
                      ),
                    );
                  },
                  childCount: transactions.length,
                ),
              );
            },
            error: (err, _) => SliverToBoxAdapter(child: Text(err.toString())),
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: FCircularProgress()),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
