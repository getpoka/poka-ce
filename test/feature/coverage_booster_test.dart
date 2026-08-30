import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/daos/accounts_dao.dart';
import 'package:poka_ce/database/daos/categories_dao.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/accounts/data/account_repository_impl.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/data/category_repository_impl.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/dashboard/domain/services/dashboard_analytics_service.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/theme/theme.dart';

class MockAccountsDao extends Mock implements AccountsDao {}

class MockCategoriesDao extends Mock implements CategoriesDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('failure coverage', () {
    test('ValidationFailure and UnexpectedFailure store message', () {
      final v = ValidationFailure('bad');
      final u = UnexpectedFailure('oops');
      final d = DatabaseFailure('db');
      expect(v.message, 'bad');
      expect(u.message, 'oops');
      expect(d.message, 'db');
      // also check sealed type
      expect(v, isA<Failure>());
      expect(u, isA<Failure>());
    });
  });

  group('datetime_utils', () {
    test('nowUtc returns utc', () {
      final now = DateTimeUtils.nowUtc();
      expect(now.isUtc, true);
    });
  });

  group('AccountRepository watch error', () {
    test('watchAccounts yields Failure on exception', () async {
      final mockDao = MockAccountsDao();
      when(() => mockDao.watchAllAccounts()).thenAnswer((_) => Stream.error(Exception('boom')));
      final repo = AccountRepositoryImpl(mockDao);
      final result = await repo.watchAccounts().first;
      expect(result.isFailure, true);
    });

    test('watchAccounts success emits', () async {
      final db = AppDatabase(connection: NativeDatabase.memory());
      addTearDown(() async => db.close());
      final repo = AccountRepositoryImpl(db.accountsDao);
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: const Value('a1'),
              name: 'W',
              type: AccountType.assets,
              balance: const Value(0),
            ),
          );
      final result = await repo.watchAccounts().first;
      expect(result.isSuccess, true);
    });

    test('getAccounts error returns Failure', () async {
      final mockDao = MockAccountsDao();
      when(() => mockDao.getAllAccounts()).thenThrow(Exception('fail'));
      final repo = AccountRepositoryImpl(mockDao);
      final res = await repo.getAccounts();
      expect(res.isFailure, true);
    });

    test('getAccountById not found returns Failure', () async {
      final db = AppDatabase(connection: NativeDatabase.memory());
      addTearDown(() async => db.close());
      final repo = AccountRepositoryImpl(db.accountsDao);
      final res = await repo.getAccountById('missing');
      expect(res.isFailure, true);
    });

    test('createAccount with restricted categories', () async {
      final db = AppDatabase(connection: NativeDatabase.memory());
      addTearDown(() async => db.close());
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('cat1'), name: 'Food', type: CategoryType.expense));
      final repo = AccountRepositoryImpl(db.accountsDao);
      final model = AccountModel(
        id: 'acc1',
        name: 'W',
        type: AccountType.assets,
        balance: 0,
        createdAt: DateTimeUtils.nowUtc(),
        updatedAt: DateTimeUtils.nowUtc(),
        restrictedCategoryIds: ['cat1'],
      );
      final res = await repo.createAccount(model);
      expect(res.isSuccess, true);
    });
  });

  group('CategoryRepository watch error', () {
    test('watchCategories yields Failure on exception', () async {
      final mockDao = MockCategoriesDao();
      when(() => mockDao.watchAllCategories()).thenAnswer((_) => Stream.error(Exception('boom')));
      final repo = CategoryRepositoryImpl(mockDao);
      final result = await repo.watchCategories().first;
      expect(result.isFailure, true);
    });

    test('watchCategories success emits', () async {
      final db = AppDatabase(connection: NativeDatabase.memory());
      addTearDown(() async => db.close());
      final repo = CategoryRepositoryImpl(db.categoriesDao);
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('c1'), name: 'Food', type: CategoryType.expense));
      final result = await repo.watchCategories().first;
      expect(result.isSuccess, true);
    });

    test('getCategories error', () async {
      final mockDao = MockCategoriesDao();
      when(() => mockDao.getAllCategories()).thenThrow(Exception('fail'));
      final repo = CategoryRepositoryImpl(mockDao);
      final res = await repo.getCategories();
      expect(res.isFailure, true);
    });
  });

  group('DashboardAnalyticsService edge', () {
    test('calculateAccountMetrics with mixed balances and inactive', () {
      final accounts = [
        AccountModel(
          id: '1',
          name: 'A',
          type: AccountType.assets,
          balance: 100,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        AccountModel(
          id: '2',
          name: 'B',
          type: AccountType.assets,
          balance: -50,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        AccountModel(
          id: '3',
          name: 'C',
          type: AccountType.assets,
          balance: 0,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        AccountModel(
          id: '4',
          name: 'D',
          type: AccountType.assets,
          balance: 999,
          isActive: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
      final res = DashboardAnalyticsService.calculateAccountMetrics(accounts);
      expect(res.activeAccountCount, 3);
      expect(res.netWorth, 50);
      expect(res.totalAssets, 100);
      expect(res.totalLiabilities, 50);
    });

    test('calculateTransactionMetrics zero spending branch', () {
      final res = DashboardAnalyticsService.calculateTransactionMetrics([], []);
      expect(res.maxDailySpending, 0);
      expect(res.normalizedDailySpending, List.filled(7, 0));
    });

    test('calculateTransactionMetrics unknown category fallback and allocation', () {
      final now = DateTime.now().toUtc();
      final tx = TransactionModel(
        id: '1',
        accountId: 'acc1',
        type: TransactionType.expense,
        amount: 100,
        transactionDate: now,
        createdAt: now,
        updatedAt: now,
        items: [
          TransactionItemModel(
            id: 'i1',
            transactionId: '1',
            categoryId: 'missing',
            allocation: TransactionAllocation.need,
            amount: 60,
            createdAt: now,
            updatedAt: now,
          ),
          TransactionItemModel(
            id: 'i2',
            transactionId: '1',
            categoryId: 'missing2',
            allocation: TransactionAllocation.want,
            amount: 40,
            createdAt: now,
            updatedAt: now,
          ),
        ],
      );
      final res = DashboardAnalyticsService.calculateTransactionMetrics([tx], []);
      expect(res.categoryExpenses.first.name, 'Unknown');
      expect(res.budgetAllocations[TransactionAllocation.need], 60);
      expect(res.totalExpense, 100);
    });
  });

  group('PokaHeader back pop', () {
    testWidgets('back tap pops when canPop true', (tester) async {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const Scaffold(body: PokaHeader(title: 'Home')),
          ),
          GoRoute(
            path: '/next',
            builder: (_, __) => const Scaffold(body: PokaHeader(title: 'Next', showBack: true)),
          ),
        ],
      );
      await tester.pumpWidget(
        MaterialApp.router(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          routerConfig: router,
        ),
      );
      await tester.pumpAndSettle();
      // navigate to /next via push so canPop true
      router.push('/next');
      await tester.pumpAndSettle();
      expect(find.text('Next'), findsOneWidget);
      // tap back - should pop and hit lines 59-61
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('PokaHeader suffixes displayed in nested header', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const Scaffold(
            body: PokaHeader(title: 'T', showBack: true, suffixes: [Text('Suf')]),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Suf'), findsOneWidget);
    });
  });
}

extension _ResultX<T, E> on dynamic {
  bool get isSuccess => toString().contains('Success');
  bool get isFailure => toString().contains('Error');
}
