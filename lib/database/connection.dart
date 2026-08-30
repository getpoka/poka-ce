import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openConnection(String dbName) {
  return driftDatabase(
    name: dbName,
    native: const DriftNativeOptions(),
  );
}
