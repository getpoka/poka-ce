import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('TransactionItemModel', () {
    test('fromJson/toJson', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = TransactionItemModel(
        id: 'i1',
        transactionId: 't1',
        amount: 500,
        createdAt: now,
        updatedAt: now,
        categoryId: 'c1',
        allocation: TransactionAllocation.need,
        note: 'note',
      );
      final json = m.toJson();
      final restored = TransactionItemModel.fromJson(json);
      expect(restored, equals(m));
    });

    test('copyWith', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = TransactionItemModel(id: 'i1', transactionId: 't1', amount: 500, createdAt: now, updatedAt: now);
      final c = m.copyWith(amount: 1000);
      expect(c.amount, 1000);
    });
  });

  group('TransactionModel', () {
    test('fromJson/toJson', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = TransactionModel(
        id: 't1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 500,
        transactionDate: now,
        createdAt: now,
        updatedAt: now,
        destinationAccountId: 'a2',
        note: 'note',
        recurringTransactionId: 'r1',
        debtId: 'd1',
        items: [],
      );
      final json = m.toJson();
      final restored = TransactionModel.fromJson(json);
      expect(restored, equals(m));
    });

    test('copyWith', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = TransactionModel(
        id: 't1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 500,
        transactionDate: now,
        createdAt: now,
        updatedAt: now,
      );
      final c = m.copyWith(amount: 1000, note: 'updated');
      expect(c.amount, 1000);
      expect(c.note, 'updated');
    });

    test('equality with items', () {
      final now = DateTime.utc(2024, 1, 1);
      final items = [TransactionItemModel(id: 'i1', transactionId: 't1', amount: 500, createdAt: now, updatedAt: now)];
      final a = TransactionModel(
        id: 't1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 500,
        transactionDate: now,
        createdAt: now,
        updatedAt: now,
        items: items,
      );
      final b = TransactionModel(
        id: 't1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 500,
        transactionDate: now,
        createdAt: now,
        updatedAt: now,
        items: items,
      );
      expect(a, equals(b));
    });

    test('default items empty', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = TransactionModel(
        id: 't1',
        accountId: 'a1',
        type: TransactionType.income,
        amount: 100,
        transactionDate: now,
        createdAt: now,
        updatedAt: now,
      );
      expect(m.items, isEmpty);
    });
  });
}
