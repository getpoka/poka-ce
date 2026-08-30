import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/recurring_table.dart';

part 'recurring_dao.g.dart';

@DriftAccessor(tables: [RecurringTransactions])
class RecurringDao extends DatabaseAccessor<AppDatabase> with _$RecurringDaoMixin {
  RecurringDao(super.attachedDatabase);

  Future<List<RecurringTransaction>> getAllRecurring() => select(recurringTransactions).get();

  Future<List<RecurringTransaction>> getActiveRecurring() =>
      (select(recurringTransactions)..where((t) => t.isActive.equals(true))).get();

  /// Returns all active recurring transactions whose `nextDate` is on or before [asOf].
  Future<List<RecurringTransaction>> getDueRecurring(DateTime asOf) {
    final asOfUtc = asOf.toUtc();
    return (select(
      recurringTransactions,
    )..where((t) => t.isActive.equals(true) & t.nextDate.isSmallerOrEqualValue(asOfUtc))).get();
  }

  Future<RecurringTransaction?> getRecurring(String id) =>
      (select(recurringTransactions)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertRecurring(RecurringTransactionsCompanion recurring) =>
      into(recurringTransactions).insert(recurring);

  Future<bool> updateRecurring(RecurringTransactionsCompanion recurring) =>
      update(recurringTransactions).replace(recurring);

  Future<int> deleteRecurring(String id) => (delete(recurringTransactions)..where((t) => t.id.equals(id))).go();
}
