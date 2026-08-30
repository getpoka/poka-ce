import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/recurring/data/recurring_repository_impl.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late RecurringRepositoryImpl repo;
  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
    repo = RecurringRepositoryImpl(db.recurringDao);
  });
  tearDown(() async => db.close());
  final now = DateTimeUtils.nowUtc();

  Future<void> seedAcc(String id) async =>
      db.into(db.accounts).insert(AccountsCompanion.insert(id: Value(id), name: 'Acc $id', type: AccountType.assets));

  test('getRecurringTransactions empty then populated', () async {
    var res = await repo.getRecurringTransactions();
    res.fold((v) => expect(v, isEmpty), (e) => fail('fail'));
    await seedAcc('acc1');
    await repo.createRecurring(
      RecurringTransactionModel(
        id: 'r1',
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 100,
        period: RecurringPeriod.monthly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
    res = await repo.getRecurringTransactions();
    res.fold((v) => expect(v.length, 1), (e) => fail('fail'));
  });

  test('getActiveRecurringTransactions filters', () async {
    await seedAcc('acc1');
    await repo.createRecurring(
      RecurringTransactionModel(
        id: 'r1',
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 100,
        period: RecurringPeriod.daily,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await repo.createRecurring(
      RecurringTransactionModel(
        id: 'r2',
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 200,
        period: RecurringPeriod.daily,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
        isActive: false,
      ),
    );
    final res = await repo.getActiveRecurringTransactions();
    res.fold((v) => expect(v.length, 1), (e) => fail('fail'));
  });

  test('getRecurringById not found', () async {
    expect(await repo.getRecurringById('none'), isA<ErrorResult<RecurringTransactionModel, Failure>>());
  });

  test('create and getRecurringById', () async {
    await seedAcc('acc1');
    await repo.createRecurring(
      RecurringTransactionModel(
        id: 'r1',
        accountId: 'acc1',
        type: TransactionType.income,
        amount: 50000,
        period: RecurringPeriod.weekly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
    expect(await repo.getRecurringById('r1'), isA<Success<RecurringTransactionModel, Failure>>());
  });

  test('updateRecurring modifies', () async {
    await seedAcc('acc1');
    await repo.createRecurring(
      RecurringTransactionModel(
        id: 'r1',
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 100,
        period: RecurringPeriod.monthly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await repo.updateRecurring(
      RecurringTransactionModel(
        id: 'r1',
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 999,
        period: RecurringPeriod.yearly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
    final res = await repo.getRecurringById('r1');
    res.fold((v) => expect(v.amount, 999), (e) => fail('fail'));
  });

  test('deleteRecurring removes', () async {
    await seedAcc('acc1');
    await repo.createRecurring(
      RecurringTransactionModel(
        id: 'r1',
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 100,
        period: RecurringPeriod.daily,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await repo.deleteRecurring('r1');
    expect(await repo.getRecurringById('r1'), isA<ErrorResult<RecurringTransactionModel, Failure>>());
  });
}
