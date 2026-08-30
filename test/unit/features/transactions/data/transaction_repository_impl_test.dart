import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/transactions/data/transaction_repository_impl.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late TransactionRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
    repository = TransactionRepositoryImpl(db.transactionsDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('createTransaction inserts header and items correctly', () async {
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: const Value('acc1'),
            name: 'Wallet',
            type: AccountType.assets,
            balance: const Value(0),
          ),
        );

    final model = TransactionModel(
      id: 'txn1',
      accountId: 'acc1',
      type: TransactionType.income,
      amount: 50000,
      transactionDate: DateTimeUtils.nowUtc(),
      createdAt: DateTimeUtils.nowUtc(),
      updatedAt: DateTimeUtils.nowUtc(),
      items: [
        TransactionItemModel(
          id: 'item1',
          transactionId: 'txn1',
          amount: 50000,
          createdAt: DateTimeUtils.nowUtc(),
          updatedAt: DateTimeUtils.nowUtc(),
        ),
      ],
    );

    final result = await repository.createTransaction(model);

    expect(result, isA<Success<void, Failure>>());

    // Verify account balance mutated
    final account = await (db.select(db.accounts)..where((a) => a.id.equals('acc1'))).getSingle();
    expect(account.balance, 50000);
  });
}
