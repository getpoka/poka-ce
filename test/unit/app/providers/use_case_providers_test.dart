import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('use_case_providers smoke', () {
    test('use case providers are readable', () {
      final db = AppDatabase(connection: NativeDatabase.memory());
      addTearDown(db.close);
      final container = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      expect(container.read(createAccountUseCaseProvider), isNotNull);
      expect(container.read(updateAccountUseCaseProvider), isNotNull);
      expect(container.read(createTransactionUseCaseProvider), isNotNull);
      expect(container.read(transferFundsUseCaseProvider), isNotNull);
    });

    test('providers return consistent types', () {
      final db = AppDatabase(connection: NativeDatabase.memory());
      addTearDown(db.close);
      final container = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);
      final a = container.read(createAccountUseCaseProvider);
      final b = container.read(createAccountUseCaseProvider);
      expect(a, isNotNull);
      expect(b, isNotNull);
    });
  });
}
