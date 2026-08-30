import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/sections/dashboard_recent_transactions.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockAccountRepo extends Mock implements IAccountRepository {}

class MockCategoryRepo extends Mock implements ICategoryRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  setUp(() {
    // silence overflow errors in FTileGroup
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.toString().contains('overflowed') || details.toString().contains('RenderFlex')) return;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);
  });

  final now = DateTime(2026, 8, 22, 10, 0);
  final yesterday = DateTime(2026, 8, 21, 9, 0);

  TransactionModel tx({
    required String id,
    required DateTime date,
    required TransactionType type,
    required int amount,
    String accountId = 'acc1',
    String? categoryId,
    String? note,
  }) {
    return TransactionModel(
      id: id,
      accountId: accountId,
      type: type,
      amount: amount,
      transactionDate: date,
      note: note,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      items: categoryId == null && type != TransactionType.transfer
          ? []
          : [
              TransactionItemModel(
                id: 'item-$id',
                transactionId: id,
                categoryId: categoryId,
                amount: amount,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            ],
    );
  }

  final catFood = CategoryModel(
    id: 'cat1',
    name: 'Food',
    type: CategoryType.expense,
    color: '#FF0000',
    icon: 'utensils',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  final catSalary = CategoryModel(
    id: 'cat2',
    name: 'Salary',
    type: CategoryType.income,
    color: '#00FF00',
    icon: 'wallet',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  final accWallet = AccountModel(
    id: 'acc1',
    name: 'Wallet',
    type: AccountType.assets,
    balance: 0,
    color: '#0000FF',
    icon: 'wallet',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  final accBank = AccountModel(
    id: 'acc2',
    name: 'Bank',
    type: AccountType.assets,
    balance: 0,
    color: '#FF00FF',
    icon: 'bank',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  Widget createWidget({
    required List<TransactionModel> transactions,
    bool isBalanceVisible = true,
    List<CategoryModel> categories = const [],
    List<AccountModel> accounts = const [],
  }) {
    final mockAccount = MockAccountRepo();
    final mockCat = MockCategoryRepo();
    when(() => mockAccount.watchAccounts()).thenAnswer((_) => Stream.value(Success(accounts)));
    when(() => mockCat.watchCategories()).thenAnswer((_) => Stream.value(Success(categories)));
    // also stub other methods that might be called
    when(() => mockAccount.getAccounts()).thenAnswer((_) async => Success(accounts));
    when(() => mockCat.getCategories()).thenAnswer((_) async => Success(categories));
    when(() => mockCat.getActiveCategories()).thenAnswer((_) async => Success(categories));

    return ProviderScope(
      overrides: [
        balanceVisibilityProvider.overrideWith(() => _FakeBalanceNotifier(isBalanceVisible)),
        accountRepositoryProvider.overrideWithValue(mockAccount),
        categoryRepositoryProvider.overrideWithValue(mockCat),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: SingleChildScrollView(
              child: DashboardRecentTransactions(transactions: transactions),
            ),
          ),
        ),
      ),
    );
  }

  group('DashboardRecentTransactions coverage', () {
    testWidgets('hits categories/accounts fold with data', (tester) async {
      final transactions = [tx(id: '1', date: now, type: TransactionType.expense, amount: 5000, categoryId: 'cat1')];
      await tester.pumpWidget(createWidget(transactions: transactions, categories: [catFood], accounts: [accWallet]));
      await tester.pumpAndSettle();
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Wallet'), findsOneWidget);
    });

    testWidgets('hits empty items branch and unknown account fallback', (tester) async {
      // items empty => firstItemCategoryId null, category null, account null
      final transactions = [tx(id: '1', date: now, type: TransactionType.expense, amount: 100, categoryId: null)];
      await tester.pumpWidget(createWidget(transactions: transactions, categories: [], accounts: []));
      await tester.pumpAndSettle();
      expect(find.text('Uncategorized'), findsOneWidget);
      expect(find.text('Unknown'), findsOneWidget);
    });

    testWidgets('transfer category fallback shows Transfer label', (tester) async {
      final transactions = [tx(id: '1', date: now, type: TransactionType.transfer, amount: 1000, categoryId: null)];
      await tester.pumpWidget(createWidget(transactions: transactions));
      await tester.pumpAndSettle();
      expect(find.text('Transfer'), findsOneWidget);
    });

    testWidgets('renders both income and expense transactions flat', (tester) async {
      final transactions = [
        tx(id: '1', date: now, type: TransactionType.income, amount: 2000000, categoryId: 'cat2'),
        tx(id: '2', date: now, type: TransactionType.expense, amount: 500000, categoryId: 'cat1'),
      ];
      await tester.pumpWidget(
        createWidget(transactions: transactions, categories: [catFood, catSalary], accounts: [accWallet]),
      );
      await tester.pumpAndSettle();
      expect(find.text('Salary'), findsOneWidget);
      expect(find.text('Food'), findsOneWidget);
    });

    testWidgets('renders income transaction without expense', (tester) async {
      final transactions = [tx(id: '1', date: now, type: TransactionType.income, amount: 1000, categoryId: 'cat2')];
      await tester.pumpWidget(createWidget(transactions: transactions, categories: [catSalary], accounts: [accWallet]));
      await tester.pumpAndSettle();
      expect(find.text('Salary'), findsOneWidget);
      expect(find.text('Food'), findsNothing);
    });

    testWidgets('renders expense transaction without income', (tester) async {
      final transactions = [tx(id: '1', date: now, type: TransactionType.expense, amount: 3000, categoryId: 'cat1')];
      await tester.pumpWidget(createWidget(transactions: transactions, categories: [catFood], accounts: [accWallet]));
      await tester.pumpAndSettle();
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Salary'), findsNothing);
    });

    testWidgets('renders multiple date transactions in flat list', (tester) async {
      final transactions = [
        tx(id: '1', date: now, type: TransactionType.expense, amount: 100, categoryId: 'cat1'),
        tx(id: '2', date: yesterday, type: TransactionType.income, amount: 200, categoryId: 'cat2'),
      ];
      await tester.pumpWidget(
        createWidget(transactions: transactions, categories: [catFood, catSalary], accounts: [accWallet]),
      );
      await tester.pumpAndSettle();
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Salary'), findsOneWidget);
    });

    testWidgets('category lookup missing still renders Uncategorized', (tester) async {
      // categoryId points to non-existent category in map
      final transactions = [tx(id: '1', date: now, type: TransactionType.expense, amount: 100, categoryId: 'missing')];
      await tester.pumpWidget(createWidget(transactions: transactions, categories: [catFood], accounts: [accWallet]));
      await tester.pumpAndSettle();
      expect(find.text('Uncategorized'), findsOneWidget);
    });

    testWidgets('account lookup hits second account', (tester) async {
      final transactions = [
        tx(id: '1', date: now, type: TransactionType.expense, amount: 100, categoryId: 'cat1', accountId: 'acc2'),
      ];
      await tester.pumpWidget(
        createWidget(transactions: transactions, categories: [catFood], accounts: [accWallet, accBank]),
      );
      await tester.pumpAndSettle();
      expect(find.text('Bank'), findsOneWidget);
    });

    testWidgets('isFirst/isLast tile flags do not crash with single item group', (tester) async {
      final transactions = [tx(id: '1', date: now, type: TransactionType.income, amount: 100, categoryId: 'cat2')];
      await tester.pumpWidget(createWidget(transactions: transactions, categories: [catSalary], accounts: [accWallet]));
      await tester.pumpAndSettle();
      expect(find.text('Salary'), findsOneWidget);
    });
  });
}

class _FakeBalanceNotifier extends BalanceVisibility {
  final bool _initial;
  _FakeBalanceNotifier(this._initial);
  @override
  bool build() => _initial;
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();
  @override
  Future<void> setThemeMode(String mode) async {}
  @override
  Future<void> setLanguage(String language) async {}
  @override
  Future<void> setBaseCurrency(String currencyId) async {}
  @override
  Future<List<CurrencyModel>> getAvailableCurrencies() async => [];
}
