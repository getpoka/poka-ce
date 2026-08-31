import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/categories/presentation/screens/category_detail_page.dart';
import 'package:poka_ce/features/categories/presentation/widgets/forms/category_form_sheet.dart';
import 'package:poka_ce/features/categories/presentation/widgets/tiles/category_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// A tab view displaying a list of categories (e.g., Expense or Income).
/// Handles reordering functionality and navigation to category details.
class CategoryListTab extends ConsumerWidget {
  const CategoryListTab({
    required this.categories,
    required this.allCategories,
    required this.type,
    super.key,
  });

  final List<CategoryModel> categories;
  final List<CategoryModel> allCategories;
  final CategoryType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (categories.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(child: Text(t.categories.noCategoriesFound)),
      ).animate().fade(duration: 300.ms);
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: categories.length,
      onReorderStart: (_) {
        HapticFeedback.mediumImpact();
      },
      proxyDecorator: (child, index, animation) {
        return Material(
          color: Colors.transparent,
          child: child,
        );
      },
      onReorderItem: (oldIndex, newIndex) {
        ref.read(categoryListProvider.notifier).reorderCategories(oldIndex, newIndex, type);
      },
      itemBuilder: (context, index) {
        final category = categories[index];
        final childCount = allCategories.where((c) => c.parentId == category.id).length;

        return Padding(
          key: ValueKey(category.id),
          padding: EdgeInsets.only(bottom: index == categories.length - 1 ? 0 : 8),
          child:
              CategoryTile(
                    category: category,
                    childCount: childCount,
                    isFirst: index == 0,
                    isLast: index == categories.length - 1,
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => CategoryDetailPage(category: category),
                        ),
                      );
                    },
                    onEdit: () {
                      CategoryFormSheet.show(context, category: category);
                    },
                  )
                  .animate(
                    delay: Duration(milliseconds: (index * 40).clamp(0, 200)),
                  )
                  .fade(duration: 260.ms)
                  .slideX(begin: 0.05, end: 0),
        );
      },
    );
  }
}
