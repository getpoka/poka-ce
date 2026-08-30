import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import "package:poka_ce/features/accounts/domain/account_model.dart";
import "package:poka_ce/features/categories/domain/category_model.dart";
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/dashboard/domain/services/dashboard_analytics_service.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/error/failure.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class MockCategoryRepository extends Mock implements ICategoryRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAccountRepository mockAccountRepo;
  late MockTransactionRepository mockTransactionRepo;
  late MockCategoryRepository mockCategoryRepo;

  setUp(() {
    mockAccountRepo = MockAccountRepository();
    mockTransactionRepo = MockTransactionRepository();
    mockCategoryRepo = MockCategoryRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        accountRepositoryProvider.overrideWithValue(mockAccountRepo),
        transactionRepositoryProvider.overrideWithValue(mockTransactionRepo),
        categoryRepositoryProvider.overrideWithValue(mockCategoryRepo),
      ],
    );
    // Listen to keep it alive and trigger updates
    container.listen(dashboardProvider, (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  Future<void> waitForLoad(ProviderContainer container) async {
    await Future.delayed(const Duration(milliseconds: 50));
  }

  group('DashboardNotifier', () {
    test('initial state is loading and empty', () async {
      when(() => mockAccountRepo.watchAccounts()).thenAnswer((_) => Stream.value(const Success(<AccountModel>[])));
      when(() => mockTransactionRepo.watchTransactions())
          .thenAnswer((_) => Stream.value(const Success(<TransactionModel>[])));
      when(() => mockCategoryRepo.watchCategories()).thenAnswer((_) => Stream.value(const Success(<CategoryModel>[])));

      final container = createContainer();
      final state = container.read(dashboardProvider);

      expect(state.isLoading, true);
      expect(state.accounts, isEmpty);
      expect(state.recentTransactions, isEmpty);
      expect(state.netWorth, 0.0);
      expect(state.totalAssets, 0.0);
      expect(state.totalLiabilities, 0.0);
      expect(state.activeAccountCount, 0);

      // Wait for microtask to finish before teardown
      await waitForLoad(container);
    });

    test('loads data and calculates correctly', () async {
      final accounts = [
        AccountModel(
          id: '1',
          name: 'Cash',
          type: AccountType.assets,
          balance: 1000,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        AccountModel(
          id: '2',
          name: 'Credit Card',
          type: AccountType.liability,
          balance: -500,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        AccountModel(
          id: '3',
          name: 'Old Bank',
          type: AccountType.assets,
          balance: 2000,
          isActive: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ), // inactive
      ];

      final transactions = [
        TransactionModel(
          id: '1',
          accountId: '1',
          type: TransactionType.income,
          amount: 500,
          transactionDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      when(() => mockAccountRepo.watchAccounts()).thenAnswer((_) => Stream.value(Success(accounts)));
      when(() => mockTransactionRepo.watchTransactions()).thenAnswer((_) => Stream.value(Success(transactions)));
      when(() => mockCategoryRepo.watchCategories()).thenAnswer((_) => Stream.value(const Success(<CategoryModel>[])));

      final container = createContainer();
      final notifier = container.read(dashboardProvider.notifier);

      // wait for the microtask in build to finish
      await waitForLoad(container);

      final state = container.read(dashboardProvider);

      expect(state.isLoading, false);
      expect(state.accounts, equals(accounts));
      expect(state.recentTransactions, equals(transactions));

      expect(state.netWorth, 500.0);
      expect(state.totalAssets, 1000.0);
      expect(state.totalLiabilities, 500.0);
      expect(state.activeAccountCount, 2);
    });

    test('handles errors from repositories gracefully', () async {
      when(() => mockAccountRepo.watchAccounts())
          .thenAnswer((_) => Stream.value(ErrorResult(DatabaseFailure('DB Error'))));
      when(() => mockTransactionRepo.watchTransactions())
          .thenAnswer((_) => Stream.value(const Success(<TransactionModel>[])));
      when(() => mockCategoryRepo.watchCategories()).thenAnswer((_) => Stream.value(const Success(<CategoryModel>[])));

      final container = createContainer();

      await waitForLoad(container);

      final state = container.read(dashboardProvider);

      expect(state.isLoading, false);
      expect(state.accounts, isEmpty);
      expect(state.recentTransactions, isEmpty);
    });

    test('refresh calls loadData again', () async {
      when(() => mockAccountRepo.watchAccounts()).thenAnswer((_) => Stream.value(const Success(<AccountModel>[])));
      when(() => mockTransactionRepo.watchTransactions())
          .thenAnswer((_) => Stream.value(const Success(<TransactionModel>[])));
      when(() => mockCategoryRepo.watchCategories()).thenAnswer((_) => Stream.value(const Success(<CategoryModel>[])));

      final container = createContainer();
      await waitForLoad(container); // Initial load

      final newAccounts = [
        AccountModel(
          id: '4',
          name: 'Bonus',
          type: AccountType.assets,
          balance: 5000,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
      when(() => mockAccountRepo.watchAccounts()).thenAnswer((_) => Stream.value(Success(newAccounts)));

      await container.read(dashboardProvider.notifier).refresh();
      await Future.delayed(const Duration(milliseconds: 10)); // Allow microtask to start
      await waitForLoad(container);

      final state = container.read(dashboardProvider);
      expect(state.accounts, equals(newAccounts));
      expect(state.netWorth, 5000.0);
    });

    test('balance metrics handle mixed active/inactive', () async {
      when(() => mockAccountRepo.watchAccounts()).thenAnswer((_) => Stream.value(const Success(<AccountModel>[])));
      when(() => mockTransactionRepo.watchTransactions())
          .thenAnswer((_) => Stream.value(const Success(<TransactionModel>[])));
      when(() => mockCategoryRepo.watchCategories()).thenAnswer((_) => Stream.value(const Success(<CategoryModel>[])));
      final container = createContainer();
      await waitForLoad(container);
      var state = container.read(dashboardProvider);
      expect(state.totalAssets, 0);
      expect(state.totalLiabilities, 0);
    });
  });
}
