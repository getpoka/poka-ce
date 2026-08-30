import 'package:flutter/material.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_pill.dart';
import 'package:poka_ce/theme/theme.dart';

class CategorySelectorShelf extends StatelessWidget {
  const CategorySelectorShelf({
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    super.key,
  });

  final List<CategoryModel> categories;
  final String? selectedCategoryId;
  final ValueChanged<CategoryModel?> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    if (categories.isEmpty) {
      return SizedBox(
        height: 38,
        child: Center(
          child: Text(
            t.categories.noCategoriesFound1,
            style: theme.typography.bodyPrimary,
          ),
        ),
      );
    }

    final parents = categories.where((c) => c.parentId == null).toList();
    final selectedCat = categories.where((c) => c.id == selectedCategoryId).firstOrNull;
    final activeParentId = selectedCat?.parentId != null ? selectedCat!.parentId : selectedCat?.id;
    final subs = activeParentId != null
        ? categories.where((c) => c.parentId == activeParentId).toList()
        : <CategoryModel>[];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PokaPillScrollRow(
          children: parents.map((cat) {
            final isSel = activeParentId == cat.id;
            final catColor = Color(int.parse(cat.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8'));
            return PokaPill(
              icon: IconUtil.getIcon(cat.icon),
              label: cat.name,
              color: catColor,
              isSelected: isSel,
              onTap: () {
                if (selectedCategoryId == cat.id) {
                  onCategorySelected(null);
                } else {
                  onCategorySelected(cat);
                }
              },
            );
          }).toList(),
        ),
        if (subs.isNotEmpty) ...[
          const SizedBox(height: 6),
          PokaPillScrollRow(
            children: subs.map((sub) {
              final isSel = selectedCategoryId == sub.id;
              final subColor = Color(int.parse(sub.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8'));
              return PokaPill(
                icon: IconUtil.getIcon(sub.icon),
                label: sub.name,
                color: subColor,
                isSelected: isSel,
                isChild: true,
                onTap: () {
                  if (selectedCategoryId == sub.id) {
                    onCategorySelected(null);
                  } else {
                    onCategorySelected(sub);
                  }
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
