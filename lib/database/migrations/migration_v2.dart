import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';

/// Migration from schema v1 to v2.
///
/// Adds the nullable `disbursed_amount` column to the `debts` table to support
/// debt and loan transactions with interest or administrative differences.
class MigrationV2 {
  /// Creates a [MigrationV2] instance.
  const new();

  /// Executes the migration from version 1 to version 2.
  Future<void> up(Migrator m, AppDatabase db) async {
    await m.addColumn(db.debts, db.debts.disbursedAmount);
  }
}
