import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/cards/budget_card.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/forms/budget_form_sheet.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

// Helper provider to fetch transactions for a specific budget
// ignore: specify_nonobvious_property_types
final budgetTransactionsProvider = StreamProvider.autoDispose.family<List<TransactionModel>, BudgetModel>((
  ref,
  budget,
) {
  final now = DateTime.now();
  DateTime startDate;
  DateTime endDate;

  switch (budget.period) {
    case BudgetPeriod.monthly:
      final resetDay = budget.resetDay ?? 1;
      if (now.day >= resetDay) {
        startDate = DateTime(now.year, now.month, resetDay);
        endDate = DateTime(now.year, now.month + 1, resetDay).subtract(const Duration(seconds: 1));
      } else {
        startDate = DateTime(now.year, now.month - 1, resetDay);
        endDate = DateTime(now.year, now.month, resetDay).subtract(const Duration(seconds: 1));
      }
    case BudgetPeriod.weekly:
      final daysSinceMonday = now.weekday - 1;
      startDate = DateTime(now.year, now.month, now.day).subtract(Duration(days: daysSinceMonday));
      endDate = startDate.add(const Duration(days: 7)).subtract(const Duration(seconds: 1));
    case BudgetPeriod.yearly:
      startDate = DateTime(now.year);
      endDate = DateTime(now.year, 12, 31, 23, 59, 59);
    case BudgetPeriod.custom:
      startDate = budget.startDate;
      endDate = budget.endDate ?? now.add(const Duration(days: 3650));
  }

  return ref
      .read(transactionRepositoryProvider)
      .watchTransactions(
        startDate: startDate,
        endDate: endDate,
        categoryIds: budget.categoryId != null ? {budget.categoryId!} : const {},
        accountIds: budget.accountId != null ? {budget.accountId!} : const {},
        types: {TransactionType.expense},
      )
      .map((result) {
        return switch (result) {
          Success(value: final transactions) => transactions,
          ErrorResult(error: final failure) => throw Exception(failure.message),
        };
      });
});

class BudgetDetailPage extends ConsumerWidget {
  const BudgetDetailPage({
    required this.id,
    this.budget,
    super.key,
  });

  final String id;
  final BudgetModel? budget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If we have budget from extra, use it, otherwise find it from state.
    final budgetState = ref.watch(budgetListProvider);
    final activeBudget =
        budget ??
        budgetState.asData?.value.firstWhere(
          (b) => b.id == id,
          orElse: () => throw Exception('Budget not found'),
        );

    if (activeBudget == null) {
      return FScaffold(
        header: PokaHeader(title: t.budgets.budgetDetails, showBack: true),
        child: const Center(child: FCircularProgress()),
      );
    }

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

    final transactionsAsync = ref.watch(budgetTransactionsProvider(activeBudget));

    return FScaffold(
      header: PokaHeader(
        title: t.budgets.budgetDetails,
        showBack: true,
        suffixes: [
          FHeaderAction(
            icon: const Icon(FPhosphorIcons.pencilSimple, size: 20),
            onPress: () => BudgetFormSheet.show(context, initialBudget: activeBudget),
          ),
          FHeaderAction(
            icon: Icon(FPhosphorIcons.trash, size: 20, color: context.theme.colors.destructive),
            onPress: () async {
              final confirm = await showPokaConfirmDialog(
                context,
                title: t.budgets.deleteBudget,
                body: t
                    .budgets
                    .areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone,
                confirmText: t.budgets.delete,
              );
              if (confirm == true) {
                unawaited(ref.read(budgetListProvider.notifier).deleteBudget(activeBudget.id));
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BudgetCard(budget: activeBudget, isInteractive: false),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: PokaSectionLabel(title: t.budgets.transactions),
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
                        t.budgets.noTransactionsFoundForThisBudgetPeriod,
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
