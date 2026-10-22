import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DebtModel', () {
    test('fromJson/toJson', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = DebtModel(
        id: 'd1',
        personName: 'Alice',
        type: DebtType.debt,
        amount: 1000,
        remainingAmount: 500,
        status: DebtStatus.active,
        createdAt: now,
        updatedAt: now,
        dueDate: '2024-01-01',
        note: 'note',
      );
      final json = m.toJson();
      final restored = DebtModel.fromJson(json);
      expect(restored, equals(m));
    });

    test('copyWith', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = DebtModel(
        id: 'd1',
        personName: 'Alice',
        type: DebtType.debt,
        amount: 1000,
        remainingAmount: 1000,
        status: DebtStatus.active,
        createdAt: now,
        updatedAt: now,
      );
      final c = m.copyWith(personName: 'Bob', status: DebtStatus.paid);
      expect(c.personName, 'Bob');
      expect(c.status, DebtStatus.paid);
    });

    test('equality', () {
      final now = DateTime.utc(2024, 1, 1);
      final a = DebtModel(
        id: 'd1',
        personName: 'Alice',
        type: DebtType.loan,
        amount: 1000,
        remainingAmount: 1000,
        status: DebtStatus.active,
        createdAt: now,
        updatedAt: now,
      );
      final b = DebtModel(
        id: 'd1',
        personName: 'Alice',
        type: DebtType.loan,
        amount: 1000,
        remainingAmount: 1000,
        status: DebtStatus.active,
        createdAt: now,
        updatedAt: now,
      );
      expect(a, equals(b));
    });

    test('effectiveDisbursedAmount and interestAmount calculations', () {
      final now = DateTime.utc(2024, 1, 1);
      final debtWithInterest = DebtModel(
        id: 'd1',
        personName: 'Bob',
        type: DebtType.debt,
        amount: 120000,
        disbursedAmount: 100000,
        remainingAmount: 120000,
        status: DebtStatus.active,
        createdAt: now,
        updatedAt: now,
      );
      expect(debtWithInterest.effectiveDisbursedAmount, 100000);
      expect(debtWithInterest.interestAmount, 20000);

      final debtZeroInterest = DebtModel(
        id: 'd2',
        personName: 'Charlie',
        type: DebtType.debt,
        amount: 50000,
        disbursedAmount: null,
        remainingAmount: 50000,
        status: DebtStatus.active,
        createdAt: now,
        updatedAt: now,
      );
      expect(debtZeroInterest.effectiveDisbursedAmount, 50000);
      expect(debtZeroInterest.interestAmount, 0);
    });
  });
}
