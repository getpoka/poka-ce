import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BudgetModel', () {
    test('fromJson/toJson', () {
      final now = DateTime.utc(2024, 1, 1);
      const dateStr = '2024-01-01';
      final model = BudgetModel(
        id: 'b1',
        name: 'Food',
        amount: 1000,
        period: BudgetPeriod.monthly,
        startDate: dateStr,
        createdAt: now,
        updatedAt: now,
        categoryId: 'c1',
        accountId: 'a1',
        resetDay: 1,
        endDate: dateStr,
      );
      final json = model.toJson();
      final restored = BudgetModel.fromJson(json);
      expect(restored, equals(model));
    });

    test('copyWith', () {
      final now = DateTime.utc(2024, 1, 1);
      const dateStr = '2024-01-01';
      final model = BudgetModel(
        id: 'b1',
        name: 'Food',
        amount: 1000,
        period: BudgetPeriod.monthly,
        startDate: dateStr,
        createdAt: now,
        updatedAt: now,
      );
      final copy = model.copyWith(name: 'Rent', amount: 2000);
      expect(copy.name, 'Rent');
      expect(copy.amount, 2000);
      expect(copy.id, 'b1');
    });

    test('equality', () {
      final now = DateTime.utc(2024, 1, 1);
      const dateStr = '2024-01-01';
      final a = BudgetModel(
        id: 'b1',
        name: 'Food',
        amount: 1000,
        period: BudgetPeriod.weekly,
        startDate: dateStr,
        createdAt: now,
        updatedAt: now,
      );
      final b = BudgetModel(
        id: 'b1',
        name: 'Food',
        amount: 1000,
        period: BudgetPeriod.weekly,
        startDate: dateStr,
        createdAt: now,
        updatedAt: now,
      );
      expect(a, equals(b));
    });

    test('optional fields null by default', () {
      final now = DateTime.utc(2024, 1, 1);
      const dateStr = '2024-01-01';
      final m = BudgetModel(
        id: 'b1',
        name: 'Food',
        amount: 1000,
        period: BudgetPeriod.monthly,
        startDate: dateStr,
        createdAt: now,
        updatedAt: now,
      );
      expect(m.categoryId, isNull);
      expect(m.accountId, isNull);
    });
  });

  group('BudgetRecordModel', () {
    test('fromJson/toJson', () {
      final now = DateTime.utc(2024, 1, 1);
      const dateStr = '2024-01-01';
      final model = BudgetRecordModel(
        id: 'r1',
        budgetId: 'b1',
        spentAmount: 500,
        periodStart: dateStr,
        periodEnd: dateStr,
        createdAt: now,
        updatedAt: now,
      );
      final json = model.toJson();
      final restored = BudgetRecordModel.fromJson(json);
      expect(restored, equals(model));
    });

    test('copyWith', () {
      final now = DateTime.utc(2024, 1, 1);
      const dateStr = '2024-01-01';
      final model = BudgetRecordModel(
        id: 'r1',
        budgetId: 'b1',
        spentAmount: 500,
        periodStart: dateStr,
        periodEnd: dateStr,
        createdAt: now,
        updatedAt: now,
      );
      final copy = model.copyWith(spentAmount: 1000);
      expect(copy.spentAmount, 1000);
    });
  });
}
