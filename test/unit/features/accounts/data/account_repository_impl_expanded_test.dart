import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/accounts/data/account_repository_impl.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late AccountRepositoryImpl repo;
  setUp(() async {
    db = AppDatabase(connection: NativeDatabase.memory());
    repo = AccountRepositoryImpl(db.accountsDao);
    await db.delete(db.accounts).go();
  });
  tearDown(() async => db.close());

  final now = DateTimeUtils.nowUtc();

  test('getAccounts returns empty and then models', () async {
    var res = await repo.getAccounts();
    expect(res, isA<Success<List<AccountModel>, Failure>>());
    res.fold((v) => expect(v, isEmpty), (e) => fail('fail'));
    await repo.createAccount(
      AccountModel(id: 'a1', name: 'Wallet', type: AccountType.assets, balance: 0, createdAt: now, updatedAt: now),
    );
    res = await repo.getAccounts();
    res.fold((v) => expect(v.length, 1), (e) => fail('fail'));
  });

  test('getAccountById not found returns ErrorResult', () async {
    final res = await repo.getAccountById('none');
    expect(res, isA<ErrorResult<AccountModel, Failure>>());
    res.fold((v) => fail('should error'), (e) => expect(e.message, contains('not found')));
  });

  test('createAccount with restricted categories persists via DAO', () async {
    await db
        .into(db.categories)
        .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense));
    await db
        .into(db.categories)
        .insert(CategoriesCompanion.insert(id: const Value('cat2'), name: 'Salary', type: CategoryType.income));
    final model = AccountModel(
      id: 'a1',
      name: 'Wallet',
      type: AccountType.assets,
      balance: 1000,
      createdAt: now,
      updatedAt: now,
      restrictedCategoryIds: ['cat1', 'cat2'],
    );
    final res = await repo.createAccount(model);
    expect(res, isA<Success<void, Failure>>());
    final links = await db.select(db.accountCategories).get();
    expect(links.length, 2);
  });

  test('updateAccount modifies and updates restricted categories', () async {
    final m = AccountModel(id: 'a1', name: 'Old', type: AccountType.assets, balance: 0, createdAt: now, updatedAt: now);
    await repo.createAccount(m);
    await db
        .into(db.categories)
        .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense));
    final updated = AccountModel(
      id: 'a1',
      name: 'New',
      type: AccountType.assets,
      balance: 999,
      createdAt: now,
      updatedAt: now,
      restrictedCategoryIds: ['cat1'],
    );
    final res = await repo.updateAccount(updated);
    expect(res, isA<Success<void, Failure>>());
    final acc = await db.accountsDao.getAccount('a1');
    expect(acc!.name, 'New');
    expect(acc.balance, 999);
  });

  test('deactivateAccount sets isActive false via repo', () async {
    await repo.createAccount(
      AccountModel(id: 'a1', name: 'W', type: AccountType.assets, balance: 0, createdAt: now, updatedAt: now),
    );
    final res = await repo.deactivateAccount('a1');
    expect(res, isA<Success<void, Failure>>());
    final acc = await db.accountsDao.getAccount('a1');
    expect(acc!.isActive, false);
  });

  test('createAccount handles balance and parentId', () async {
    await repo.createAccount(
      AccountModel(id: 'parent', name: 'Parent', type: AccountType.assets, balance: 0, createdAt: now, updatedAt: now),
    );
    await repo.createAccount(
      AccountModel(
        id: 'child',
        name: 'Child',
        type: AccountType.assets,
        balance: 500,
        createdAt: now,
        updatedAt: now,
        parentId: 'parent',
      ),
    );
    final child = await repo.getAccountById('child');
    child.fold((v) => expect(v.parentId, 'parent'), (e) => fail('fail'));
  });
}
