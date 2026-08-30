import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/dashboard/domain/services/dashboard_analytics_service.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DashboardState copyWith', () {
    final base = DashboardState(
      accounts: [
        AccountModel(
          id: 'a1',
          name: 'Wallet',
          type: AccountType.assets,
          balance: 1000,
          createdAt: DateTime.utc(2026),
          updatedAt: DateTime.utc(2026),
        ),
      ],
      recentTransactions: const [],
      isLoading: false,
      netWorth: 1000,
      totalAssets: 1000,
      totalLiabilities: 0,
      totalIncome: 500,
      totalExpense: 200,
      activeAccountCount: 1,
      categoryExpenses: const [],
      budgetAllocations: const {},
      dailySpending: const [1, 2, 3, 4, 5, 6, 7],
      maxDailySpending: 7,
      normalizedDailySpending: const [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 1.0],
    );

    test('copyWith retains original when no args', () {
      final copy = base.copyWith();
      expect(copy.accounts.length, 1);
      expect(copy.isLoading, false);
      expect(copy.netWorth, 1000);
      expect(copy.totalAssets, 1000);
      expect(copy.totalLiabilities, 0);
      expect(copy.totalIncome, 500);
      expect(copy.totalExpense, 200);
      expect(copy.activeAccountCount, 1);
      expect(copy.maxDailySpending, 7);
    });

    test('copyWith overrides all fields', () {
      final newTx = TransactionModel(
        id: 't1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 99,
        transactionDate: DateTime.utc(2026),
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
      );
      final copy = base.copyWith(
        accounts: [],
        recentTransactions: [newTx],
        isLoading: true,
        netWorth: 2000,
        totalAssets: 2000,
        totalLiabilities: 500,
        totalIncome: 1000,
        totalExpense: 800,
        activeAccountCount: 0,
        categoryExpenses: [CategoryExpenseItem('Food', '#FF0000', 100)],
        budgetAllocations: {TransactionAllocation.need: 0.5},
        dailySpending: const [0, 0, 0, 0, 0, 0, 0],
        maxDailySpending: 0,
        normalizedDailySpending: const [0, 0, 0, 0, 0, 0, 0],
      );
      expect(copy.accounts, isEmpty);
      expect(copy.recentTransactions.length, 1);
      expect(copy.isLoading, isTrue);
      expect(copy.netWorth, 2000);
      expect(copy.totalAssets, 2000);
      expect(copy.totalLiabilities, 500);
      expect(copy.totalIncome, 1000);
      expect(copy.totalExpense, 800);
      expect(copy.activeAccountCount, 0);
      expect(copy.categoryExpenses.length, 1);
      expect(copy.budgetAllocations[TransactionAllocation.need], 0.5);
      expect(copy.dailySpending, [0, 0, 0, 0, 0, 0, 0]);
      expect(copy.maxDailySpending, 0);
    });

    test('copyWith partial override', () {
      final copy = base.copyWith(netWorth: 9999, isLoading: true);
      expect(copy.netWorth, 9999);
      expect(copy.isLoading, isTrue);
      // others unchanged
      expect(copy.totalAssets, 1000);
      expect(copy.accounts.length, 1);
    });

    test('DashboardState default constructor', () {
      const empty = DashboardState();
      expect(empty.accounts, isEmpty);
      expect(empty.recentTransactions, isEmpty);
      expect(empty.isLoading, isTrue);
      expect(empty.netWorth, 0);
      expect(empty.dailySpending, [0, 0, 0, 0, 0, 0, 0]);
    });
  });
}
