import 'package:flutter/material.dart';
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
import 'package:poka_ce/theme/theme.dart';

/// Renders transactions as grouped date sections inside a [SliverList].
class TransactionGroupSliver extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = TransactionGroupingService.groupTransactions(transactions);

    return SliverList.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];

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
              ),
              const SizedBox(height: 8),

              // ── Tiles ───────────────────────────────────────────────
              Column(
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
                    onDelete: () {
                      showFDialog<void>(
                        context: context,
                        builder: (ctx, style, animation) => FDialog(
                          animation: animation,
                          builder: (dialogCtx, dialogStyle) {
                            return Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    t.transactions.deleteTransaction,
                                    style: ctx.theme.typography.display.sm.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    t.transactions.areYouSureYouWantToDeleteThisTransactionThisActionCannotBeUndone,
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FButton(
                                          variant: FButtonVariant.outline,
                                          onPress: () => Navigator.of(ctx).pop(),
                                          child: Text(t.transactions.cancel),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: FButton(
                                          onPress: () {
                                            Navigator.of(ctx).pop();
                                            ref.read(transactionListNotifierProvider.notifier).deleteTransaction(tx.id);
                                          },
                                          // Note: Forui currently doesn't have a destructive variant, so we just use the default
                                          child: Text(t.transactions.delete),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
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
            ],
          ),
        );
      },
    );
  }
}
