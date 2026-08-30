import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

void main() {
  group('ReportModels', () {
    test('ReportSummary calculates net and rate', () {
      const summary = ReportSummary(totalIncome: 1000, totalExpense: 400);
      expect(summary.netCashflow, 600);
      expect(summary.savingsRatePct, 60);
      expect(summary.isOnTrack, true);
    });

    test('ReportSummary edge cases', () {
      const summaryZero = ReportSummary(totalIncome: 0, totalExpense: 100);
      expect(summaryZero.savingsRatePct, 0);

      const summaryHigh = ReportSummary(totalIncome: 100, totalExpense: 0);
      expect(summaryHigh.savingsRatePct, 100);
    });

    test('ReportBudgetAllocation calculates ratios', () {
      const alloc = ReportBudgetAllocation(need: 50, want: 30, saving: 20);
      expect(alloc.total, 100);
      expect(alloc.needRatio, 0.5);
      expect(alloc.wantRatio, 0.3);
      expect(alloc.savingRatio, 0.2);
    });

    test('ReportBudgetAllocation zero ratios', () {
      const alloc = ReportBudgetAllocation();
      expect(alloc.total, 0);
      expect(alloc.needRatio, 0);
      expect(alloc.wantRatio, 0);
      expect(alloc.savingRatio, 0);
    });

    test('ReportData empty data has zero summary', () {
      const empty = ReportData();
      expect(empty.summary.totalIncome, 0);
      expect(empty.summary.transactionCount, 0);
      expect(empty.expenseCategoryItems, isEmpty);

      const notEmpty = ReportData(summary: ReportSummary(totalIncome: 100));
      expect(notEmpty.summary.totalIncome, 100);
    });
  });

  group('ReportAnalyticsService', () {
    final now = DateTime.now();
    final categories = [
      CategoryModel(id: 'c1', name: 'Food', type: CategoryType.expense, color: '#f00', createdAt: now, updatedAt: now),
      CategoryModel(id: 'c2', name: 'Rent', type: CategoryType.expense, color: '#0f0', createdAt: now, updatedAt: now),
    ];

    TransactionModel createTx(
      DateTime date,
      TransactionType type,
      int amount, {
      String? categoryId,
      TransactionAllocation? allocation,
    }) {
      return TransactionModel(
        id: 'tx_${date.millisecondsSinceEpoch}',
        accountId: 'a1',
        type: type,
        amount: amount,
        transactionDate: date,
        createdAt: date,
        updatedAt: date,
        items: [
          TransactionItemModel(
            id: 'item1',
            transactionId: 'tx_${date.millisecondsSinceEpoch}',
            categoryId: categoryId,
            allocation: allocation,
            amount: amount,
            createdAt: date,
            updatedAt: date,
          ),
        ],
      );
    }

    test('calculate thisMonth', () {
      final txs = [
        createTx(now, TransactionType.income, 1000),
        createTx(now, TransactionType.expense, 300, categoryId: 'c1', allocation: TransactionAllocation.need),
        createTx(now, TransactionType.expense, 200, categoryId: 'unknown', allocation: TransactionAllocation.want),
        createTx(now, TransactionType.transfer, 500),
      ];

      final data = ReportAnalyticsService.calculate(txs, categories, ReportPeriod.thisMonth);

      expect(data.summary.totalIncome, 1000.0);
      expect(data.summary.totalExpense, 500.0);
      expect(data.summary.netCashflow, 500.0);
      expect(data.summary.savingsRatePct, 50);

      expect(data.expenseCategoryItems.length, 2);
      // sorted by amount descending
      expect(data.expenseCategoryItems[0].amount, 300.0);
      expect(data.expenseCategoryItems[0].name, 'Food');

      expect(data.expenseCategoryItems[1].amount, 200.0);

      expect(data.budgetAllocation.need, 300.0);
      expect(data.budgetAllocation.want, 200.0);

      expect(data.trendPoints.length, 4); // 4 weeks
    });

    test('calculate last3Months', () {
      final txs = [
        createTx(DateTime(now.year, now.month, 15), TransactionType.income, 1000),
        createTx(DateTime(now.year, now.month - 1, 15), TransactionType.expense, 400),
        createTx(DateTime(now.year, now.month - 2, 15), TransactionType.expense, 300),
      ];

      final data = ReportAnalyticsService.calculate(txs, categories, ReportPeriod.last3Months);

      expect(data.summary.totalIncome, 1000.0);
      expect(data.summary.totalExpense, 700.0);

      expect(data.trendPoints.length, 3); // 3 months
    });

    test('calculate last6Months', () {
      final txs = [
        createTx(DateTime(now.year, now.month, 15), TransactionType.income, 1000),
      ];
      final data = ReportAnalyticsService.calculate(txs, categories, ReportPeriod.last6Months);
      expect(data.trendPoints.length, 6);
    });
  });
}
