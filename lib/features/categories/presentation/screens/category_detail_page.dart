import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/categories/presentation/widgets/cards/category_hero_card.dart';
import 'package:poka_ce/features/categories/presentation/widgets/forms/category_form_sheet.dart';
import 'package:poka_ce/features/categories/presentation/widgets/tiles/category_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';

class CategoryDetailPage extends ConsumerWidget {
  const CategoryDetailPage({
    required this.category,
    super.key,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryListProvider);
    final theme = context.theme;

    // Find subcategories belonging to this parent
    final categories = state.value ?? <CategoryModel>[];
    final subcategories = categories.where((c) => c.parentId == category.id).toList();

    return FScaffold(
      header: PokaHeader(
        title: category.name,
        showBack: true,
        suffixes: [
          FHeaderAction(
            icon: const Icon(FPhosphorIcons.plus, size: 20),
            onPress: () => CategoryFormSheet.show(
              context,
              category: CategoryModel(
                id: '', // Will be generated on save if it's new
                name: '',
                type: category.type, // Inherit type
                parentId: category.id, // Pre-fill parent
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            ),
          ),
        ],
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
              CategoryHeroCard(category: category),
              const SizedBox(height: 24),

              PokaSectionLabel(title: t.categories.subcategories),
              const SizedBox(height: 8),

              if (subcategories.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(FPhosphorIcons.tag, size: 36, color: theme.colors.mutedForeground),
                        const SizedBox(height: 8),
                        Text(
                          t.categories.noSubcategoriesYet,
                          style: theme.typography.body.md.copyWith(color: theme.colors.mutedForeground),
                        ),
                      ],
                    ),
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
                          category.type,
                          parentId: category.id,
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
