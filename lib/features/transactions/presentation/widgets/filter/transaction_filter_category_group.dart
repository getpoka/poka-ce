import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_pill.dart';
import 'package:poka_ce/theme/theme.dart';

/// A group of selectable pills for filtering by category.
///
/// When [selectedTypes] contains only income or only expense types, only the
/// matching categories are shown. When [selectedTypes] is empty or mixed, all
/// categories are shown grouped under Income / Expense sub-headers.
/// Each sub-group manages its own expanded sub-category state independently.
class TransactionFilterCategoryGroup extends HookWidget {
  const new({
    required this.categories,
    required this.selectedIds,
    required this.onChanged,
    this.selectedTypes = const {},
    super.key,
  });

  final List<CategoryModel> categories;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;

  /// The currently active type filter — used to determine which categories to show.
  final Set<TransactionType> selectedTypes;

  @override
  Widget build(BuildContext context) {
    // Determine which category types to display based on the active type filter.
    // Transfer has no categories, so show all when transfer-only filter is active.
    final showIncome =
        selectedTypes.isEmpty ||
        selectedTypes.contains(TransactionType.income) ||
        (selectedTypes.length == 1 && selectedTypes.contains(TransactionType.transfer));
    final showExpense =
        selectedTypes.isEmpty ||
        selectedTypes.contains(TransactionType.expense) ||
        (selectedTypes.length == 1 && selectedTypes.contains(TransactionType.transfer));

    final incomeCategories = categories.where((c) => c.parentId == null && c.type == CategoryType.income).toList();
    final expenseCategories = categories.where((c) => c.parentId == null && c.type == CategoryType.expense).toList();

    // Show headers only when both groups are visible simultaneously.
    final singleGroup = (showIncome && !showExpense) || (!showIncome && showExpense);

    if (!showIncome && !showExpense) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showIncome && incomeCategories.isNotEmpty) ...[
          if (!singleGroup) ...[
            DefaultTextStyle(
              style: context.theme.style.formFieldStyle.labelTextStyle.base,
              child: Text(t.transactions.income),
            ),
            const SizedBox(height: 6),
          ],
          // Each _CategoryPillRow owns its own activeParentId state.
          _CategoryPillRow(
            categories: incomeCategories,
            allCategories: categories,
            selectedIds: selectedIds,
            onChanged: onChanged,
          ),
        ],
        if (showExpense && expenseCategories.isNotEmpty) ...[
          if (showIncome && incomeCategories.isNotEmpty) const SizedBox(height: 12),
          if (!singleGroup) ...[
            DefaultTextStyle(
              style: context.theme.style.formFieldStyle.labelTextStyle.base,
              child: Text(t.transactions.expense),
            ),
            const SizedBox(height: 6),
          ],
          _CategoryPillRow(
            categories: expenseCategories,
            allCategories: categories,
            selectedIds: selectedIds,
            onChanged: onChanged,
          ),
        ],
      ],
    );
  }
}

/// Internal widget rendering a scrollable pill row for a single category group.
///
/// Owns its own activeParentId state so that expanding a parent in the income
/// group never affects the expense group (and vice-versa).
class _CategoryPillRow extends HookWidget {
  const new({
    required this.categories,
    required this.allCategories,
    required this.selectedIds,
    required this.onChanged,
  });

  final List<CategoryModel> categories;
  final List<CategoryModel> allCategories;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    // Local state — independent per group instance.
    final activeParentId = useState<String?>(null);

    final categoryChildren = activeParentId.value != null
        ? allCategories.where((c) => c.parentId == activeParentId.value).toList()
        : <CategoryModel>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PokaPillScrollRow(
          children: categories.map((cat) {
            final isSelected = selectedIds.contains(cat.id);
            final isExpanded = activeParentId.value == cat.id;
            final color = Color(int.parse(cat.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8'));
            return PokaPill(
              icon: IconUtil.getIcon(cat.icon),
              label: cat.name,
              color: color,
              isSelected: isSelected || isExpanded,
              onTap: () {
                if (isExpanded) {
                  // Collapse — deselect parent and its children.
                  activeParentId.value = null;
                  final next = Set<String>.from(selectedIds)..remove(cat.id);
                  allCategories.where((c) => c.parentId == cat.id).forEach((c) => next.remove(c.id));
                  onChanged(next);
                } else {
                  // Expand — deselect old parent/children, select new parent.
                  final oldParent = activeParentId.value;
                  final next = Set<String>.from(selectedIds);
                  if (oldParent != null) {
                    next.remove(oldParent);
                    allCategories.where((c) => c.parentId == oldParent).forEach((c) => next.remove(c.id));
                  }
                  next.add(cat.id);
                  activeParentId.value = cat.id;
                  onChanged(next);
                }
              },
            );
          }).toList(),
        ),
        if (categoryChildren.isNotEmpty) ...[
          const SizedBox(height: 6),
          PokaPillScrollRow(
            children: categoryChildren.map((sub) {
              final isSelected = selectedIds.contains(sub.id);
              final color = Color(int.parse(sub.color?.replaceFirst('#', '0xFF') ?? '0xFF94A3B8'));
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
    );
  }
}
