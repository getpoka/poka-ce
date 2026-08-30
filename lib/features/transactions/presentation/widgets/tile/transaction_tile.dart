import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/datetime_extension.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/split/transaction_split_item_form_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile_content.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile_icon.dart';
import 'package:poka_ce/shared/widgets/poka_slidable_action.dart';
import 'package:poka_ce/theme/theme.dart';

/// A compact tile displaying a single transaction's details,
/// using category color/icon for the visual prefix badge.
class RecentTransactionTile extends HookConsumerWidget with FTileMixin {
  /// Creates a [RecentTransactionTile].
  const RecentTransactionTile({
    required this.transaction,
    required this.isBalanceVisible,
    this.categoriesById,
    this.category,
    this.account,
    this.isFirst = false,
    this.isLast = false,
    this.isSubItem = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final TransactionModel transaction;
  final bool isBalanceVisible;

  final Map<String, CategoryModel>? categoriesById;

  /// Resolved category for this transaction's first item (or null).
  final CategoryModel? category;

  /// Resolved account for this transaction.
  final AccountModel? account;

  final bool isFirst;
  final bool isLast;
  final bool isSubItem;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isExpanded = useState(false);
    final hasMultipleItems = transaction.items.length >= 2;
    final updateTransaction = ref.watch(updateTransactionUseCaseProvider);

    Future<void> handleEditItem(int index) async {
      final oldItem = transaction.items[index];
      final splitItem = SplitItem(
        categoryId: oldItem.categoryId,
        amount: oldItem.amount,
        note: oldItem.note,
        allocation: oldItem.allocation,
      );

      final updatedSplit = await TransactionSplitItemFormSheet.show(
        context,
        transactionType: transaction.type,
        initialItem: splitItem,
      );

      if (updatedSplit == null) return;

      final newItems = List<TransactionItemModel>.from(transaction.items);
      newItems[index] = oldItem.copyWith(
        categoryId: updatedSplit.categoryId,
        amount: updatedSplit.amount,
        note: updatedSplit.note,
        allocation: updatedSplit.allocation,
      );

      await updateTransaction.execute(
        transaction,
        type: transaction.type,
        accountId: transaction.accountId,
        destinationAccountId: transaction.destinationAccountId,
        transactionDate: transaction.transactionDate,
        note: transaction.note,
        splitItems: newItems
            .map(
              (i) => (
                categoryId: i.categoryId,
                amount: i.amount,
                note: i.note,
                allocation: i.allocation,
              ),
            )
            .toList(),
      );
    }

    Future<void> handleRemoveItem(int index) async {
      if (transaction.items.length <= 1) return;

      final newItems = List<TransactionItemModel>.from(transaction.items)..removeAt(index);

      await updateTransaction.execute(
        transaction,
        type: transaction.type,
        accountId: transaction.accountId,
        destinationAccountId: transaction.destinationAccountId,
        transactionDate: transaction.transactionDate,
        note: transaction.note,
        splitItems: newItems
            .map(
              (i) => (
                categoryId: i.categoryId,
                amount: i.amount,
                note: i.note,
                allocation: i.allocation,
              ),
            )
            .toList(),
      );
    }

    void handleTap() {
      if (hasMultipleItems) {
        isExpanded.value = !isExpanded.value;
      } else {
        onTap?.call();
      }
    }

    final effectiveCategoriesById =
        categoriesById ??
        ref
            .watch(categoryListProvider)
            .value
            ?.fold<Map<String, CategoryModel>>(
              <String, CategoryModel>{},
              (map, c) => map..[c.id] = c,
            ) ??
        <String, CategoryModel>{};

    // ── Category icon + color ──────────────────────────────────────────────
    var catColor = category?.color?.toColor() ?? theme.colors.primary;
    var catIcon = IconUtil.getIcon(category?.icon);

    // ── Category label ─────────────────────────────────────────────────────
    var catLabel = category?.name ?? (transaction.type == TransactionType.transfer ? 'Transfer' : 'Uncategorized');

    IconData? subCatIcon;
    Color? subCatColor;

    if (category?.parentId != null && effectiveCategoriesById.isNotEmpty) {
      final parentCat = effectiveCategoriesById[category!.parentId!];
      if (parentCat != null) {
        catLabel = '${parentCat.name} • ${category!.name}';
        // Prefix gets the SUB category icon
        catIcon = IconUtil.getIcon(category!.icon);
        catColor = category!.color?.toColor() ?? theme.colors.primary;
        // Sub badge gets the PARENT category icon
        subCatIcon = IconUtil.getIcon(parentCat.icon);
        subCatColor = parentCat.color?.toColor() ?? theme.colors.primary;
      }
    }

    // ── Account label + icon + color ───────────────────────────────────────
    final accLabel = isSubItem ? null : (account?.name ?? 'Unknown');
    final accIcon = isSubItem ? null : IconUtil.getIcon(account?.icon);
    final accColor = isSubItem ? null : (account?.color?.toColor() ?? theme.colors.primary);

    AccountModel? destAccount;
    if (transaction.type == TransactionType.transfer && transaction.destinationAccountId != null) {
      final effectiveAccountsById =
          ref
              .watch(accountListProvider)
              .value
              ?.accounts
              .fold<Map<String, AccountModel>>(
                <String, AccountModel>{},
                (map, a) => map..[a.id] = a,
              ) ??
          <String, AccountModel>{};
      destAccount = effectiveAccountsById[transaction.destinationAccountId!];
    }

    final destAccLabel = destAccount?.name;
    final destAccColor = destAccount?.color?.toColor() ?? theme.colors.primary;

    // ── Time string ────────────────────────────────────────────────────────
    final timeStr = isSubItem ? null : transaction.transactionDate.toFormattedTime();

    final Widget baseTile = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: handleTap,
      child: FTile(
        enabled: true,
        prefix: TransactionTileIcon(
          catColor: catColor,
          catIcon: catIcon,
          subCatIcon: subCatIcon,
          subCatColor: subCatColor,
          isGroup: hasMultipleItems,
          isExpanded: isExpanded.value,
          isSmall: isSubItem,
        ),
        title: TransactionTileContent(
          catLabel: catLabel,
          catColor: catColor,
          hasMultipleItems: hasMultipleItems,
          itemCount: transaction.items.length,
          amount: transaction.amount,
          type: transaction.type,
          isBalanceVisible: isBalanceVisible,
          accLabel: accLabel,
          accIcon: accIcon,
          accColor: accColor,
          destAccLabel: destAccLabel,
          destAccColor: destAccColor,
          isTransfer: transaction.type == TransactionType.transfer,
          timeStr: timeStr,
          note: !hasMultipleItems ? (transaction.items.firstOrNull?.note ?? transaction.note) : transaction.note,
          allocation: !hasMultipleItems ? transaction.items.firstOrNull?.allocation : null,
          hasDebt: transaction.debtId != null,
          isRecurring: transaction.recurringTransactionId != null,
        ),
      ),
    );

    final cardContent = FCard(
      clipBehavior: Clip.antiAlias,
      child: baseTile,
    );

    Widget parentWidget = cardContent;

    if (onEdit != null || onDelete != null) {
      parentWidget = Slidable(
        key: ValueKey(transaction.id),
        startActionPane: onDelete != null
            ? ActionPane(
                motion: const BehindMotion(),
                extentRatio: 0.22,
                children: [
                  PokaSlidableAction(
                    icon: FPhosphorIcons.trash,
                    color: theme.colors.destructive,
                    onPressed: onDelete!,
                    isDestructive: true,
                  ),
                ],
              )
            : null,
        endActionPane: onEdit != null
            ? ActionPane(
                motion: const BehindMotion(),
                extentRatio: 0.22,
                children: [
                  PokaSlidableAction(
                    icon: FPhosphorIcons.pencilSimple,
                    color: theme.colors.primary,
                    onPressed: onEdit!,
                  ),
                ],
              )
            : null,
        child: cardContent,
      );
    }

    if (!hasMultipleItems) {
      return parentWidget;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        parentWidget,
        FCollapsible(
          value: isExpanded.value ? 1.0 : 0.0,
          child: Container(
            margin: const EdgeInsets.only(left: 37, top: 8),
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: theme.colors.border,
                  width: 1.2,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: transaction.items.asMap().entries.map((entry) {
                final isLast = entry.key == transaction.items.length - 1;
                final item = entry.value;

                final fakeTx = TransactionModel(
                  id: item.id,
                  accountId: transaction.accountId,
                  type: transaction.type,
                  amount: item.amount,
                  transactionDate: transaction.transactionDate,
                  createdAt: item.createdAt,
                  updatedAt: item.updatedAt,
                  destinationAccountId: transaction.destinationAccountId,
                  note: item.note ?? transaction.note,
                  items: [item],
                );

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : 8,
                  ),
                  child: RecentTransactionTile(
                    transaction: fakeTx,
                    isBalanceVisible: isBalanceVisible,
                    categoriesById: categoriesById,
                    account: account,
                    isSubItem: true,
                    onEdit: () => handleEditItem(entry.key),
                    onDelete: () => handleRemoveItem(entry.key),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
