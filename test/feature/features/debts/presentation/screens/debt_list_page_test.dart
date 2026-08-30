import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/debts/presentation/screens/debt_list_page.dart';
import 'package:poka_ce/theme/theme.dart';

// Create a mocked Notifier to simulate state.
class MockDebtListNotifier extends DebtList {
  final List<DebtModel> _initialDebts;
  final bool _loading;

  MockDebtListNotifier(this._initialDebts, [this._loading = false]);

  @override
  Stream<List<DebtModel>> build() => _loading ? const Stream.empty() : Stream.value(_initialDebts);
}

void main() {
  Widget buildTestApp(ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: FTheme(
        data: lightTheme,
        child: const MaterialApp(
          home: Scaffold(body: DebtListPage()),
        ),
      ),
    );
  }

  testWidgets('DebtListPage shows loading indicator when loading', (tester) async {
    final container = ProviderContainer(
      overrides: [
        debtListProvider.overrideWith(() => MockDebtListNotifier([], true)),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pump();
    expect(find.byType(FCircularProgress), findsOneWidget);
  });

  testWidgets('DebtListPage shows empty state', (tester) async {
    final container = ProviderContainer(
      overrides: [
        debtListProvider.overrideWith(() => MockDebtListNotifier([], false)),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pumpAndSettle();

    expect(find.text('No debts recorded'), findsWidgets);
  });

  testWidgets('DebtListPage shows debts in active and paid tabs', (tester) async {
    final debtActive = DebtModel(
      id: 'd1',
      type: DebtType.debt,
      personName: 'Active Debt',
      amount: 1000,
      remainingAmount: 1000,
      dueDate: DateTime.now(),
      status: DebtStatus.active,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final debtPaid = DebtModel(
      id: 'd2',
      type: DebtType.loan,
      personName: 'Paid Loan',
      amount: 1000,
      remainingAmount: 0,
      dueDate: DateTime.now(),
      status: DebtStatus.paid,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final container = ProviderContainer(
      overrides: [
        debtListProvider.overrideWith(() => MockDebtListNotifier([debtActive, debtPaid], false)),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pumpAndSettle();

    expect(find.text('Active Debt'), findsWidgets);
  });
}
