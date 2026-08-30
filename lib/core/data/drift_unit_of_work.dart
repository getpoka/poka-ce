import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/database/database.dart';

/// Implementation of [IUnitOfWork] using Drift's transaction block.
class DriftUnitOfWork implements IUnitOfWork {
  DriftUnitOfWork(this._db);

  final AppDatabase _db;

  @override
  Future<T> execute<T>(Future<T> Function() action) async {
    return _db.transaction(action);
  }
}
