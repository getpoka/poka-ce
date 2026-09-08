import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/database/database.dart';

/// Implementation of [IUnitOfWork] using Drift's transaction block.
class DriftUnitOfWork implements IUnitOfWork {
  /// Creates a [DriftUnitOfWork] wrapping [AppDatabase].
  DriftUnitOfWork(this._db);

  final AppDatabase _db;

  /// Runs [action] inside a Drift SQLite transaction.
  @override
  Future<T> execute<T>(Future<T> Function() action) async {
    return _db.transaction(action);
  }
}
