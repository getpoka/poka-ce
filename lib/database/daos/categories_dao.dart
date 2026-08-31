import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/categories_table.dart';

part 'categories_dao.g.dart';

/// Data Access Object for the Categories and AccountCategories tables.
/// Handles all raw database operations related to categories, including hierarchical queries and soft active status toggling.
@DriftAccessor(tables: [Categories, AccountCategories])
class CategoriesDao extends DatabaseAccessor<AppDatabase> with _$CategoriesDaoMixin {
  CategoriesDao(super.attachedDatabase);

  /// Retrieves all categories ordered by their sort index.
  Future<List<Category>> getAllCategories() =>
      (select(categories)..orderBy([(t) => OrderingTerm(expression: t.sort)])).get();

  /// Retrieves only categories that are marked as active, ordered by their sort index.
  Future<List<Category>> getActiveCategories() =>
      (select(categories)
            ..where((t) => t.isActive.equals(true))
            ..orderBy([(t) => OrderingTerm(expression: t.sort)]))
          .get();

  /// Watches all categories as a reactive stream, ordered by their sort index.
  Stream<List<Category>> watchAllCategories() =>
      (select(categories)..orderBy([(t) => OrderingTerm(expression: t.sort)])).watch();

  /// Retrieves a specific category by its unique ID.
  Future<Category?> getCategory(String id) => (select(categories)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Checks if a category has any sub-categories.
  Future<bool> hasChildren(String id) async {
    final query = select(categories)..where((t) => t.parentId.equals(id));
    final rows = await query.get();
    return rows.isNotEmpty;
  }

  /// Inserts a new category into the database.
  Future<int> insertCategory(CategoriesCompanion category) => into(categories).insert(category);

  /// Updates an existing category in the database.
  Future<bool> updateCategory(CategoriesCompanion category) => update(categories).replace(category);

  /// Toggles the active status of a category. Also cascades this update to its sub-categories.
  Future<void> toggleCategoryActiveStatus(String id, {required bool isActive}) async {
    await transaction(() async {
      // update the target category
      await (update(categories)..where((t) => t.id.equals(id))).write(CategoriesCompanion(isActive: Value(isActive)));

      // update its children
      await (update(
        categories,
      )..where((t) => t.parentId.equals(id))).write(CategoriesCompanion(isActive: Value(isActive)));
    });
  }

  /// Permanently deletes a category by its ID.
  Future<int> deleteCategory(String id) => (delete(categories)..where((t) => t.id.equals(id))).go();

  /// Updates the sort order of a list of categories using a batch operation.
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

  /// Synchronizes account category restrictions so that any account restricting
  /// the parent category will automatically restrict the child category as well.
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
