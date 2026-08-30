import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  group('GoalsDao', () {
    test('getAllGoals empty initially', () async {
      expect(await db.goalsDao.getAllGoals(), isEmpty);
    });

    test('insert and getGoal', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Goal Pocket', type: AccountType.goal));
      await db.goalsDao.insertGoal(
        GoalsCompanion.insert(
          id: const Value('g1'),
          accountId: 'acc1',
          name: 'Trip',
          targetAmount: 1000000,
        ),
      );
      final g = await db.goalsDao.getGoal('g1');
      expect(g, isNotNull);
      expect(g!.name, 'Trip');
      expect(g.targetAmount, 1000000);
    });

    test('getGoal returns null for unknown', () async {
      expect(await db.goalsDao.getGoal('none'), isNull);
    });

    test('updateGoal modifies fields', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Pocket', type: AccountType.goal));
      await db.goalsDao.insertGoal(
        GoalsCompanion.insert(id: const Value('g1'), accountId: 'acc1', name: 'Old', targetAmount: 500),
      );
      await (db.update(
        db.goals,
      )..where((t) => t.id.equals('g1'))).write(const GoalsCompanion(name: Value('New'), targetAmount: Value(999)));
      final g = await db.goalsDao.getGoal('g1');
      expect(g!.name, 'New');
      expect(g.targetAmount, 999);
    });

    test('deleteGoal removes', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Pocket', type: AccountType.goal));
      await db.goalsDao.insertGoal(
        GoalsCompanion.insert(id: const Value('g1'), accountId: 'acc1', name: 'ToDel', targetAmount: 100),
      );
      await db.goalsDao.deleteGoal('g1');
      expect(await db.goalsDao.getGoal('g1'), isNull);
    });

    test('getAllGoals returns multiple', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('a1'), name: 'P1', type: AccountType.goal));
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('a2'), name: 'P2', type: AccountType.goal));
      await db.goalsDao.insertGoal(
        GoalsCompanion.insert(id: const Value('g1'), accountId: 'a1', name: 'G1', targetAmount: 100),
      );
      await db.goalsDao.insertGoal(
        GoalsCompanion.insert(id: const Value('g2'), accountId: 'a2', name: 'G2', targetAmount: 200),
      );
      expect((await db.goalsDao.getAllGoals()).length, 2);
    });

    test('cascade delete when account deleted', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Pocket', type: AccountType.goal));
      await db.goalsDao.insertGoal(
        GoalsCompanion.insert(id: const Value('g1'), accountId: 'acc1', name: 'Trip', targetAmount: 1000),
      );
      expect((await db.goalsDao.getAllGoals()).length, 1);
      await (db.delete(db.accounts)..where((a) => a.id.equals('acc1'))).go();
      expect((await db.goalsDao.getAllGoals()).length, 0);
    });

    test('unique constraint on accountId prevents duplicate goal pocket', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Pocket', type: AccountType.goal));
      await db.goalsDao.insertGoal(
        GoalsCompanion.insert(id: const Value('g1'), accountId: 'acc1', name: 'G1', targetAmount: 100),
      );
      expect(
        () => db.goalsDao.insertGoal(
          GoalsCompanion.insert(id: const Value('g2'), accountId: 'acc1', name: 'G2', targetAmount: 200),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('goal with targetDate and icon color', () async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Pocket', type: AccountType.goal));
      final target = DateTime.utc(2027);
      await db.goalsDao.insertGoal(
        GoalsCompanion.insert(
          id: const Value('g1'),
          accountId: 'acc1',
          name: 'House',
          targetAmount: 50000000,
          targetDate: Value(target),
          icon: const Value('home'),
          color: const Value('#123456'),
        ),
      );
      final g = await db.goalsDao.getGoal('g1');
      expect(g!.targetDate!.toUtc(), target.toUtc());
      expect(g.icon, 'home');
      expect(g.color, '#123456');
    });
  });
}
