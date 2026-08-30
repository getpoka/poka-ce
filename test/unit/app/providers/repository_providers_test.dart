import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('repository_providers smoke', () {
    test('providers can be overridden and read', () async {
      final db = AppDatabase(connection: NativeDatabase.memory());
      addTearDown(db.close);
      final container = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      // Just ensure providers exist and are readable via override
      expect(container.read(databaseProvider), same(db));
      expect(container.read(unitOfWorkProvider), isNotNull);
      expect(container.read(accountRepositoryProvider), isNotNull);
      expect(container.read(transactionRepositoryProvider), isNotNull);
      expect(container.read(categoryRepositoryProvider), isNotNull);
      expect(container.read(budgetRepositoryProvider), isNotNull);
      expect(container.read(goalRepositoryProvider), isNotNull);
      expect(container.read(debtRepositoryProvider), isNotNull);
      expect(container.read(recurringRepositoryProvider), isNotNull);
    });

    test('databaseProvider returns same instance within container', () {
      final db = AppDatabase(connection: NativeDatabase.memory());
      addTearDown(db.close);
      final container = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      final db1 = container.read(databaseProvider);
      final db2 = container.read(databaseProvider);
      expect(identical(db1, db2), true);
    });
  });
}
