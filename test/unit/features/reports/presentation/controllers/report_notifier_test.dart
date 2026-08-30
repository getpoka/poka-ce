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
  });
}
