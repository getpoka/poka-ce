import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('RecurringTransactionModel', () {
    test('fromJson/toJson', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = RecurringTransactionModel(
        id: 'r1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 1000,
        period: RecurringPeriod.monthly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
        destinationAccountId: 'a2',
        categoryId: 'c1',
        allocation: TransactionAllocation.need,
        note: 'note',
        isActive: true,
      );
      final json = m.toJson();
      final restored = RecurringTransactionModel.fromJson(json);
      expect(restored, equals(m));
    });

    test('copyWith', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = RecurringTransactionModel(
        id: 'r1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 1000,
        period: RecurringPeriod.monthly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      );
      final c = m.copyWith(amount: 2000, isActive: false);
      expect(c.amount, 2000);
      expect(c.isActive, false);
    });

    test('equality', () {
      final now = DateTime.utc(2024, 1, 1);
      final a = RecurringTransactionModel(
        id: 'r1',
        accountId: 'a1',
        type: TransactionType.income,
        amount: 1000,
        period: RecurringPeriod.weekly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      );
      final b = RecurringTransactionModel(
        id: 'r1',
        accountId: 'a1',
        type: TransactionType.income,
        amount: 1000,
        period: RecurringPeriod.weekly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      );
      expect(a, equals(b));
    });

    test('defaults', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = RecurringTransactionModel(
        id: 'r1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 1000,
        period: RecurringPeriod.monthly,
        nextDate: now,
        createdAt: now,
        updatedAt: now,
      );
      expect(m.isActive, true);
    });
  });
}
