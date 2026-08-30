import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() => db = AppDatabase(connection: NativeDatabase.memory()));
  tearDown(() async => db.close());

  Future<void> seedAccount(String id) => db
      .into(db.accounts)
      .insert(AccountsCompanion.insert(id: Value(id), name: 'Wallet $id', type: AccountType.assets));

  group('Transactions table', () {
    test('insert expense with nullable relations and copyWith', () async {
      await seedAccount('acc');
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('t1'),
              accountId: 'acc',
              destinationAccountId: const Value(null),
              type: TransactionType.expense,
              amount: 50000,
              transactionDate: DateTime(2026, 8, 1),
              note: const Value('lunch'),
            ),
          );
      final row = await db.select(db.transactions).getSingle();

      expect(row.destinationAccountId, isNull);
      expect(row.recurringTransactionId, isNull);
      expect(row.debtId, isNull);
      expect(row.type, TransactionType.expense);

      final changed = row.copyWith(note: const Value('dinner'));
      expect(changed.note, 'dinner');
      expect(changed == row, isFalse);
      expect(row.copyWith(), row);
      expect(row.hashCode, isNotNull);
      expect(row.toString(), contains('Transaction'));
    });

    test('json round trip preserves transfer relations', () async {
      await seedAccount('src');
      await seedAccount('dst');
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('t2'),
              accountId: 'src',
              destinationAccountId: const Value('dst'),
              type: TransactionType.transfer,
              amount: 750000,
              transactionDate: DateTime(2026, 8, 2),
            ),
          );
      final row = await db.select(db.transactions).getSingle();

      final restored = Transaction.fromJson(row.toJson());
      expect(restored, row);
      expect(restored.type, TransactionType.transfer);
      expect(restored.destinationAccountId, 'dst');

      await (db.update(
        db.transactions,
      )..where((t) => t.id.equals('t2'))).write(const TransactionsCompanion(amount: Value(800000)));
      final updated = await db.select(db.transactions).getSingle();
      expect(updated.amount, 800000);
    });
  });

  group('TransactionItems table', () {
    test('allocation converter handles null and non-null values', () async {
      await seedAccount('acc');
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat'), name: 'Food', type: CategoryType.expense));
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('t3'),
              accountId: 'acc',
              type: TransactionType.expense,
              amount: 100000,
              transactionDate: DateTime(2026, 8, 3),
            ),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(
              id: const Value('i1'),
              transactionId: 't3',
              categoryId: const Value('cat'),
              allocation: const Value(TransactionAllocation.need),
              amount: 60000,
            ),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(
              id: const Value('i2'),
              transactionId: 't3',
              categoryId: const Value(null),
              allocation: const Value(null),
              amount: 40000,
            ),
          );

      final rows = await (db.select(db.transactionItems)..orderBy([(i) => OrderingTerm.asc(i.id)])).get();
      expect(rows.length, 2);

      final need = rows.first;
      expect(need.allocation, TransactionAllocation.need);
      expect(need.categoryId, 'cat');
      final unallocated = rows.last;
      expect(unallocated.allocation, isNull);
      expect(unallocated.categoryId, isNull);

      final changed = need.copyWith(amount: 65000);
      expect(changed.amount, 65000);
      expect(changed == need, isFalse);
      expect(need.copyWith(), need);
      expect(need.hashCode, isNotNull);
      expect(need.toString(), contains('TransactionItem'));

      expect(TransactionItem.fromJson(need.toJson()), need);
    });

    test('cascade deletes items with their transaction', () async {
      await seedAccount('acc');
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: const Value('t4'),
              accountId: 'acc',
              type: TransactionType.income,
              amount: 10,
              transactionDate: DateTime(2026, 8, 4),
            ),
          );
      await db
          .into(db.transactionItems)
          .insert(
            TransactionItemsCompanion.insert(id: const Value('i9'), transactionId: 't4', amount: 10),
          );

      await (db.delete(db.transactions)..where((t) => t.id.equals('t4'))).go();
      expect(await db.select(db.transactionItems).get(), isEmpty);
    });
  });
}
