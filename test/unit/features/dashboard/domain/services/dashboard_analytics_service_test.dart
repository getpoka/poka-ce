import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/dashboard/domain/services/dashboard_analytics_service.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

void main() {
  group('DashboardAnalyticsService', () {
    group('calculateAccountMetrics', () {
      test('computes netWorth, totalAssets, and totalLiabilities correctly', () {
        final now = DateTime.now();
        final accounts = [
          AccountModel(
            id: '1',
            name: 'Cash',
            icon: 'wallet',
            color: '#000000',
            type: AccountType.assets,
            balance: 500,
            initialBalance: 500,
            isActive: true,
            createdAt: now,
            updatedAt: now,
          ),
          AccountModel(
            id: '2',
            name: 'Debt Account',
            icon: 'card',
            color: '#000000',
            type: AccountType.liability,
            balance: -200,
            initialBalance: 0,
            isActive: true,
            createdAt: now,
            updatedAt: now,
          ),
          AccountModel(
            id: '3',
            name: 'Archived',
            icon: 'archive',
            color: '#000000',
            type: AccountType.assets,
            balance: 1000,
            initialBalance: 1000,
            isActive: false,
            createdAt: now,
            updatedAt: now,
          ),
        ];

        final metrics = DashboardAnalyticsService.calculateAccountMetrics(accounts);
        expect(metrics.activeAccountCount, 2);
        expect(metrics.totalAssets, 500.0);
        expect(metrics.totalLiabilities, 200.0);
        expect(metrics.netWorth, 300.0);
      });
    });

    group('calculateNetWorthTrend', () {
      test('returns constant array when there are no transactions', () {
        final trend = DashboardAnalyticsService.calculateNetWorthTrend(
          currentNetWorth: 1000,
          transactions: const [],
          days: 7,
        );

        expect(trend.length, 7);
        for (final val in trend) {
          expect(val, 1000.0);
        }
      });

      test('returns empty list when days is zero or negative', () {
        final trend = DashboardAnalyticsService.calculateNetWorthTrend(
          currentNetWorth: 1000,
          transactions: const [],
          days: 0,
        );
        expect(trend, isEmpty);
      });

      test('reconstructs historical net worth accurately based on income and expenses', () {
        final now = DateTime.now().toUtc();
        final today = DateTime.utc(now.year, now.month, now.day, 12);
        final yesterday = today.subtract(const Duration(days: 1));

        final transactions = [
          // Today: expense of 200
          TransactionModel(
            id: 'tx1',
            accountId: 'acc1',
            type: TransactionType.expense,
            amount: 200,
            transactionDate: today,
            items: const [],
            createdAt: today,
            updatedAt: today,
          ),
          // Yesterday: income of 500
          TransactionModel(
            id: 'tx2',
            accountId: 'acc1',
            type: TransactionType.income,
            amount: 500,
            transactionDate: yesterday,
            items: const [],
            createdAt: yesterday,
            updatedAt: yesterday,
          ),
        ];

        // Current net worth today is 1000
        final trend = DashboardAnalyticsService.calculateNetWorthTrend(
          currentNetWorth: 1000,
          transactions: transactions,
          days: 7,
        );

        expect(trend.length, 7);
        // Index 6 is today: 1000
        expect(trend[6], 1000.0);
        // Index 5 is yesterday: today net worth was 1000, but today we had an expense of 200,
        // so yesterday's closing net worth was 1000 - (-200) = 1200
        expect(trend[5], 1200.0);
        // Index 4 is 2 days ago: yesterday's closing was 1200, but yesterday we had income of 500,
        // so 2 days ago closing net worth was 1200 - 500 = 700
        expect(trend[4], 700.0);
        // Earlier days (indices 0, 1, 2, 3) should remain 700 because no older transactions
        expect(trend[0], 700.0);
        expect(trend[1], 700.0);
        expect(trend[2], 700.0);
        expect(trend[3], 700.0);
      });
    });

    group('calculateTransactionMetrics', () {
      test('calculates income, expense, and daily spending properly', () {
        final now = DateTime.now().toUtc();
        final today = DateTime.utc(now.year, now.month, now.day, 10);
        final cat = CategoryModel(
          id: 'cat1',
          name: 'Food',
          icon: 'fork',
          color: '#FF0000',
          type: CategoryType.expense,
          sort: 1,
          isActive: true,
          createdAt: now,
          updatedAt: now,
        );

        final transactions = [
          TransactionModel(
            id: 't1',
            accountId: 'a1',
            type: TransactionType.income,
            amount: 1500,
            transactionDate: today,
            items: const [],
            createdAt: today,
            updatedAt: today,
          ),
          TransactionModel(
            id: 't2',
            accountId: 'a1',
            type: TransactionType.expense,
            amount: 300,
            transactionDate: today,
            items: [
              TransactionItemModel(
                id: 'item1',
                transactionId: 't2',
                categoryId: 'cat1',
                allocation: TransactionAllocation.need,
                amount: 300,
                createdAt: today,
                updatedAt: today,
              ),
            ],
            createdAt: today,
            updatedAt: today,
          ),
        ];

        final metrics = DashboardAnalyticsService.calculateTransactionMetrics(transactions, [cat]);
        expect(metrics.totalIncome, 1500.0);
        expect(metrics.totalExpense, 300.0);
        expect(metrics.dailySpending.last, 300.0);
        expect(metrics.categoryExpenses, isNotEmpty);
        expect(metrics.categoryExpenses.first.name, 'Food');
      });
    });
  });
}
