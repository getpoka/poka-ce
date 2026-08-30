import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_pill.dart';

/// A group of selectable pills for filtering by category.
class TransactionFilterCategoryGroup extends HookWidget {
  const TransactionFilterCategoryGroup({
    required this.categories,
    required this.selectedIds,
    required this.onChanged,
    super.key,
  });

  final List<CategoryModel> categories;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    final activeParentId = useState<String?>(null);

    final topCategories = categories.where((c) => c.parentId == null).toList();
    final categoryChildren = activeParentId.value != null
        ? categories.where((c) => c.parentId == activeParentId.value).toList()
        : <CategoryModel>[];

    if (topCategories.isEmpty) return const SizedBox.shrink();

    return FLabel(
      layout: FLabelLayout.vertical,
      label: Text(t.transactions.category),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Parent pills
          PokaPillScrollRow(
            children: topCategories.map((cat) {
              final isSelected = selectedIds.contains(cat.id);
              final isExpanded = activeParentId.value == cat.id;
              final color = Color(
                int.parse(
                  cat.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8',
                ),
              );
              return PokaPill(
                icon: IconUtil.getIcon(cat.icon),
                label: cat.name,
                color: color,
                isSelected: isSelected || isExpanded,
                onTap: () {
                  if (isExpanded) {
                    activeParentId.value = null;
                    final next = Set<String>.from(selectedIds)..remove(cat.id);
                    categories.where((c) => c.parentId == cat.id).forEach((c) => next.remove(c.id));
                    onChanged(next);
                  } else {
                    final oldParent = activeParentId.value;
                    final next = Set<String>.from(selectedIds);
                    if (oldParent != null) {
                      next.remove(oldParent);
                      categories.where((c) => c.parentId == oldParent).forEach((c) => next.remove(c.id));
                    }
                    next.add(cat.id);
                    activeParentId.value = cat.id;
                    onChanged(next);
                  }
                },
              );
            }).toList(),
          ),

          // Subcategory pills
          if (categoryChildren.isNotEmpty) ...[
            const SizedBox(height: 6),
            PokaPillScrollRow(
              children: categoryChildren.map((sub) {
                final isSelected = selectedIds.contains(sub.id);
                final color = Color(
                  int.parse(
                    sub.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8',
                  ),
                );
                return PokaPill(
                  icon: IconUtil.getIcon(sub.icon),
                  label: sub.name,
                  color: color,
                  isSelected: isSelected,
                  isChild: true,
                  onTap: () {
                    final next = Set<String>.from(selectedIds);
                    isSelected ? next.remove(sub.id) : next.add(sub.id);
                    onChanged(next);
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
