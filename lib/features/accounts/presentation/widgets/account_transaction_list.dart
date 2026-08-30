import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';

// ─────────────────────────────────────────────────────────────────────────────

class AccountTransactionList extends HookConsumerWidget {
  const AccountTransactionList({
    required this.accountId,
    required this.transactions,
    super.key,
  });

  final String accountId;
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesById = ref.watch(categoryMapProvider);
    final accountsById = ref.watch(accountMapProvider);
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);
    final displayTransactions = transactions.take(10).toList();

    final tiles = <RecentTransactionTile>[];
    for (var i = 0; i < displayTransactions.length; i++) {
      final t = displayTransactions[i];
      final firstItemCategoryId = t.items.isNotEmpty ? t.items.first.categoryId : null;
      final category = firstItemCategoryId != null ? categoriesById[firstItemCategoryId] : null;
      final account = accountsById[t.accountId];

      tiles.add(
        RecentTransactionTile(
          transaction: t,
          isBalanceVisible: isBalanceVisible,
          category: category,
          account: account,
          isFirst: i == 0,
          isLast: i == displayTransactions.length - 1,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: tiles.map((tile) {
        if (tile == tiles.last) return tile;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: tile,
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Compact Hero Card for Account & Pocket Details
