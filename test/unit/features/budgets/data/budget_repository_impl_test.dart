import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/budgets/data/budget_repository_impl.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late BudgetRepositoryImpl repo;
  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
    repo = BudgetRepositoryImpl(db.budgetsDao);
  });
  tearDown(() async => db.close());

  final now = DateTimeUtils.nowUtc();

  BudgetModel mk(String id, {String? cat, String? acc}) => BudgetModel(
    id: id,
    name: 'Budget $id',
    amount: 100000,
    period: BudgetPeriod.monthly,
    startDate: now,
    categoryId: cat,
    accountId: acc,
    resetDay: 1,
    createdAt: now,
    updatedAt: now,
  );

  test('getBudgets empty then populated', () async {
    var res = await repo.getBudgets();
    res.fold((v) => expect(v, isEmpty), (e) => fail('fail'));
    await repo.createBudget(mk('b1'));
    res = await repo.getBudgets();
    res.fold((v) => expect(v.length, 1), (e) => fail('fail'));
  });

  test('getBudgetById not found returns ErrorResult', () async {
    final res = await repo.getBudgetById('none');
    expect(res, isA<ErrorResult<BudgetModel, Failure>>());
  });

  test('createBudget and getBudgetById roundtrip', () async {
    await repo.createBudget(mk('b1'));
    final res = await repo.getBudgetById('b1');
    expect(res, isA<Success<BudgetModel, Failure>>());
    res.fold((v) => expect(v.name, 'Budget b1'), (e) => fail('fail'));
  });

  test('updateBudget modifies', () async {
    await repo.createBudget(mk('b1'));
    final updated = BudgetModel(
      id: 'b1',
      name: 'Updated',
      amount: 999,
      period: BudgetPeriod.weekly,
      startDate: now,
      createdAt: now,
      updatedAt: now,
    );
    final res = await repo.updateBudget(updated);
    expect(res, isA<Success<void, Failure>>());
    final fetched = await repo.getBudgetById('b1');
    fetched.fold((v) => expect(v.name, 'Updated'), (e) => fail('fail'));
  });

  test('deleteBudget removes', () async {
    await repo.createBudget(mk('b1'));
    await repo.deleteBudget('b1');
    final res = await repo.getBudgetById('b1');
    expect(res, isA<ErrorResult<BudgetModel, Failure>>());
  });

  test('createBudget with category and account references', () async {
    await db
        .into(db.accounts)
        .insert(AccountsCompanion.insert(id: const Value('acc1'), name: 'W', type: AccountType.assets));
    await db
        .into(db.categories)
        .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense));
    await repo.createBudget(mk('b1', cat: 'cat1', acc: 'acc1'));
    final res = await repo.getBudgetById('b1');
    res.fold((v) {
      expect(v.categoryId, 'cat1');
      expect(v.accountId, 'acc1');
    }, (e) => fail('fail'));
  });
}
