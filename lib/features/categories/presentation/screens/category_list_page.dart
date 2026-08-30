import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/categories/presentation/widgets/forms/category_form_sheet.dart';
import 'package:poka_ce/features/categories/presentation/widgets/views/category_list_tab.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';

class CategoryListPage extends ConsumerWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryListProvider);
    final categories = state.value ?? <CategoryModel>[];

    // Only show parent categories
    final incomeCategories = categories.where((c) => c.type == CategoryType.income && c.parentId == null).toList();
    final expenseCategories = categories.where((c) => c.type == CategoryType.expense && c.parentId == null).toList();

    return FScaffold(
      header: PokaHeader(
        title: t.categories.categories,
        showBack: true,
        suffixes: [
          FHeaderAction(
            key: const Key('category-add-button'),
            icon: const Icon(FPhosphorIcons.plus, size: 20),
            onPress: () => CategoryFormSheet.show(context),
          ),
        ],
      ),
      child: state.when(
        data: (data) => RefreshIndicator(
          onRefresh: () => ref.read(categoryListProvider.notifier).refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            child: FTabs(
              children: [
                FTabEntry(
                  label: Text(t.accounts.expense),
                  child: CategoryListTab(
                    categories: expenseCategories,
                    allCategories: categories,
                    type: CategoryType.expense,
                  ),
                ),
                FTabEntry(
                  label: Text(t.accounts.income),
                  child: CategoryListTab(
                    categories: incomeCategories,
                    allCategories: categories,
                    type: CategoryType.income,
                  ),
                ),
              ],
            ),
          ),
        ),
        error: (err, _) => Center(child: Text(err.toString())),
        loading: () => const Center(child: FCircularProgress()),
      ),
    );
  }
}
