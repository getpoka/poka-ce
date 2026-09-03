import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';

class MockBudgetRepository extends Mock implements IBudgetRepository {}

void main() {
  group('ReportState', () {
    test('copyWith', () {
      const state = ReportState();
      final newState = state.copyWith(period: ReportPeriod.last3Months, isLoading: false);
      expect(newState.period, ReportPeriod.last3Months);
      expect(newState.isLoading, false);
    });

    test('previousPeriodLabel per period', () {
      const thisMonth = ReportState(period: ReportPeriod.thisMonth);
      expect(thisMonth.previousPeriodLabel, 'last month');
      const lastMonth = ReportState(period: ReportPeriod.lastMonth);
      expect(lastMonth.previousPeriodLabel, 'prev month');
      const last3 = ReportState(period: ReportPeriod.last3Months);
      expect(last3.previousPeriodLabel, 'prev 3 mo');
      const last6 = ReportState(period: ReportPeriod.last6Months);
      expect(last6.previousPeriodLabel, 'prev 6 mo');
      const custom = ReportState(period: ReportPeriod.custom);
      expect(custom.previousPeriodLabel, 'prev period');
    });
  });

  group('ReportNotifier', () {
    ProviderContainer makeContainer() {
      final mockBudget = MockBudgetRepository();
      when(() => mockBudget.getBudgets()).thenAnswer((_) async => const Success([]));
      final container = ProviderContainer(
        overrides: [
          recentTransactionsStreamProvider.overrideWith((ref) => Stream.value([])),
          categoriesStreamProvider.overrideWith((ref) => Stream.value([])),
          budgetRepositoryProvider.overrideWithValue(mockBudget),
        ],
      );
      container.listen(reportProvider, (_, __) {});
      addTearDown(container.dispose);
      return container;
    }

    test('builds initial state', () {
      final container = makeContainer();
      final state = container.read(reportProvider);
      expect(state.period, ReportPeriod.thisMonth);
      // isLoading may be true on first build while streams resolve — just verify period
      expect(state.data.summary.totalExpense, 0);
    });

    test('setPeriod invalidates and rebuilds', () async {
      final container = makeContainer();
      final notifier = container.read(reportProvider.notifier);
      notifier.setPeriod(ReportPeriod.last3Months);

      // Allow async riverpod rebuild to process
      await Future.delayed(Duration.zero);

      final state = container.read(reportProvider);
      expect(state.period, ReportPeriod.last3Months);
    });

    test('setPeriod to non-custom clears custom range', () async {
      final container = makeContainer();
      final notifier = container.read(reportProvider.notifier);

      notifier.setCustomRange(DateTime.utc(2024, 1, 1), DateTime.utc(2024, 1, 31));
      await Future.delayed(Duration.zero);
      var state = container.read(reportProvider);
      expect(state.period, ReportPeriod.custom);
      expect(state.customDateStart, DateTime.utc(2024, 1, 1));
      expect(state.customDateEnd, DateTime.utc(2024, 1, 31));

      notifier.setPeriod(ReportPeriod.thisMonth);
      await Future.delayed(Duration.zero);
      state = container.read(reportProvider);
      expect(state.period, ReportPeriod.thisMonth);
      expect(state.customDateStart, isNull);
      expect(state.customDateEnd, isNull);
    });
  });
}
