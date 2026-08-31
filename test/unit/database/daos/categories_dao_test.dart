import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  setUp(() async {
    db = AppDatabase(connection: NativeDatabase.memory());
    await db.delete(db.categories).go();
  });
  tearDown(() async => db.close());

  group('CategoriesDao', () {
    test('getAllCategories empty initially', () async {
      expect(await db.categoriesDao.getAllCategories(), isEmpty);
    });

    test('insert and retrieve category', () async {
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(
          id: const Value('c1'),
          name: 'Food',
          type: CategoryType.expense,
          icon: const Value('restaurant'),
          color: const Value('#FF9800'),
        ),
      );
      final cat = await db.categoriesDao.getCategory('c1');
      expect(cat, isNotNull);
      expect(cat!.name, 'Food');
      expect(cat.type, CategoryType.expense);
      expect(cat.isActive, true);
    });

    test('getActiveCategories filters inactive', () async {
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(id: const Value('c1'), name: 'A', type: CategoryType.expense),
      );
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(id: const Value('c2'), name: 'B', type: CategoryType.income),
      );
      await db.categoriesDao.toggleCategoryActiveStatus('c2', isActive: false);
      final active = await db.categoriesDao.getActiveCategories();
      expect(active.length, 1);
      expect(active.first.id, 'c1');
    });

    test('getCategory returns null for unknown', () async {
      expect(await db.categoriesDao.getCategory('none'), isNull);
    });

    test('updateCategory modifies fields', () async {
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(id: const Value('c1'), name: 'Old', type: CategoryType.expense),
      );
      await db.categoriesDao.updateCategory(
        const CategoriesCompanion(id: Value('c1'), name: Value('New'), color: Value('#000000')),
      );
      final cat = await db.categoriesDao.getCategory('c1');
      expect(cat!.name, 'New');
      expect(cat.color, '#000000');
    });

    test('deactivateCategory sets isActive false', () async {
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(id: const Value('c1'), name: 'Food', type: CategoryType.expense),
      );
      await db.categoriesDao.toggleCategoryActiveStatus('c1', isActive: false);
      final cat = await db.categoriesDao.getCategory('c1');
      expect(cat!.isActive, false);
    });

    test('getAllCategories returns all including inactive', () async {
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(id: const Value('c1'), name: 'A', type: CategoryType.expense),
      );
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(id: const Value('c2'), name: 'B', type: CategoryType.expense),
      );
      await db.categoriesDao.toggleCategoryActiveStatus('c2', isActive: false);
      final all = await db.categoriesDao.getAllCategories();
      expect(all.length, 2);
    });

    test('sub-category inherits parentId and cascade delete', () async {
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(id: const Value('parent'), name: 'Food', type: CategoryType.expense),
      );
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(
          id: const Value('child'),
          name: 'Snacks',
          type: CategoryType.expense,
          parentId: const Value('parent'),
        ),
      );
      var all = await db.categoriesDao.getAllCategories();
      expect(all.length, 2);
      await (db.delete(db.categories)..where((c) => c.id.equals('parent'))).go();
      all = await db.categoriesDao.getAllCategories();
      expect(all, isEmpty);
    });

    test('lowercase enum storage validation', () async {
      await db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(id: const Value('c1'), name: 'Salary', type: CategoryType.income),
      );
      final raw = await db
          .customSelect('SELECT type FROM categories WHERE id = ?', variables: [Variable.withString('c1')])
          .getSingle();
      expect(raw.data['type'], 'income');
    });
  });
}
