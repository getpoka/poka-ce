import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_slidable_action.dart';
import 'package:poka_ce/theme/theme.dart';

/// Renders the list of split items with swipe-to-delete and tap-to-edit.
class TransactionSplitItemList extends ConsumerWidget {
  const TransactionSplitItemList({
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

        return _SplitItemCard(
              item: item,
              index: index,
              isLast: isLast,
              transactionType: transactionType,
              onEdit: onEdit,
              onRemove: onRemove,
            )
            .animate(key: ValueKey('split_item_$index'), delay: (index * 40).ms)
            .fadeIn(duration: 250.ms)
            .slideY(begin: 0.1, end: 0, duration: 250.ms, curve: Curves.easeOut);
      }).toList(),
    );
  }
}

class _SplitItemCard extends ConsumerWidget {
  const _SplitItemCard({
    required this.item,
    required this.index,
    required this.isLast,
    required this.transactionType,
    required this.onEdit,
    required this.onRemove,
  });

  final SplitItem item;
  final int index;
  final bool isLast;
  final TransactionType transactionType;
  final ValueChanged<int> onEdit;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;

    // Resolve category data from the live provider
    final categoryList = ref.watch(categoryListProvider).value ?? <CategoryModel>[];
    final categoryData = categoryList.where((c) => c.id == item.categoryId).firstOrNull;

    final catColor = categoryData?.color != null
        ? Color(int.parse(categoryData!.color!.replaceFirst('#', '0xFF')))
        : colors.primary;
    final catIcon = categoryData?.icon != null ? IconUtil.getIcon(categoryData!.icon) : FPhosphorIcons.tag;
    final catName = item.categoryName ?? categoryData?.name ?? 'Uncategorized';

    final borderRadius = theme.style.borderRadius.lg;

    return Column(
      children: [
        Slidable(
          key: ValueKey('split_slidable_$index'),
          startActionPane: ActionPane(
            motion: const BehindMotion(),
            extentRatio: 0.22,
            children: [
              PokaSlidableAction(
                icon: FPhosphorIcons.trash,
                color: theme.colors.destructive,
                isDestructive: true,
                onPressed: () {
                  onRemove(index);
                },
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
                onPressed: () {
                  onEdit(index);
                },
              ),
            ],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.vertical(
                top: index == 0 ? borderRadius.topLeft : Radius.zero,
                bottom: isLast ? borderRadius.bottomLeft : Radius.zero,
              ),
              border: Border(
                left: BorderSide(color: colors.border),
                right: BorderSide(color: colors.border),
                top: index == 0 ? BorderSide(color: colors.border) : BorderSide.none,
                bottom: isLast ? BorderSide(color: colors.border) : BorderSide.none,
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onEdit(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        // Category icon badge
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: catColor.withValues(alpha: 0.12),
                            borderRadius: theme.style.borderRadius.md,
                            border: Border.all(color: catColor.withValues(alpha: 0.25)),
                          ),
                          child: Icon(catIcon, color: catColor, size: 17),
                        ),
                        const SizedBox(width: 12),

                        // Category + note
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                catName,
                                style: typography.bodyPrimary.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colors.foreground,
                                ),
                              ),
                              if (item.note?.isNotEmpty == true) ...[
                                const SizedBox(height: 2),
                                Text(
                                  item.note!,
                                  style: typography.bodySecondary.copyWith(color: colors.mutedForeground),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Amount
                        PokaAmountText(
                          amount: item.amount,
                          type: transactionType,
                          style: typography.titleCard,
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLast)
                  Padding(
                    padding: const EdgeInsets.only(left: 64),
                    child: Divider(height: 1, thickness: 1, color: colors.border),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
