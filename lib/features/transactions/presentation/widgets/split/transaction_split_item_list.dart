import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile_content.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile_icon.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_slidable_action.dart';
import 'package:poka_ce/theme/theme.dart';

/// Renders the list of split items with swipe-to-delete and tap-to-edit.
class TransactionSplitItemList extends ConsumerWidget {
  const new({
    required this.splits,
    required this.transactionType,
    required this.onRemove,
    required this.onEdit,
    super.key,
  });

  final List<SplitItem> splits;
  final TransactionType transactionType;
  final ValueChanged<int> onRemove;
  final ValueChanged<int> onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: splits.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == splits.length - 1;

        return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
              child: _SplitItemCard(
                item: item,
                index: index,
                transactionType: transactionType,
                onEdit: onEdit,
                onRemove: onRemove,
              ),
            )
            .animate(key: ValueKey('split_item_$index'), delay: (index * 40).ms)
            .fadeIn(duration: 250.ms)
            .slideY(begin: 0.1, end: 0, duration: 250.ms, curve: Curves.easeOut);
      }).toList(),
    );
  }
}

class _SplitItemCard extends ConsumerWidget {
  const new({
    required this.item,
    required this.index,
    required this.transactionType,
    required this.onEdit,
    required this.onRemove,
  });

  final SplitItem item;
  final int index;
  final TransactionType transactionType;
  final ValueChanged<int> onEdit;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    // Resolve category data from the live provider
    final categoryList = ref.watch(categoryListProvider).value ?? <CategoryModel>[];
    final categoryData = categoryList.where((c) => c.id == item.categoryId).firstOrNull;

    final catColor = categoryData?.color?.toColor(theme.colors.primary) ?? theme.colors.primary;
    final catIcon = categoryData?.icon != null ? IconUtil.getIcon(categoryData!.icon) : FPhosphorIcons.tag;
    final catName = item.categoryName ?? categoryData?.name ?? t.common.uncategorized;

    IconData? subCatIcon;
    Color? subCatColor;
    if (categoryData?.parentId != null) {
      final parentCat = categoryList.where((c) => c.id == categoryData!.parentId).firstOrNull;
      if (parentCat != null) {
        subCatIcon = IconUtil.getIcon(parentCat.icon);
        subCatColor = parentCat.color?.toColor() ?? theme.colors.primary;
      }
    }

    final cardContent = FCard(
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onEdit(index),
        child: FTile(
          enabled: true,
          prefix: TransactionTileIcon(
            catColor: catColor,
            catIcon: catIcon,
            subCatIcon: subCatIcon,
            subCatColor: subCatColor,
          ),
          title: TransactionTileContent(
            catLabel: catName,
            catColor: catColor,
            hasMultipleItems: false,
            itemCount: 1,
            amount: item.amount,
            type: transactionType,
            isBalanceVisible: true,
            isTransfer: false,
            note: item.note,
            allocation: item.allocation,
          ),
        ),
      ),
    );

    return Slidable(
      key: ValueKey('split_slidable_$index'),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.22,
        children: [
          PokaSlidableAction(
            icon: FPhosphorIcons.trash,
            color: theme.colors.destructive,
            isDestructive: true,
            onPressed: () => onRemove(index),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.22,
        children: [
          PokaSlidableAction(
            icon: FPhosphorIcons.pencilSimple,
            color: theme.colors.primary,
            onPressed: () => onEdit(index),
          ),
        ],
      ),
      child: cardContent,
    );
  }
}
