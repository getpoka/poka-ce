import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

class CategoryPickerSheet extends ConsumerWidget {
  const CategoryPickerSheet({super.key});

  static Future<CategoryModel?> show(BuildContext context) {
    return showPokaSheet<CategoryModel>(
      context: context,
      builder: (context) => PokaSheet(
        title: t.transactions.selectCategory,
        child: const CategoryPickerSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(author): Connect to CategoryListNotifier once CategoryRepository is implemented.
    // For now, using dummy categories so the UI is testable.
    final categories = [
      CategoryModel(
        id: 'cat-1',
        name: 'Food & Dining',
        type: CategoryType.expense,
        icon: 'forkKnife',
        color: '#FF5733',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CategoryModel(
        id: 'cat-2',
        name: 'Transportation',
        type: CategoryType.expense,
        icon: 'car',
        color: '#33A1FF',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CategoryModel(
        id: 'cat-3',
        name: 'Salary',
        type: CategoryType.income,
        icon: 'money',
        color: '#33FF57',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: categories.map((cat) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(cat),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: context.theme.colors.border,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(FPhosphorIcons.tag, size: 24, color: context.theme.colors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    cat.name,
                    style: context.theme.typography.body.lg.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
