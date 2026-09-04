import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/transactions/domain/services/transaction_grouping_service.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/list/transaction_date_header.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';

/// Renders transactions as grouped date sections inside a [SliverList].
class TransactionGroupSliver extends HookWidget {
  const TransactionGroupSliver({
    required this.transactions,
    required this.categoriesById,
    required this.accountsById,
    super.key,
  });

  final List<TransactionModel> transactions;
  final Map<String, CategoryModel> categoriesById;
  final Map<String, AccountModel> accountsById;

  @override
  Widget build(BuildContext context) {
    final collapsedDates = useState<Set<String>>({});
    final groups = TransactionGroupingService.groupTransactions(transactions);

    return SliverList.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        final isExpanded = !collapsedDates.value.contains(group.dateStr);

        return _SliverDateGroupSection(
          key: ValueKey(group.dateStr),
          group: group,
          isExpanded: isExpanded,
          onToggle: () {
            final next = Set<String>.from(collapsedDates.value);
            if (next.contains(group.dateStr)) {
              next.remove(group.dateStr);
            } else {
              next.add(group.dateStr);
            }
            collapsedDates.value = next;
          },
          categoriesById: categoriesById,
          accountsById: accountsById,
        );
      },
    );
  }
}

class _SliverDateGroupSection extends ConsumerWidget {
  const _SliverDateGroupSection({
    required this.group,
    required this.isExpanded,
    required this.onToggle,
    required this.categoriesById,
    required this.accountsById,
    super.key,
  });

  final TransactionGroup group;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Map<String, CategoryModel> categoriesById;
  final Map<String, AccountModel> accountsById;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Date group header ───────────────────────────────────
          TransactionDateHeader(
            dateStr: group.dateStr,
            income: group.totalIncome,
            expense: group.totalExpense,
            isExpanded: isExpanded,
            itemCount: group.transactions.length,
            onToggle: onToggle,
          ),

          // ── Collapsible Tiles ────────────────────────────────────
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: isExpanded ? 1.0 : 0.0, end: isExpanded ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              if (value == 0.0) return const SizedBox.shrink();
              return FCollapsible(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: child,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(group.transactions.length, (i) {
                final tx = group.transactions[i];
                final firstCatId = tx.items.isNotEmpty ? tx.items.first.categoryId : null;
                final category = firstCatId != null ? categoriesById[firstCatId] : null;
                final account = accountsById[tx.accountId];

                final tile = RecentTransactionTile(
                  transaction: tx,
                  isBalanceVisible: true,
                  categoriesById: categoriesById,
                  category: category,
                  account: account,
                  isFirst: i == 0,
                  isLast: i == group.transactions.length - 1,
                  onEdit: () {
                    TransactionFormSheet.show(context, initialTransaction: tx);
                  },
                  onDelete: () async {
                    final confirmed = await showPokaConfirmDialog(
                      context,
                      title: t.transactions.deleteTransaction,
                      body: t.transactions.deleteTransactionWarning,
                    );
                    if (confirmed == true) {
                      await ref.read(transactionListNotifierProvider.notifier).deleteTransaction(tx.id);
                    }
                  },
                );

                if (i < group.transactions.length - 1) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: tile,
                  );
                }
                return tile;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
