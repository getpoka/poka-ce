import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/categories/data/category_repository_impl.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late CategoryRepositoryImpl repo;
  setUp(() async {
    db = AppDatabase(connection: NativeDatabase.memory());
    await db.delete(db.categories).go();
    repo = CategoryRepositoryImpl(db.categoriesDao);
  });
  tearDown(() async => db.close());
  final now = DateTimeUtils.nowUtc();
  CategoryModel mk(String id, {String? parent}) => CategoryModel(
    id: id,
    name: 'Cat $id',
    type: CategoryType.expense,
    parentId: parent,
    createdAt: now,
    updatedAt: now,
  );

  test('getCategories empty then with data', () async {
    var res = await repo.getCategories();
    res.fold((v) => expect(v, isEmpty), (e) => fail('fail'));
    await repo.createCategory(mk('c1'));
    res = await repo.getCategories();
    res.fold((v) => expect(v.length, 1), (e) => fail('fail'));
  });

  test('getActiveCategories filters inactive', () async {
    await repo.createCategory(mk('c1'));
    await repo.createCategory(
      CategoryModel(
        id: 'c2',
        name: 'Inactive',
        type: CategoryType.expense,
        isActive: false,
        createdAt: now,
        updatedAt: now,
      ),
    );
    // Deactivate via DAO to ensure filter works
    await db.categoriesDao.deactivateCategory('c1');
    final res = await repo.getActiveCategories();
    // c1 now inactive, c2 already inactive => 0 active
    res.fold((v) => expect(v, isEmpty), (e) => fail('fail'));
  });

  test('getCategoryById not found', () async {
    final res = await repo.getCategoryById('none');
    expect(res, isA<ErrorResult<CategoryModel, Failure>>());
  });

  test('create and getCategoryById', () async {
    await repo.createCategory(mk('c1'));
    final res = await repo.getCategoryById('c1');
    expect(res, isA<Success<CategoryModel, Failure>>());
  });

  test('updateCategory modifies', () async {
    await repo.createCategory(mk('c1'));
    final updated = CategoryModel(
      id: 'c1',
      name: 'Updated',
      type: CategoryType.income,
      icon: 'star',
      createdAt: now,
      updatedAt: now,
    );
    final res = await repo.updateCategory(updated);
    expect(res, isA<Success<void, Failure>>());
    final fetched = await repo.getCategoryById('c1');
    fetched.fold((v) => expect(v.name, 'Updated'), (e) => fail('fail'));
  });

  test('deactivateCategory', () async {
    await repo.createCategory(mk('c1'));
    await repo.deactivateCategory('c1');
    final fetched = await repo.getCategoryById('c1');
    fetched.fold((v) => expect(v.isActive, false), (e) => fail('fail'));
  });

  test('hierarchy parent-child persisted', () async {
    await repo.createCategory(mk('parent'));
    await repo.createCategory(mk('child', parent: 'parent'));
    final child = await repo.getCategoryById('child');
    child.fold((v) => expect(v.parentId, 'parent'), (e) => fail('fail'));
  });
}
