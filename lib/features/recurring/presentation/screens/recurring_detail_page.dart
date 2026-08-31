import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_detail_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/widgets/cards/recurring_card.dart';
import 'package:poka_ce/features/recurring/presentation/widgets/forms/recurring_form_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

class RecurringDetailPage extends ConsumerWidget {
  const RecurringDetailPage({
    required this.id,
    this.recurring,
    super.key,
  });

  final String id;
  final RecurringTransactionModel? recurring;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recurringListState = ref.watch(recurringListProvider);
    final activeRecurring = recurringListState.recurrings.where((r) => r.id == id).firstOrNull ?? recurring;

    if (activeRecurring == null) {
      return FScaffold(
        header: PokaHeader(title: t.recurring.scheduleDetails, showBack: true),
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

    final transactionsAsync = ref.watch(recurringTransactionsProvider(activeRecurring));

    return FScaffold(
      header: PokaHeader(
        title: t.recurring.scheduleDetails,
        showBack: true,
        suffixes: [
          FHeaderAction(
            icon: const Icon(FPhosphorIcons.pencilSimple, size: 20),
            onPress: () => RecurringFormSheet.show(context, initialRecurring: activeRecurring),
          ),
          FHeaderAction(
            icon: Icon(FPhosphorIcons.trash, size: 20, color: context.theme.colors.destructive),
            onPress: () async {
              final confirm = await showPokaConfirmDialog(
                context,
                title: t.recurring.deleteSchedule,
                body: t
                    .recurring
                    .areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted,
                confirmText: t.recurring.delete,
              );

              if (confirm == true) {
                await ref.read(recurringListProvider.notifier).deleteRecurring(activeRecurring.id);
                if (context.mounted) {
                  context.pop();
                }
              }
            },
          ),
        ],
      ),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RecurringCard(recurring: activeRecurring, isInteractive: false),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: PokaSectionLabel(title: t.recurring.triggerHistory),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          transactionsAsync.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return SliverToBoxAdapter(
                  child: PokaEmptyViewCentered(
                    icon: FPhosphorIcons.receipt,
                    title: t.recurring.noHistoryFoundForThisSchedule,
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
