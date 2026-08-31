import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_list_notifier.g.dart';

/// StateNotifier for managing the list of categories.
/// Handles fetching, refreshing, toggling active status, deleting, and reordering.
@riverpod
class CategoryListNotifier extends _$CategoryListNotifier {
  @override
  Future<List<CategoryModel>> build() async {
    final repo = ref.read(categoryRepositoryProvider);
    final result = await repo.getCategories();
    return switch (result) {
      Success(value: final categories) => categories,
      ErrorResult(error: final failure) => throw Exception(failure.message),
    };
  }

  /// Refreshes the category list from the repository.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(categoryRepositoryProvider);
      final result = await repo.getCategories();
      return switch (result) {
        Success(value: final categories) => categories,
        ErrorResult(error: final failure) => throw Exception(failure.message),
      };
    });
  }

  /// Toggles the active status of a specific category and refreshes the list upon success.
  Future<void> toggleActive(CategoryModel category, {required bool isActive}) async {
    final repo = ref.read(categoryRepositoryProvider);
    final result = await repo.toggleCategoryActiveStatus(category.id, isActive: isActive);
    if (result is Success) {
      await refresh();
    }
  }

  /// Deletes a category and refreshes the list upon success.
  Future<void> deleteCategory(String id) async {
    final repo = ref.read(categoryRepositoryProvider);
    final result = await repo.deleteCategory(id);
    if (result is Success) {
      await refresh();
    }
  }

  /// Reorders categories of a specific type (and optionally under a specific parent).
  /// Optimistically updates the local state before saving to the database.
  Future<void> reorderCategories(int oldIndex, int newIndex, CategoryType type, {String? parentId}) async {
    final currentCategories = state.value ?? <CategoryModel>[];
    if (currentCategories.isEmpty) return;

    final targetCategories = currentCategories.where((c) => c.type == type && c.parentId == parentId).toList();

    final item = targetCategories.removeAt(oldIndex);
    targetCategories.insert(newIndex, item);

    // Create a map to quickly update the original list
    final targetIds = targetCategories.map((c) => c.id).toSet();

    // Create new list keeping other categories intact, but appending target categories in new order
    final newCategories = currentCategories.where((c) => !targetIds.contains(c.id)).toList()..addAll(targetCategories);

    // Optimistically update state
    state = AsyncData(newCategories);

    // Then save to DB
    final repo = ref.read(categoryRepositoryProvider);
    await repo.reorderCategories(targetCategories);
  }
}

/// Provides a quick lookup map of categories by their ID, fed from the reactive stream.
@riverpod
Map<String, CategoryModel> categoryMap(Ref ref) {
  final categories = ref.watch(categoriesStreamProvider).value ?? [];
  return {for (final c in categories) c.id: c};
}
