import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/sections/dashboard_recent_transactions.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';

class MockAccountRepo extends Mock implements IAccountRepository {}

class MockCategoryRepo extends Mock implements ICategoryRepository {}

class FakeDashboardNotifier extends DashboardNotifier {
  final DashboardState _initialState;
  FakeDashboardNotifier(this._initialState);
  @override
  DashboardState build() => _initialState;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget createWidgetUnderTest({
    required List<TransactionModel> transactions,
    bool isBalanceVisible = true,
  }) {
    final mockAccount = MockAccountRepo();
    final mockCat = MockCategoryRepo();
    // return empty for lookups
    when(() => mockAccount.watchAccounts())
        .thenAnswer((_) => Stream.value(const Success<List<AccountModel>, Failure>([])));
    when(() => mockCat.watchCategories())
        .thenAnswer((_) => Stream.value(const Success<List<CategoryModel>, Failure>([])));
    when(() => mockAccount.getAccounts()).thenAnswer((_) async => const Success<List<AccountModel>, Failure>([]));
    when(() => mockCat.getCategories()).thenAnswer((_) async => const Success<List<CategoryModel>, Failure>([]));
    when(() => mockCat.getActiveCategories()).thenAnswer((_) async => const Success<List<CategoryModel>, Failure>([]));
    return ProviderScope(
      overrides: [
        balanceVisibilityProvider.overrideWith(() => _FakeBalanceNotifier(isBalanceVisible)),
        accountRepositoryProvider.overrideWithValue(mockAccount),
        categoryRepositoryProvider.overrideWithValue(mockCat),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
        dashboardProvider.overrideWith(
          () => FakeDashboardNotifier(
            DashboardState(
              recentTransactions: transactions,
            ),
          ),
        ),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: Scaffold(
            body: SingleChildScrollView(
              child: DashboardRecentTransactions(
                transactions: transactions,
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('DashboardRecentTransactions', () {
    testWidgets('shows No recent transactions when empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(transactions: []));
      await tester.pumpAndSettle();
      expect(find.text('No recent transactions'), findsOneWidget);
    });

    testWidgets('shows transactions list when populated', (tester) async {
      final transactions = [
        TransactionModel(
          id: '1',
          accountId: '1',
          type: TransactionType.income,
          amount: 5000,
          transactionDate: DateTime(2026, 8, 22),
          note: 'Salary',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        TransactionModel(
          id: '2',
          accountId: '1',
          type: TransactionType.expense,
          amount: 200,
          transactionDate: DateTime(2026, 8, 21),
          note: 'Food',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      await tester.pumpWidget(createWidgetUnderTest(transactions: transactions));
      await tester.pumpAndSettle();

      expect(find.text('RECENT TRANSACTIONS'), findsOneWidget);
      expect(find.text('Salary'), findsOneWidget);
      expect(find.text('Food'), findsOneWidget);
    });

    testWidgets('obscures amounts when isBalanceVisible is false', (tester) async {
      final transactions = [
        TransactionModel(
          id: '1',
          accountId: '1',
          type: TransactionType.income,
          amount: 5000,
          transactionDate: DateTime(2026, 8, 22),
          note: 'Salary',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      await tester.pumpWidget(
        createWidgetUnderTest(
          transactions: transactions,
          isBalanceVisible: false,
        ),
      );
      await tester.pumpAndSettle();

      // When obscured, amounts show ••••••, not raw value
      expect(find.textContaining('••••••'), findsWidgets);
    });
  });
}

class _FakeBalanceNotifier extends BalanceVisibility {
  final bool _initial;
  _FakeBalanceNotifier(this._initial);
  @override
  bool build() => _initial;
  void toggle() => state = !state;
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() {
    return const SettingsState();
  }

  @override
  Future<void> setThemeMode(String mode) async {}

  @override
  Future<void> setLanguage(String language) async {}

  @override
  Future<void> setBaseCurrency(String currencyId) async {}

  @override
  Future<List<CurrencyModel>> getAvailableCurrencies() async => [];
}
