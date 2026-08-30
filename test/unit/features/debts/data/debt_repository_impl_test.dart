import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/debts/data/debt_repository_impl.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late DebtRepositoryImpl repo;

  setUp(() async {
    db = AppDatabase(connection: NativeDatabase.memory());
    repo = DebtRepositoryImpl(db.debtsDao);

    // Seed account and category for the transactions
    await db
        .into(db.accounts)
        .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'Acc1', type: AccountType.assets));
    await db
        .into(db.categories)
        .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Cat1', type: CategoryType.expense));
  });

  tearDown(() async => db.close());
  final now = DateTimeUtils.nowUtc();
  DebtModel mk(String id, DebtStatus status) => DebtModel(
    id: id,
    personName: 'Person $id',
    type: DebtType.debt,
    amount: 100000,
    remainingAmount: 50000,
    status: status,
    createdAt: now,
    updatedAt: now,
  );

  test('getDebts empty then populated', () async {
    var res = await repo.getDebts();
    res.fold((v) => expect(v, isEmpty), (e) => fail('fail'));
    await repo.createDebt(mk('d1', DebtStatus.active), 'acc1', 'cat1');
    res = await repo.getDebts();
    res.fold((v) => expect(v.length, 1), (e) => fail('fail'));
  });

  test('getActiveDebts filters paid', () async {
    await repo.createDebt(mk('d1', DebtStatus.active), 'acc1', 'cat1');
    await repo.createDebt(mk('d2', DebtStatus.paid), 'acc1', 'cat1');
    final res = await repo.getActiveDebts();
    res.fold((v) => expect(v.length, 1), (e) => fail('fail'));
  });

  test('getDebtById not found', () async {
    expect(await repo.getDebtById('none'), isA<ErrorResult<DebtModel, Failure>>());
  });

  test('create and getDebtById', () async {
    await repo.createDebt(mk('d1', DebtStatus.active), 'acc1', 'cat1');
    final res = await repo.getDebtById('d1');
    expect(res, isA<Success<DebtModel, Failure>>());
  });

  test('updateDebt modifies remainingAmount and status', () async {
    await repo.createDebt(mk('d1', DebtStatus.active), 'acc1', 'cat1');
    final updated = DebtModel(
      id: 'd1',
      personName: 'Updated',
      type: DebtType.loan,
      amount: 100000,
      remainingAmount: 0,
      status: DebtStatus.paid,
      createdAt: now,
      updatedAt: now,
    );
    await repo.updateDebt(updated);
    final res = await repo.getDebtById('d1');
    res.fold((v) {
      expect(v.remainingAmount, 0);
      expect(v.status, DebtStatus.paid);
    }, (e) => fail('fail'));
  });

  test('deleteDebt removes', () async {
    await repo.createDebt(mk('d1', DebtStatus.active), 'acc1', 'cat1');
    await repo.deleteDebt('d1');
    expect(await repo.getDebtById('d1'), isA<ErrorResult<DebtModel, Failure>>());
  });

  test('loan type and dueDate persisted', () async {
    final due = DateTime.utc(2026, 12, 31);
    final m = DebtModel(
      id: 'd1',
      personName: 'Lender',
      type: DebtType.loan,
      amount: 500000,
      remainingAmount: 500000,
      status: DebtStatus.active,
      dueDate: due,
      note: 'note',
      createdAt: now,
      updatedAt: now,
    );
    await repo.createDebt(m, 'acc1', 'cat1');
    final res = await repo.getDebtById('d1');
    res.fold((v) {
      expect(v.type, DebtType.loan);
      expect(v.dueDate!.toUtc(), due.toUtc());
      expect(v.note, 'note');
    }, (e) => fail('fail'));
  });

  test('createDebt creates income transaction for DebtType.debt', () async {
    final m = mk('d1', DebtStatus.active); // type is debt
    await repo.createDebt(m, 'acc1', 'cat1');
    final tx = await (db.select(db.transactions)..where((t) => t.debtId.equals('d1'))).getSingle();
    expect(tx.type, TransactionType.income);
  });

  test('createDebt creates expense transaction for DebtType.loan', () async {
    final m = mk('d1', DebtStatus.active).copyWith(type: DebtType.loan);
    await repo.createDebt(m, 'acc1', 'cat1');
    final tx = await (db.select(db.transactions)..where((t) => t.debtId.equals('d1'))).getSingle();
    expect(tx.type, TransactionType.expense);
  });
}
