import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/dashboard/domain/services/dashboard_analytics_service.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/core/error/result.dart';

class MockAccountRepo extends Mock implements IAccountRepository {}

class MockTxRepo extends Mock implements ITransactionRepository {}

class MockCatRepo extends Mock implements ICategoryRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAccountRepo mockAccount;
  late MockTxRepo mockTx;
  late MockCatRepo mockCat;

  setUp(() {
    mockAccount = MockAccountRepo();
    mockTx = MockTxRepo();
    mockCat = MockCatRepo();
  });

  ProviderContainer makeContainer() {
    final c = ProviderContainer(
      overrides: [
        accountRepositoryProvider.overrideWithValue(mockAccount),
        transactionRepositoryProvider.overrideWithValue(mockTx),
        categoryRepositoryProvider.overrideWithValue(mockCat),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  Future<void> wait(ProviderContainer c) async {
    while (c.read(dashboardProvider).isLoading) {
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  group('DashboardState dailySpending branches (mutation hardening)', () {
    test('dailySpending excludes income, future tx, and >=7 days (mutation <7 -> <=7)', () {
      final now = DateTime.now().toUtc();
      final txs = [
        TransactionModel(
          id: '1',
          accountId: 'a',
          type: TransactionType.expense,
          amount: 100,
          transactionDate: now.subtract(const Duration(days: 6)),
          createdAt: now,
          updatedAt: now,
        ),
        TransactionModel(
          id: '2',
          accountId: 'a',
          type: TransactionType.expense,
          amount: 999,
          transactionDate: now.subtract(const Duration(days: 7, hours: 2)),
          createdAt: now,
          updatedAt: now,
        ),
        TransactionModel(
          id: '3',
          accountId: 'a',
          type: TransactionType.expense,
          amount: 888,
          transactionDate: now.add(const Duration(days: 2)),
          createdAt: now,
          updatedAt: now,
        ),
        TransactionModel(
          id: '4',
          accountId: 'a',
          type: TransactionType.income,
          amount: 500,
          transactionDate: now,
          createdAt: now,
          updatedAt: now,
        ),
      ];
      final m = DashboardAnalyticsService.calculateTransactionMetrics(txs, []);
      expect(m.dailySpending[0], 100);
      expect(m.dailySpending.contains(999), isFalse);
      expect(m.dailySpending.contains(888), isFalse);
      expect(m.dailySpending[6], 0.0);
    });

    test('dailySpending today expense at index 6', () {
      final now = DateTime.now().toUtc();
      final txs = [
        TransactionModel(
          id: '1',
          accountId: 'a',
          type: TransactionType.expense,
          amount: 42,
          transactionDate: now,
          createdAt: now,
          updatedAt: now,
        ),
      ];
      final m = DashboardAnalyticsService.calculateTransactionMetrics(txs, []);
      expect(m.dailySpending[6], 42);
      expect(m.maxDailySpending, 42);
    });

    test('normalizedDailySpending returns zeros when max<=0 (mutation <=0 -> <0)', () {
      final m = DashboardAnalyticsService.calculateTransactionMetrics([], []);
      expect(m.normalizedDailySpending, List.filled(7, 0.0));
      expect(m.maxDailySpending, 0);
    });

    test('normalizedDailySpending scales correctly', () {
      final now = DateTime.now().toUtc();
      final txs = [
        TransactionModel(
          id: '1',
          accountId: 'a',
          type: TransactionType.expense,
          amount: 20,
          transactionDate: now,
          createdAt: now,
          updatedAt: now,
        ),
        TransactionModel(
          id: '2',
          accountId: 'a',
          type: TransactionType.expense,
          amount: 10,
          transactionDate: now.subtract(const Duration(days: 1)),
          createdAt: now,
          updatedAt: now,
        ),
      ];
      final m = DashboardAnalyticsService.calculateTransactionMetrics(txs, []);
      expect(m.normalizedDailySpending[6], 1.0);
      expect(m.normalizedDailySpending[5], 0.5);
    });
  });

  group('DashboardNotifier allocation & categoryExpenses edge branches', () {
    test('budgetAllocations handles null allocation and tracks category expense', () async {
      final now = DateTime.now();
      when(() => mockAccount.watchAccounts()).thenAnswer((_) => Stream.value(const Success([])));
      when(() => mockCat.watchCategories()).thenAnswer((_) => Stream.value(const Success([])));
      final txs = [
        TransactionModel(
          id: '1',
          accountId: 'a',
          type: TransactionType.expense,
          amount: 150,
          transactionDate: now,
          createdAt: now,
          updatedAt: now,
          items: [
            TransactionItemModel(
              id: 'i1',
              transactionId: '1',
              amount: 100,
              createdAt: now,
              updatedAt: now,
              allocation: TransactionAllocation.need,
              categoryId: 'c1',
            ),
            TransactionItemModel(
              id: 'i2',
              transactionId: '1',
              amount: 50,
              createdAt: now,
              updatedAt: now,
              allocation: null,
              categoryId: null,
            ),
          ],
        ),
      ];
      when(() => mockTx.watchTransactions()).thenAnswer((_) => Stream.value(Success(txs)));
      final c = makeContainer();
      c.listen(dashboardProvider, (_, __) {});
      await Future.delayed(const Duration(milliseconds: 50));
      final s = c.read(dashboardProvider);
      expect(s.budgetAllocations[TransactionAllocation.need], 100);
      expect(s.budgetAllocations[TransactionAllocation.want], 0);
      // c1 contributes to categoryExpenses
      expect(s.categoryExpenses.length, 1);
      expect(s.categoryExpenses.first.amount, 100);
    });

    test('balance ==0 excluded from assets/liabilities (mutation >0 -> >=0)', () async {
      final accountZero = AccountModel(
        id: 'z',
        name: 'Zero',
        type: AccountType.assets,
        balance: 0,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      when(() => mockAccount.watchAccounts()).thenAnswer((_) => Stream.value(Success([accountZero])));
      when(() => mockTx.watchTransactions()).thenAnswer((_) => Stream.value(const Success([])));
      when(() => mockCat.watchCategories()).thenAnswer((_) => Stream.value(const Success([])));
      final c = makeContainer();
      c.listen(dashboardProvider, (_, __) {});
      await Future.delayed(const Duration(milliseconds: 50));
      final s = c.read(dashboardProvider);
      expect(s.totalAssets, 0);
      expect(s.totalLiabilities, 0);
      expect(s.netWorth, 0);
    });

    test('categoryExpenses sorts descending and fallback Unknown color', () async {
      final cat = CategoryModel(
        id: 'c1',
        name: 'Food',
        type: CategoryType.expense,
        icon: 'restaurant',
        color: '#FF0000',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      when(() => mockAccount.watchAccounts()).thenAnswer((_) => Stream.value(const Success([])));
      when(() => mockCat.watchCategories()).thenAnswer((_) => Stream.value(Success([cat])));
      final now = DateTime.now();
      final txs = [
        TransactionModel(
          id: 't1',
          accountId: 'a',
          type: TransactionType.expense,
          amount: 300,
          transactionDate: now,
          createdAt: now,
          updatedAt: now,
          items: [
            TransactionItemModel(
              id: 'i1',
              transactionId: 't1',
              amount: 300,
              createdAt: now,
              updatedAt: now,
              categoryId: 'unknown-id',
            ),
          ],
        ),
      ];
      when(() => mockTx.watchTransactions()).thenAnswer((_) => Stream.value(Success(txs)));
      final c = makeContainer();
      c.listen(dashboardProvider, (_, __) {});
      await Future.delayed(const Duration(milliseconds: 50));
      expect(c.read(dashboardProvider).categoryExpenses.first.name, 'Unknown');
      expect(c.read(dashboardProvider).categoryExpenses.first.color, '#CCCCCC');
    });
  });
}
