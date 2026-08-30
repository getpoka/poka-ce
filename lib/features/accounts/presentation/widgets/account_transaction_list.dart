import 'package:flutter/material.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';

// ─────────────────────────────────────────────────────────────────────────────

class AccountTransactionList extends StatelessWidget {
  const AccountTransactionList({
    required this.transactions,
    required this.categoriesById,
    required this.accountsById,
    required this.isBalanceVisible,
    super.key,
  });

  final List<TransactionModel> transactions;
  final Map<String, CategoryModel> categoriesById;
  final Map<String, AccountModel> accountsById;
  final bool isBalanceVisible;

  @override
  Widget build(BuildContext context) {
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
