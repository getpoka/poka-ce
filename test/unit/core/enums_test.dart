import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Core Enums', () {
    test('CategoryType values', () {
      expect(CategoryType.values.length, 2);
      expect(CategoryType.values, containsAll([CategoryType.income, CategoryType.expense]));
    });

    test('AccountType values', () {
      expect(AccountType.values.length, 3);
      expect(AccountType.values, containsAll([AccountType.assets, AccountType.liability, AccountType.goal]));
    });

    test('BudgetPeriod values', () {
      expect(BudgetPeriod.values.length, 4);
      expect(
        BudgetPeriod.values,
        containsAll([BudgetPeriod.monthly, BudgetPeriod.weekly, BudgetPeriod.yearly, BudgetPeriod.custom]),
      );
    });

    test('TransactionType values', () {
      expect(TransactionType.values.length, 3);
      expect(
        TransactionType.values,
        containsAll([TransactionType.income, TransactionType.expense, TransactionType.transfer]),
      );
    });

    test('RecurringPeriod values', () {
      expect(RecurringPeriod.values.length, 4);
      expect(
        RecurringPeriod.values,
        containsAll([RecurringPeriod.daily, RecurringPeriod.weekly, RecurringPeriod.monthly, RecurringPeriod.yearly]),
      );
    });

    test('DebtType values', () {
      expect(DebtType.values.length, 2);
      expect(DebtType.values, containsAll([DebtType.debt, DebtType.loan]));
    });

    test('DebtStatus values', () {
      expect(DebtStatus.values.length, 2);
      expect(DebtStatus.values, containsAll([DebtStatus.active, DebtStatus.paid]));
    });

    test('TransactionAllocation values', () {
      expect(TransactionAllocation.values.length, 3);
      expect(
        TransactionAllocation.values,
        containsAll([TransactionAllocation.need, TransactionAllocation.want, TransactionAllocation.saving]),
      );
    });
  });
}
