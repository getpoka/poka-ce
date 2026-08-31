import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/categories/presentation/widgets/cards/category_hero_card.dart';
import 'package:poka_ce/features/categories/presentation/widgets/forms/category_form_sheet.dart';
import 'package:poka_ce/features/categories/presentation/widgets/tiles/category_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';
import 'package:poka_ce/theme/theme.dart';

/// Screen for displaying details of a specific category and its sub-categories.
class CategoryDetailPage extends ConsumerWidget {
  const CategoryDetailPage({
    required this.category,
    super.key,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryListProvider);
    final map = ref.watch(categoryMapProvider);
    final activeCategory = map[category.id] ?? category;

    // Find subcategories belonging to this parent
    final categories = state.value ?? <CategoryModel>[];
    final subcategories = categories.where((c) => c.parentId == activeCategory.id).toList();

    return FScaffold(
      header: PokaHeader(
        title: activeCategory.name,
        showBack: true,
      ),
      child: RefreshIndicator(
        onRefresh: () => ref.read(categoryListProvider.notifier).refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Parent Hero Info
              CategoryHeroCard(
                category: activeCategory,
                onToggleActive: (value) {
                  ref.read(categoryListProvider.notifier).toggleActive(activeCategory, isActive: value);
                },
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PokaSectionLabel(title: t.categories.subcategories),
                  Builder(
                    builder: (context) => GestureDetector(
                      key: const Key('subcategory-add-button'),
                      onTap: () => CategoryFormSheet.show(
                        context,
                        parentId: activeCategory.id,
                        initialType: activeCategory.type,
                      ),
                      child: Row(
                        children: [
                          Icon(FPhosphorIcons.plus, size: 14, color: context.theme.colors.primary),
                          const SizedBox(width: 4),
                          Text(
                            t.categories.addSubcategory,
                            style: context.theme.typography.bodySecondary.copyWith(
                              color: context.theme.colors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              if (subcategories.isEmpty)
                PokaEmptyView(
                  icon: FPhosphorIcons.tag,
                  title: t.categories.noSubcategoriesYet,
                  subtitle: t.categories.emptySubcategorySubtitle,
                  actionLabel: t.categories.addSubcategory,
                  onAction: () => CategoryFormSheet.show(
                    context,
                    parentId: activeCategory.id,
                    initialType: activeCategory.type,
                  ),
                )
              else
                ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subcategories.length,
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
                    ref
                        .read(categoryListProvider.notifier)
                        .reorderCategories(
                          oldIndex,
                          newIndex,
                          activeCategory.type,
                          parentId: activeCategory.id,
                        );
                  },
                  itemBuilder: (context, index) {
                    final subcat = subcategories[index];
                    return Padding(
                      key: ValueKey(subcat.id),
                      padding: EdgeInsets.only(bottom: index == subcategories.length - 1 ? 0 : 8),
                      child: CategoryTile(
                        category: subcat,
                        isFirst: index == 0,
                        isLast: index == subcategories.length - 1,
                        onEdit: () => CategoryFormSheet.show(context, category: subcat),
                        onToggleActive: (value) {
                          ref.read(categoryListProvider.notifier).toggleActive(subcat, isActive: value);
                        },
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
