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

  group('RecurringDao', () {
    Future<void> seedAccount(String id) async {
      await db
          .into(db.accounts)
          .insert(AccountsCompanion.insert(id: Value(id), name: 'Wallet $id', type: AccountType.assets));
    }

    test('getAllRecurring empty initially', () async {
      expect(await db.recurringDao.getAllRecurring(), isEmpty);
    });

    test('insert and getRecurring', () async {
      await seedAccount('acc1');
      final next = DateTime.now().toUtc();
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('r1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 50000,
          period: RecurringPeriod.monthly,
          nextDate: next,
        ),
      );
      final r = await db.recurringDao.getRecurring('r1');
      expect(r, isNotNull);
      expect(r!.amount, 50000);
      expect(r.isActive, true);
    });

    test('getRecurring returns null for unknown', () async {
      expect(await db.recurringDao.getRecurring('none'), isNull);
    });

    test('getActiveRecurring filters inactive', () async {
      await seedAccount('acc1');
      final next = DateTime.now().toUtc();
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('r1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 100,
          period: RecurringPeriod.weekly,
          nextDate: next,
        ),
      );
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('r2'),
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 200,
          period: RecurringPeriod.monthly,
          nextDate: next,
          isActive: const Value(false),
        ),
      );
      final active = await db.recurringDao.getActiveRecurring();
      expect(active.length, 1);
      expect(active.first.id, 'r1');
    });

    test('updateRecurring modifies', () async {
      await seedAccount('acc1');
      final next = DateTime.now().toUtc();
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('r1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 100,
          period: RecurringPeriod.daily,
          nextDate: next,
        ),
      );
      await (db.update(
        db.recurringTransactions,
      )..where((t) => t.id.equals('r1'))).write(const RecurringTransactionsCompanion(amount: Value(999)));
      final r = await db.recurringDao.getRecurring('r1');
      expect(r!.amount, 999);
    });

    test('getDueRecurring returns only active rows due on or before asOf', () async {
      await seedAccount('acc1');
      final now = DateTime.now().toUtc();
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('due1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 100,
          period: RecurringPeriod.monthly,
          nextDate: now.subtract(const Duration(days: 2)),
        ),
      );
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('dueToday'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 200,
          period: RecurringPeriod.monthly,
          nextDate: now,
        ),
      );
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('future'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 300,
          period: RecurringPeriod.monthly,
          nextDate: now.add(const Duration(days: 2)),
        ),
      );
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('inactiveDue'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 400,
          period: RecurringPeriod.monthly,
          nextDate: now.subtract(const Duration(days: 1)),
          isActive: const Value(false),
        ),
      );

      final due = await db.recurringDao.getDueRecurring(now);
      expect(due.map((r) => r.id).toSet(), {'due1', 'dueToday'});
    });

    test('deleteRecurring removes', () async {
      await seedAccount('acc1');
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('r1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 100,
          period: RecurringPeriod.yearly,
          nextDate: DateTime.now().toUtc(),
        ),
      );
      await db.recurringDao.deleteRecurring('r1');
      expect(await db.recurringDao.getRecurring('r1'), isNull);
    });

    test('with destinationAccount and category', () async {
      await seedAccount('acc1');
      await seedAccount('acc2');
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Salary', type: CategoryType.income));
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('r1'),
          accountId: 'acc1',
          destinationAccountId: const Value('acc2'),
          categoryId: const Value('cat1'),
          type: TransactionType.transfer,
          amount: 75000,
          period: RecurringPeriod.monthly,
          nextDate: DateTime.now().toUtc(),
        ),
      );
      final r = await db.recurringDao.getRecurring('r1');
      expect(r!.destinationAccountId, 'acc2');
      expect(r.categoryId, 'cat1');
      expect(r.type, TransactionType.transfer);
    });

    test('getAllRecurring returns multiple', () async {
      await seedAccount('acc1');
      final now = DateTime.now().toUtc();
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('r1'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 100,
          period: RecurringPeriod.daily,
          nextDate: now,
        ),
      );
      await db.recurringDao.insertRecurring(
        RecurringTransactionsCompanion.insert(
          id: const Value('r2'),
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 200,
          period: RecurringPeriod.weekly,
          nextDate: now,
        ),
      );
      expect((await db.recurringDao.getAllRecurring()).length, 2);
    });
  });
}
