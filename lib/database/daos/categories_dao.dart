import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories, AccountCategories])
class CategoriesDao extends DatabaseAccessor<AppDatabase> with _$CategoriesDaoMixin {
  CategoriesDao(super.attachedDatabase);

  Future<List<Category>> getAllCategories() =>
      (select(categories)..orderBy([(t) => OrderingTerm(expression: t.sort)])).get();

  Future<List<Category>> getActiveCategories() =>
      (select(categories)
            ..where((t) => t.isActive.equals(true))
            ..orderBy([(t) => OrderingTerm(expression: t.sort)]))
          .get();

  Stream<List<Category>> watchAllCategories() =>
      (select(categories)..orderBy([(t) => OrderingTerm(expression: t.sort)])).watch();

  Future<Category?> getCategory(String id) => (select(categories)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertCategory(CategoriesCompanion category) => into(categories).insert(category);

  Future<bool> updateCategory(CategoriesCompanion category) => update(categories).replace(category);

  Future<int> deactivateCategory(String id) =>
      (update(categories)..where((t) => t.id.equals(id))).write(const CategoriesCompanion(isActive: Value(false)));

  Future<int> deleteCategory(String id) => (delete(categories)..where((t) => t.id.equals(id))).go();

  Future<void> updateCategoriesSort(Map<String, int> orders) async {
    await batch((batch) {
      for (final entry in orders.entries) {
        batch.update(
          categories,
          CategoriesCompanion(sort: Value(entry.value)),
          where: (t) => t.id.equals(entry.key),
        );
      }
    });
  }

  Future<void> syncSubCategoryToAccounts(String parentId, String childId) async {
    return transaction(() async {
      // Find all accounts that restrict this parent category
      final query = select(accountCategories)..where((t) => t.categoryId.equals(parentId));
      final rows = await query.get();

      for (final row in rows) {
        // Insert the child category for the same account
        await into(accountCategories).insert(
          AccountCategoriesCompanion.insert(
            accountId: row.accountId,
            categoryId: childId,
          ),
          mode: InsertMode.insertOrIgnore, // in case it already exists
        );
      }
    });
  }
}
