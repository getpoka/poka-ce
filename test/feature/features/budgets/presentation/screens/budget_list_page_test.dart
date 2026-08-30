import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';
import 'package:poka_ce/features/budgets/presentation/screens/budget_list_page.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockBudgetRepository extends Mock implements IBudgetRepository {}

BudgetModel _budget(
  String id,
  String name,
  int amount,
  BudgetPeriod period, {
  int? resetDay,
  DateTime? startDate,
  DateTime? endDate,
}) {
  final now = DateTime.utc(2024, 1, 1);
  return BudgetModel(
    id: id,
    name: name,
    amount: amount,
    period: period,
    startDate: startDate ?? now,
    endDate: endDate,
    resetDay: resetDay,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(DateTime.utc(2024, 1, 1));
  });

  late MockBudgetRepository mockBudgetRepo;

  Widget wrapBudget(
    List<BudgetModel> budgets, {
    int spentValue = 200,
    bool spentError = false,
    bool loading = false,
  }) {
    mockBudgetRepo = MockBudgetRepository();
    if (spentError) {
      when(
        () => mockBudgetRepo.getSpentAmountForBudget(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          categoryId: any(named: 'categoryId'),
          accountId: any(named: 'accountId'),
        ),
      ).thenAnswer((_) async => const ErrorResult<int, Failure>(DatabaseFailure('fail')));
    } else {
      when(
        () => mockBudgetRepo.getSpentAmountForBudget(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          categoryId: any(named: 'categoryId'),
          accountId: any(named: 'accountId'),
        ),
      ).thenAnswer((_) async => Success<int, Failure>(spentValue));
    }

    return ProviderScope(
      overrides: [
        budgetListProvider.overrideWith(() => _FakeBudgetNotifier(budgets, loading: loading)),
        budgetRepositoryProvider.overrideWithValue(mockBudgetRepo),
        transactionListNotifierProvider.overrideWith(() => _FakeTxNotifier()),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const BudgetListPage(),
        ),
      ),
    );
  }

  group('BudgetListPage', () {
    testWidgets('shows loading indicator when loading and empty', (tester) async {
      await tester.pumpWidget(wrapBudget(const [], loading: true));
      await tester.pump();
      expect(find.byType(FCircularProgress), findsOneWidget);
    });

    testWidgets('shows empty state when no budgets', (tester) async {
      await tester.pumpWidget(wrapBudget(const []));
      await tester.pumpAndSettle();
      expect(find.text('No budgets yet'), findsOneWidget);
      expect(find.textContaining('spending limits'), findsOneWidget);
      expect(find.text('Create Budget'), findsOneWidget);
      expect(find.text('Budgets'), findsOneWidget);
    });

    testWidgets('shows populated budgets with summary and cards', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final b1 = _budget('1', 'Groceries', 1000, BudgetPeriod.monthly, resetDay: 1);
      final b2 = _budget('2', 'Rent', 2000, BudgetPeriod.weekly);
      final budgets = [b1, b2];

      await tester.pumpWidget(wrapBudget(budgets, spentValue: 300));
      await tester.pumpAndSettle();

      expect(find.text('ALL BUDGETS'), findsOneWidget);
      expect(find.text('Add Budget'), findsOneWidget);
      expect(find.text('Groceries'), findsOneWidget);
      expect(find.text('Rent'), findsOneWidget);
      // Summary card
      expect(find.text('Remaining'), findsOneWidget);
      expect(find.textContaining('Spent'), findsWidgets);
      expect(find.text('Total limit'), findsOneWidget);
      expect(find.text('2 budgets'), findsOneWidget);
    });

    testWidgets('shows period badges for each period value', (tester) async {
      final budgets = [
        _budget('1', 'Monthly B', 1000, BudgetPeriod.monthly),
        _budget('2', 'Weekly B', 1000, BudgetPeriod.weekly),
        _budget('3', 'Yearly B', 1000, BudgetPeriod.yearly),
        _budget(
          '4',
          'Custom B',
          1000,
          BudgetPeriod.custom,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 12, 31),
        ),
      ];

      await tester.pumpWidget(wrapBudget(budgets));
      await tester.pumpAndSettle();

      expect(find.text('MONTHLY'), findsOneWidget);
      expect(find.text('WEEKLY'), findsOneWidget);
      expect(find.text('YEARLY'), findsOneWidget);
      expect(find.text('CUSTOM'), findsOneWidget);
    });

    testWidgets('danger state shows over when spent >= limit', (tester) async {
      // amount 500, spent 600 => over
      final b = _budget('1', 'Over Budget', 500, BudgetPeriod.monthly);

      await tester.pumpWidget(wrapBudget([b], spentValue: 600));
      await tester.pumpAndSettle();

      // Card footer shows "over" label when remaining <0
      expect(find.text('over'), findsOneWidget);
      expect(find.text('left'), findsNothing);
      // Summary should show Over limit pill
      expect(find.text('Over limit'), findsOneWidget);
    });

    testWidgets('shows left when under limit', (tester) async {
      final b = _budget('1', 'OK Budget', 1000, BudgetPeriod.monthly);

      await tester.pumpWidget(wrapBudget([b], spentValue: 200));
      await tester.pumpAndSettle();

      expect(find.text('left'), findsOneWidget);
      expect(find.text('over'), findsNothing);
      expect(find.text('Over limit'), findsNothing);
    });

    testWidgets('handles budgetRepository error gracefully shows 0 spent', (tester) async {
      final b = _budget('1', 'Err Budget', 1000, BudgetPeriod.monthly);

      await tester.pumpWidget(wrapBudget([b], spentError: true));
      await tester.pumpAndSettle();

      // Should still render card, with 0% and left
      expect(find.text('Err Budget'), findsOneWidget);
      expect(find.textContaining('0% of'), findsOneWidget);
      expect(find.text('left'), findsOneWidget);
    });

    testWidgets('Add Budget button does not crash', (tester) async {
      final b = _budget('1', 'Food', 1000, BudgetPeriod.monthly);
      await tester.pumpWidget(wrapBudget([b]));
      await tester.pumpAndSettle();

      final add = find.text('Add Budget');
      expect(add, findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('single budget summary hides Over limit when not over', (tester) async {
      final b = _budget('1', 'Single', 5000, BudgetPeriod.yearly);
      await tester.pumpWidget(wrapBudget([b], spentValue: 100));
      await tester.pumpAndSettle();

      expect(find.text('1 budget'), findsOneWidget);
      expect(find.text('Over limit'), findsNothing);
    });

    testWidgets('footer shows percentage and spent correctly', (tester) async {
      // 250 spent of 1000 => 25%
      final b = _budget('1', 'Pct Budget', 1000, BudgetPeriod.monthly);
      await tester.pumpWidget(wrapBudget([b], spentValue: 250));
      await tester.pumpAndSettle();

      expect(find.textContaining('25% of'), findsOneWidget);
      expect(find.textContaining('Spent'), findsOneWidget);
    });
  });
}

class _FakeBudgetNotifier extends BudgetListNotifier {
  _FakeBudgetNotifier(this._state, {this.loading = false});
  final List<BudgetModel> _state;
  final bool loading;
  @override
  Future<List<BudgetModel>> build() => loading ? Completer<List<BudgetModel>>().future : Future.value(_state);
  @override
  Future<void> refresh() async {}
  @override
  Future<void> deleteBudget(String id) async {}
}

class _FakeTxNotifier extends TransactionListNotifier {
  @override
  TransactionListState build() => TransactionListState(isLoading: false, transactions: [], focusedDate: DateTime.now());
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();
}
