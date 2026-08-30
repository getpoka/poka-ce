import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/shared/widgets/poka_slidable_action.dart';
import 'package:poka_ce/theme/theme.dart';

class CategoryTile extends ConsumerWidget with FTileMixin {
  const CategoryTile({
    required this.category,
    this.childCount = 0,
    this.onEdit,
    this.onDelete,
    this.onPress,
    this.isFirst = false,
    this.isLast = false,
    super.key,
  });

  final CategoryModel category;
  final int childCount;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onPress;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    // We get category color safely
    Color categoryColor;
    try {
      categoryColor = category.color?.toColor() ?? theme.colors.primary;
    } on Object catch (_) {
      categoryColor = theme.colors.primary;
    }

    final cardContent = FCard(
      clipBehavior: Clip.antiAlias,
      child: _buildTileContent(context, theme, categoryColor),
    );
    return Slidable(
      key: ValueKey(category.id),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.22,
        children: [
          PokaSlidableAction(
            icon: FPhosphorIcons.trash,
            color: theme.colors.destructive,
            isDestructive: true,
            onPressed: () async {
              if (onDelete != null) {
                onDelete!();
              } else {
                final confirm = await showPokaConfirmDialog(
                  context,
                  title: t.categories.deleteCategory,
                  body: childCount > 0
                      ? 'Are you sure you want to delete this category? Its $childCount subcategor${childCount > 1 ? 'ies' : 'y'} will become main categor${childCount > 1 ? 'ies' : 'y'}, and its own transactions will become uncategorized.'
                      : 'Are you sure you want to delete this category? All its transactions will become uncategorized.',
                  confirmText: t.categories.delete,
                );
                if (confirm == true) {
                  unawaited(ref.read(categoryListProvider.notifier).deleteCategory(category.id));
                }
              }
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
              onEdit?.call();
            },
          ),
        ],
      ),
      child: cardContent,
    );
  }

  Widget _buildTileContent(BuildContext context, FThemeData theme, Color categoryColor) {
    return FInheritedItemData.merge(
      index: 1, // Memaksa FTile menganggap dirinya bukan item pertama
      last: false, // Memaksa FTile menganggap dirinya bukan item terakhir
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPress,
        child: FTile(
          prefix: PokaIcon(
            icon: IconUtil.getIcon(category.icon),
            color: categoryColor,
          ),
          title: Text(
            category.name,
            style: theme.typography.titleItem,
          ),
          subtitle: childCount > 0
              ? Text(
                  t.categories.subcategoriesCount(count: childCount),
                  style: theme.typography.bodySecondary.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                )
              : null,
          suffix: onPress != null
              ? Icon(
                  FPhosphorIcons.caretRight,
                  color: theme.colors.mutedForeground,
                  size: 16,
                )
              : null,
        ),
      ),
    );
  }
}
