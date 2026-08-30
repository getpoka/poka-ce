import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/data/drift_unit_of_work.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late DriftUnitOfWork uow;

  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
    uow = DriftUnitOfWork(db);
  });

  tearDown(() async => db.close());

  group('DriftUnitOfWork', () {
    test('execute runs action and returns value', () async {
      final result = await uow.execute(() async => 42);
      expect(result, 42);
    });

    test('execute commits on success', () async {
      await uow.execute(() async {
        await db
            .into(db.accounts)
            .insert(AccountsCompanion.insert(id: const Value('a1'), name: 'Test', type: AccountType.assets));
        return true;
      });
      final acc = await db.accountsDao.getAccount('a1');
      expect(acc, isNotNull);
    });

    test('execute rolls back on exception', () async {
      try {
        await uow.execute(() async {
          await db
              .into(db.accounts)
              .insert(AccountsCompanion.insert(id: const Value('a2'), name: 'Test', type: AccountType.assets));
          throw Exception('fail');
        });
        fail('should throw');
      } catch (_) {}
      final acc = await db.accountsDao.getAccount('a2');
      expect(acc, isNull);
    });

    test('execute propagates generic types', () async {
      final str = await uow.execute(() async => 'hello');
      expect(str, 'hello');
    });

    test('execute with async computation', () async {
      final res = await uow.execute(() async {
        await Future.delayed(const Duration(milliseconds: 10));
        return 'delayed';
      });
      expect(res, 'delayed');
    });
  });
}
