import 'package:drift/drift.dart';
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
  late AccountRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
    repository = AccountRepositoryImpl(db.accountsDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('createAccount inserts data correctly via DAO', () async {
    final accountModel = AccountModel(
      id: 'acc1',
      name: 'Test Wallet',
      type: AccountType.assets,
      balance: 50000,
      createdAt: DateTimeUtils.nowUtc(),
      updatedAt: DateTimeUtils.nowUtc(),
    );

    final result = await repository.createAccount(accountModel);

    expect(result, isA<Success<void, Failure>>());

    // Verify via DB
    final saved = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
    expect(saved.name, 'Test Wallet');
    expect(saved.balance, 50000);
  });

  test('getAccountById returns expected model', () async {
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value('acc2'),
            name: 'Bank',
            type: AccountType.assets,
            balance: const Value(100000),
          ),
        );

    final result = await repository.getAccountById('acc2');

    expect(result, isA<Success<AccountModel, Failure>>());
    result.fold(
      (value) {
        expect(value.id, 'acc2');
        expect(value.name, 'Bank');
        expect(value.balance, 100000);
      },
      (error) => fail('Should not be error'),
    );
  });

  test('createAccount persists initialBalance and category restrictions', () async {
    // Insert dummy category
    await db
        .into(db.categories)
        .insert(
          CategoriesCompanion.insert(
            id: const Value('cat1'),
            name: 'Food',
            icon: const Value('fork'),
            color: const Value('0xFF123456'),
            type: CategoryType.expense,
          ),
        );

    final model = AccountModel(
      id: 'acc3',
      name: 'Wallet with Limits',
      type: AccountType.assets,
      balance: 150000,
      initialBalance: 150000,
      restrictedCategoryIds: ['cat1'],
      createdAt: DateTimeUtils.nowUtc(),
      updatedAt: DateTimeUtils.nowUtc(),
    );

    final result = await repository.createAccount(model);
    expect(result, isA<Success<void, Failure>>());

    final saved = await (db.select(db.accounts)..where((a) => a.id.equals('acc3'))).getSingle();
    expect(saved.initialBalance, 150000);

    final fetchedResult = await repository.getAccountById('acc3');
    expect(fetchedResult, isA<Success<AccountModel, Failure>>());
    fetchedResult.fold(
      (value) {
        expect(value.initialBalance, 150000);
        expect(value.restrictedCategoryIds, ['cat1']);
      },
      (error) => fail('Failed to fetch account'),
    );
  });

  test('updateAccount updates initialBalance and clears category restrictions', () async {
    // Insert dummy categories
    await db
        .into(db.categories)
        .insert(
          CategoriesCompanion.insert(
            id: const Value('cat1'),
            name: 'Food',
            icon: const Value('fork'),
            color: const Value('0xFF123456'),
            type: CategoryType.expense,
          ),
        );

    final model = AccountModel(
      id: 'acc4',
      name: 'Initial Wallet',
      type: AccountType.assets,
      balance: 100000,
      initialBalance: 100000,
      restrictedCategoryIds: ['cat1'],
      createdAt: DateTimeUtils.nowUtc(),
      updatedAt: DateTimeUtils.nowUtc(),
    );
    await repository.createAccount(model);

    // Update with empty restricted categories and new initial balance
    final updatedModel = model.copyWith(
      name: 'Updated Wallet',
      initialBalance: 200000,
      restrictedCategoryIds: [],
    );
    final updateResult = await repository.updateAccount(updatedModel);
    expect(updateResult, isA<Success<void, Failure>>());

    final fetchedResult = await repository.getAccountById('acc4');
    expect(fetchedResult, isA<Success<AccountModel, Failure>>());
    fetchedResult.fold(
      (value) {
        expect(value.name, 'Updated Wallet');
        expect(value.initialBalance, 200000);
        expect(value.restrictedCategoryIds, isEmpty);
      },
      (error) => fail('Failed to fetch account'),
    );
  });

  test('deactivateAccount sets isActive to false', () async {
    final model = AccountModel(
      id: 'acc5',
      name: 'Deactivatable',
      type: AccountType.assets,
      balance: 50000,
      createdAt: DateTimeUtils.nowUtc(),
      updatedAt: DateTimeUtils.nowUtc(),
    );
    await repository.createAccount(model);

    final result = await repository.deactivateAccount('acc5');
    expect(result, isA<Success<void, Failure>>());

    final saved = await (db.select(db.accounts)..where((a) => a.id.equals('acc5'))).getSingle();
    expect(saved.isActive, isFalse);
  });
}
