import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_form_notifier.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

class CategorySelectionSheet extends ConsumerWidget {
  const CategorySelectionSheet({required this.notifier, super.key});

  final AccountFormNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryListProvider);
    // Watch live form state — rebuilds on every selection change
    final formState = ref.watch(accountFormProvider);
    final selected = formState.restrictedCategoryIds.toSet();

    if (categoryState.isLoading) {
      return PokaSheet(
        title: t.accounts.allowedCategories,
        child: const Center(child: FCircularProgress()),
      );
    }

    final allCategories = categoryState.value ?? <CategoryModel>[];

    // Group: parentId → children
    final childrenMap = <String, List<CategoryModel>>{};
    final rootCategories = <CategoryModel>[];
    for (final cat in allCategories) {
      if (cat.parentId == null) {
        rootCategories.add(cat);
      } else {
        childrenMap.putIfAbsent(cat.parentId!, () => []).add(cat);
      }
    }

    // Split by type
    final incomeRoots = rootCategories.where((c) => c.type == CategoryType.income).toList();
    final expenseRoots = rootCategories.where((c) => c.type == CategoryType.expense).toList();

    Widget buildTab(List<CategoryModel> roots) {
      if (roots.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Center(
            child: Text(
              t.accounts.noCategoriesAvailable,
              style: context.theme.typography.body.md.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            ),
          ),
        );
      }

      final groups = <Widget>[];

      for (final parent in roots) {
        final children = childrenMap[parent.id] ?? [];
        final childIds = children.map((c) => c.id).toList();
        // IDs relevant to this group: parent + all children
        final groupIds = {parent.id, ...childIds};
        // Subset of selected that belongs to this group
        final groupSelected = selected.intersection(groupIds);

        final color = parent.color?.toColor() ?? context.theme.colors.primary;

        // Build all tiles for this group: parent tile first, then children
        final tiles = <FSelectTile<String>>[
          FSelectTile.suffix(
            prefix: Icon(IconUtil.getIcon(parent.icon), size: 18, color: color),
            title: Text(
              parent.name,
              style: context.theme.typography.titleCard,
            ),
            subtitle: children.isNotEmpty
                ? Text(
                    '${children.length} subcategor${children.length == 1 ? 'y' : 'ies'}',
                    style: context.theme.typography.bodySecondary.copyWith(
                      color: context.theme.colors.mutedForeground,
                    ),
                  )
                : null,
            value: parent.id,
          ),
          ...children.map((child) {
            final childColor = child.color?.toColor() ?? context.theme.colors.primary;
            return FSelectTile.suffix(
              prefix: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(
                  IconUtil.getIcon(child.icon),
                  size: 16,
                  color: childColor,
                ),
              ),
              title: Text(child.name),
              value: child.id,
            );
          }),
        ];

        groups
          ..add(
            FSelectTileGroup<String>(
              control: FMultiValueControl.lifted(
                value: groupSelected,
                onChange: (next) {
                  // Diff to detect which tile was toggled
                  final added = next.difference(groupSelected);
                  final removed = groupSelected.difference(next);
                  final toggled = added.isNotEmpty ? added.first : removed.first;

                  if (toggled == parent.id) {
                    // Parent tile tapped → toggle all children
                    notifier.toggleParentCategory(parent.id, childIds);
                  } else {
                    // Child tile tapped → toggle single child + sync parent
                    notifier.toggleChildCategory(
                      categoryId: toggled,
                      parentId: parent.id,
                      allSiblingIds: childIds,
                    );
                  }
                },
              ),
              children: tiles,
            ),
          )
          ..add(const SizedBox(height: 8));
      }

      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16),
        physics: const NeverScrollableScrollPhysics(),
        children: groups,
      );
    }

    return PokaSheet(
      title: t.accounts.allowedCategories,
      child: FTabs(
        children: [
          FTabEntry(
            label: Text(t.accounts.income),
            child: buildTab(incomeRoots),
          ),
          FTabEntry(
            label: Text(t.accounts.expense),
            child: buildTab(expenseRoots),
          ),
        ],
      ),
    );
  }
}
