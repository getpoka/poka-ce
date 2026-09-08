import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/database/database.dart';

import '../../database/schema_v1/schema.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  test(
    'verify schema v1 matches current database definition',
    () async {
      final connection = await verifier.startAt(1);
      final db = AppDatabase(connection: connection);
      await verifier.migrateAndValidate(db, 1);
      await db.close();
    },
    timeout: const Timeout(Duration(seconds: 5)),
  );

  test(
    'fresh database validates against generated schema expectations',
    () async {
      final db = AppDatabase(connection: NativeDatabase.memory());
      await db.customSelect('SELECT 1').get();
      await db.validateDatabaseSchema();
      await db.close();
    },
    timeout: const Timeout(Duration(seconds: 5)),
  );
}
