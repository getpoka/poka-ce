import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';

/// Interface defining the contract for category data operations.
/// Repositories implementing this interface handle domain mapping, failure translation, and validation.
abstract class ICategoryRepository {
  Future<Result<List<CategoryModel>, Failure>> getCategories();
  Stream<Result<List<CategoryModel>, Failure>> watchCategories();
  Future<Result<List<CategoryModel>, Failure>> getActiveCategories();
  Future<Result<CategoryModel, Failure>> getCategoryById(String id);
  Future<Result<void, Failure>> createCategory(CategoryModel model);
  Future<Result<void, Failure>> updateCategory(CategoryModel model);
  Future<Result<void, Failure>> toggleCategoryActiveStatus(String id, {required bool isActive});
  Future<Result<void, Failure>> deleteCategory(String id);
  Future<Result<void, Failure>> reorderCategories(List<CategoryModel> categories);
}
