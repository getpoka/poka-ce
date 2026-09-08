import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Opens a SQLite database connection with Drift native background execution options.
QueryExecutor openConnection(String dbName) {
  return driftDatabase(
    name: dbName,
    native: const DriftNativeOptions(),
  );
}
