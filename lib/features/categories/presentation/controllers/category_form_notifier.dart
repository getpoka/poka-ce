import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'category_form_notifier.freezed.dart';
part 'category_form_notifier.g.dart';

@freezed
abstract class CategoryFormState with _$CategoryFormState {
  const factory CategoryFormState({
    CategoryModel? initialCategory,
    @Default('') String name,
    @Default(CategoryType.expense) CategoryType type,
    String? icon,
    String? color,
    String? parentId,
    @Default(false) bool isSaving,
    @Default(false) bool isSuccess,
    String? error,
  }) = _CategoryFormState;
}

@riverpod
class CategoryFormNotifier extends _$CategoryFormNotifier {
  @override
  CategoryFormState build() {
    return const CategoryFormState();
  }

  void init(CategoryModel? category) {
    if (category != null) {
      state = CategoryFormState(
        initialCategory: category,
        name: category.name,
        type: category.type,
        icon: category.icon,
        color: category.color,
        parentId: category.parentId,
      );
    } else {
      state = const CategoryFormState();
    }
  }

  void setName(String name) => state = state.copyWith(name: name);
  void setType(CategoryType type) => state = state.copyWith(type: type);
  void setIcon(String? icon) => state = state.copyWith(icon: icon);
  void setColor(String? color) => state = state.copyWith(color: color);
  void setParentId(String? parentId) => state = state.copyWith(parentId: parentId);

  Future<void> save() async {
    if (state.name.trim().isEmpty) {
      state = state.copyWith(error: 'Name cannot be empty');
      return;
    }

    state = state.copyWith(isSaving: true, error: null);
    final repo = ref.read(categoryRepositoryProvider);

    final now = DateTimeUtils.nowUtc();
    final model =
        state.initialCategory?.copyWith(
          name: state.name.trim(),
          type: state.type,
          icon: state.icon,
          color: state.color,
          parentId: state.parentId,
          updatedAt: now,
        ) ??
        CategoryModel(
          id: const Uuid().v7(),
          name: state.name.trim(),
          type: state.type,
          icon: state.icon,
          color: state.color,
          parentId: state.parentId,
          createdAt: now,
          updatedAt: now,
        );

    final result = state.initialCategory == null ? await repo.createCategory(model) : await repo.updateCategory(model);

    switch (result) {
      case Success():
        await ref.read(categoryListProvider.notifier).refresh();
        state = state.copyWith(isSaving: false, isSuccess: true);
      case ErrorResult(error: final failure):
        state = state.copyWith(
          error: failure.message,
          isSaving: false,
        );
    }
  }
}
