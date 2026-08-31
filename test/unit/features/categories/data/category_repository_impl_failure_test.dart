// Tests exception-to-Failure translation of CategoryRepositoryImpl by mocking
// its DAO to throw, covering every defensive catch branch.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/daos/categories_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/categories/data/category_repository_impl.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';

class MockCategoriesDao extends Mock implements CategoriesDao {
  @override
  Future<T> transaction<T>(Future<T> Function() action, {bool requireNew = false}) async {
    return await action();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockCategoriesDao dao;
  late CategoryRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(const db.CategoriesCompanion());
  });

  setUp(() {
    dao = MockCategoriesDao();
    repository = CategoryRepositoryImpl(dao);
  });

  test('getCategories returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getAllCategories()).thenThrow(Exception('boom'));

    final result = await repository.getCategories();

    expect(result, isA<ErrorResult<List<CategoryModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getActiveCategories returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getActiveCategories()).thenThrow(Exception('boom'));

    final result = await repository.getActiveCategories();

    expect(result, isA<ErrorResult<List<CategoryModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getCategoryById returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getCategory(any())).thenThrow(Exception('boom'));

    final result = await repository.getCategoryById('cat-1');

    expect(result, isA<ErrorResult<CategoryModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('createCategory returns DatabaseFailure when DAO throws', () async {
    when(() => dao.insertCategory(any())).thenThrow(Exception('boom'));

    final result = await repository.createCategory(_buildCategory());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('updateCategory returns DatabaseFailure when DAO throws', () async {
    when(() => dao.updateCategory(any())).thenThrow(Exception('boom'));

    final result = await repository.updateCategory(_buildCategory());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('toggleCategoryActiveStatus returns DatabaseFailure when DAO throws', () async {
    when(() => dao.toggleCategoryActiveStatus(any(), isActive: any(named: 'isActive'))).thenThrow(Exception('boom'));

    final result = await repository.toggleCategoryActiveStatus('cat-1', isActive: false);

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('watchCategories returns DatabaseFailure when DAO throws', () async {
    when(() => dao.watchAllCategories()).thenAnswer((_) => Stream.error(Exception('boom')));

    final stream = repository.watchCategories();
    final result = await stream.first;

    expect(result, isA<ErrorResult<List<CategoryModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('deleteCategory returns DatabaseFailure when DAO throws', () async {
    when(() => dao.deleteCategory(any())).thenThrow(Exception('boom'));

    final result = await repository.deleteCategory('cat-1');

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('reorderCategories returns DatabaseFailure when DAO throws', () async {
    when(() => dao.updateCategoriesSort(any())).thenThrow(Exception('boom'));

    final result = await repository.reorderCategories([_buildCategory()]);

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });
}

CategoryModel _buildCategory() {
  return CategoryModel(
    id: 'cat-1',
    name: 'Food',
    type: CategoryType.expense,
    createdAt: DateTimeUtils.nowUtc(),
    updatedAt: DateTimeUtils.nowUtc(),
  );
}
