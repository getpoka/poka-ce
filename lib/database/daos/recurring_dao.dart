import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/recurring_table.dart';

part 'recurring_dao.g.dart';

/// Data Access Object for recurring transactions and automated bill schedules.
@DriftAccessor(tables: [RecurringTransactions])
class RecurringDao extends DatabaseAccessor<AppDatabase> with _$RecurringDaoMixin {
  /// Creates a [RecurringDao] attached to [attachedDatabase].
  RecurringDao(super.attachedDatabase);

  /// Retrieves all recurring transaction blueprints.
  Future<List<RecurringTransaction>> getAllRecurring() => select(recurringTransactions).get();

  /// Retrieves only recurring transactions marked as active.
  Future<List<RecurringTransaction>> getActiveRecurring() =>
      (select(recurringTransactions)..where((t) => t.isActive.equals(true))).get();

  /// Returns all active recurring transactions whose `nextDate` is on or before [asOf].
  Future<List<RecurringTransaction>> getDueRecurring(DateTime asOf) {
    final asOfUtc = asOf.toUtc();
    return (select(
      recurringTransactions,
    )..where((t) => t.isActive.equals(true) & t.nextDate.isSmallerOrEqualValue(asOfUtc))).get();
  }

  /// Retrieves a specific recurring transaction blueprint by its unique [id].
  Future<RecurringTransaction?> getRecurring(String id) =>
      (select(recurringTransactions)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserts a new recurring transaction blueprint.
  Future<int> insertRecurring(RecurringTransactionsCompanion recurring) =>
      into(recurringTransactions).insert(recurring);

  /// Updates an existing recurring transaction blueprint.
  Future<bool> updateRecurring(RecurringTransactionsCompanion recurring) =>
      update(recurringTransactions).replace(recurring);

  /// Deletes a recurring transaction blueprint by [id].
  Future<int> deleteRecurring(String id) => (delete(recurringTransactions)..where((t) => t.id.equals(id))).go();
}
