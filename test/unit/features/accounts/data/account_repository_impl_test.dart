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
}
