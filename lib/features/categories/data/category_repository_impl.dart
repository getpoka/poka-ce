import 'package:drift/drift.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/database/daos/categories_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';

class CategoryRepositoryImpl implements ICategoryRepository {
  CategoryRepositoryImpl(this._dao);
  final CategoriesDao _dao;

  @override
  Future<Result<List<CategoryModel>, Failure>> getCategories() async {
    try {
      final categories = await _dao.getAllCategories();
      final models = categories.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.getCategories');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<Result<List<CategoryModel>, Failure>> watchCategories() async* {
    try {
      await for (final categories in _dao.watchAllCategories()) {
        final models = categories.map(_mapToModel).toList();
        yield Success(models);
      }
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.watchCategories');
      yield ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<CategoryModel>, Failure>> getActiveCategories() async {
    try {
      final categories = await _dao.getActiveCategories();
      final models = categories.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.getActiveCategories');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<CategoryModel, Failure>> getCategoryById(String id) async {
    try {
      final category = await _dao.getCategory(id);
      if (category == null) {
        return const ErrorResult(DatabaseFailure('Category not found'));
      }
      return Success(_mapToModel(category));
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.getCategoryById');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> createCategory(CategoryModel model) async {
    try {
      await _dao.transaction(() async {
        await _dao.insertCategory(
          db.CategoriesCompanion.insert(
            id: Value(model.id),
            name: model.name,
            type: model.type,
            icon: Value(model.icon),
            color: Value(model.color),
            parentId: Value(model.parentId),
            sort: Value(model.sort),
            isActive: Value(model.isActive),
            createdAt: Value(model.createdAt.toUtc()),
            updatedAt: Value(model.updatedAt.toUtc()),
          ),
        );

        if (model.parentId != null) {
          await _dao.syncSubCategoryToAccounts(model.parentId!, model.id);
        }
      });
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.createCategory');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateCategory(CategoryModel model) async {
    try {
      await _dao.updateCategory(
        db.CategoriesCompanion(
          id: Value(model.id),
          name: Value(model.name),
          type: Value(model.type),
          icon: Value(model.icon),
          color: Value(model.color),
          parentId: Value(model.parentId),
          isActive: Value(model.isActive),
          updatedAt: Value(DateTimeUtils.nowUtc()),
        ),
      );
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.updateCategory');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deactivateCategory(String id) async {
    try {
      await _dao.deactivateCategory(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.deactivateCategory');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deleteCategory(String id) async {
    try {
      await _dao.deleteCategory(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.deleteCategory');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> reorderCategories(List<CategoryModel> categories) async {
    try {
      final orders = {for (var i = 0; i < categories.length; i++) categories[i].id: i};
      await _dao.updateCategoriesSort(orders);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'CategoryRepositoryImpl.reorderCategories');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  CategoryModel _mapToModel(db.Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      type: category.type,
      icon: category.icon,
      color: category.color,
      parentId: category.parentId,
      sort: category.sort,
      isActive: category.isActive,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }
}
