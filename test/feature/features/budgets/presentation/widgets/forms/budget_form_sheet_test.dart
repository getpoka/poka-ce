import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_form_notifier.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';
import 'package:poka_ce/features/budgets/presentation/widgets/forms/budget_form_sheet.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockBudgetRepository extends Mock implements IBudgetRepository {}

class FakeBudgetModel extends Fake implements BudgetModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(FakeBudgetModel());
  });

  late MockBudgetRepository mockRepo;

  setUp(() {
    mockRepo = MockBudgetRepository();
    when(() => mockRepo.getBudgets()).thenAnswer((_) async => const Success([]));
    when(() => mockRepo.createBudget(any())).thenAnswer((_) async => const Success(null));
    when(() => mockRepo.updateBudget(any())).thenAnswer((_) async => const Success(null));
    when(() => mockRepo.deleteBudget(any())).thenAnswer((_) async => const Success(null));
  });

  List<AccountModel> sampleAccounts() => [
    AccountModel(
      id: 'a1',
      name: 'Wallet',
      type: AccountType.assets,
      balance: 100000,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
      color: '#10B981',
      icon: 'wallet',
    ),
  ];

  List<CategoryModel> sampleCategories() => [
    CategoryModel(
      id: 'c1',
      name: 'Food',
      type: CategoryType.expense,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
      color: '#EF4444',
      icon: 'utensils',
    ),
  ];

  BudgetModel sampleBudget() => BudgetModel(
    id: 'b1',
    name: 'Groceries',
    amount: 1000,
    period: BudgetPeriod.monthly,
    startDate: DateTime.utc(2024, 1, 1),
    resetDay: 1,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
    categoryId: 'c1',
  );

  Widget buildWidget({BudgetModel? initialBudget}) {
    return ProviderScope(
      overrides: [
        budgetRepositoryProvider.overrideWithValue(mockRepo),
        budgetListProvider.overrideWith(() => _FakeBudgetListNotifier(mockRepo)),
        dashboardProvider.overrideWith(
          () => _FakeDashboardNotifier(DashboardState(accounts: sampleAccounts(), isLoading: false)),
        ),
        regularAccountListProvider.overrideWith(
          (ref) => AsyncValue.data(AccountListState(accounts: sampleAccounts(), aggregates: [])),
        ),
        categoryListProvider.overrideWith(
          () => _FakeCategoryNotifier(sampleCategories()),
        ),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: SingleChildScrollView(child: BudgetFormSheet(initialBudget: initialBudget)),
          ),
        ),
      ),
    );
  }

  Widget buildWithState(BudgetFormState state, {BudgetModel? initialBudget}) {
    return ProviderScope(
      overrides: [
        budgetRepositoryProvider.overrideWithValue(mockRepo),
        dashboardProvider.overrideWith(
          () => _FakeDashboardNotifier(DashboardState(accounts: sampleAccounts(), isLoading: false)),
        ),
        regularAccountListProvider.overrideWith(
          (ref) => AsyncValue.data(AccountListState(accounts: sampleAccounts(), aggregates: [])),
        ),
        categoryListProvider.overrideWith(
          () => _FakeCategoryNotifier(sampleCategories()),
        ),
        budgetFormProvider.overrideWith(() => _FakeBudgetFormNotifier(state)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: SingleChildScrollView(child: BudgetFormSheet(initialBudget: initialBudget)),
          ),
        ),
      ),
    );
  }

  group('BudgetFormSheet', () {
    testWidgets('renders create mode with New Budget title', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      expect(find.text('New Budget'), findsOneWidget);
      expect(find.text('Budget name'), findsOneWidget);
      expect(find.text('Spending limit'), findsOneWidget);
      expect(find.text('Period'), findsOneWidget);
      expect(find.text('Create Budget'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);
      expect(find.text('Monthly'), findsOneWidget);
      expect(find.text('Yearly'), findsOneWidget);
      expect(find.text('Custom'), findsOneWidget);
    });

    testWidgets('renders edit mode with Edit Budget', (tester) async {
      final budget = sampleBudget();
      await tester.pumpWidget(buildWidget(initialBudget: budget));
      await tester.pumpAndSettle();
      expect(find.text('Edit Budget'), findsOneWidget);
      expect(find.text('Save Changes'), findsOneWidget);
    });

    testWidgets('monthly period shows Reset day field', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      // Default period is monthly
      expect(find.text('Reset day (1–31)'), findsOneWidget);
      // Tap yearly -> reset day should disappear
      await tester.tap(find.text('Yearly'));
      await tester.pumpAndSettle();
      expect(find.text('Reset day (1–31)'), findsNothing);
    });

    testWidgets('custom period shows End Date field', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Custom'));
      await tester.pumpAndSettle();
      expect(find.text('End Date'), findsOneWidget);
      // Monthly reset should be hidden
      expect(find.text('Reset day (1–31)'), findsNothing);
    });

    testWidgets('weekly period hides reset and end date', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();
      expect(find.text('Reset day (1–31)'), findsNothing);
      expect(find.text('End Date'), findsNothing);
    });

    testWidgets('period switching cycles correctly', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      for (final p in ['Weekly', 'Monthly', 'Yearly', 'Custom']) {
        await tester.tap(find.text(p));
        await tester.pumpAndSettle();
        expect(find.text(p), findsOneWidget);
      }
    });

    testWidgets('shows loading indicator when isSaving', (tester) async {
      await tester.pumpWidget(buildWithState(const BudgetFormState(isSaving: true, name: 'Test', amount: 100)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(FCircularProgress), findsOneWidget);
      expect(find.text('Create Budget'), findsNothing);
    });

    testWidgets('scope section shows Any category / Any account by default', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      expect(find.text('Any category'), findsOneWidget);
      expect(find.text('Any account'), findsOneWidget);
      expect(find.text('Scope'), findsOneWidget);
    });

    testWidgets('init with initialBudget pre-fills fields', (tester) async {
      final budget = sampleBudget();
      await tester.pumpWidget(buildWidget(initialBudget: budget));
      await tester.pumpAndSettle();
      expect(find.text('Groceries'), findsOneWidget);
      expect(find.text('1000'), findsOneWidget);
      // Scope should show selected category name
      expect(find.text('Food'), findsOneWidget);
    });

    testWidgets('budget with custom end date shows formatted date', (tester) async {
      final budget = sampleBudget().copyWith(
        period: BudgetPeriod.custom,
        endDate: DateTime.utc(2025, 12, 31),
        resetDay: null,
      );
      await tester.pumpWidget(
        buildWithState(
          BudgetFormState(
            initialBudget: budget,
            name: 'Custom Budget',
            amount: 500,
            period: BudgetPeriod.custom,
            endDate: DateTime.utc(2025, 12, 31),
          ),
          initialBudget: budget,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('End Date'), findsOneWidget);
      expect(find.textContaining('Dec'), findsOneWidget);
    });

    test('validation empty name prevents create call via notifier', () async {
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(budgetFormProvider.notifier);
      notifier.setName('   ');
      notifier.setAmount(100);
      await notifier.save();
      expect(container.read(budgetFormProvider).error, 'Name cannot be empty');
      verifyNever(() => mockRepo.createBudget(any()));
    });

    test('validation amount <=0 prevents create', () async {
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(budgetFormProvider.notifier);
      notifier.setName('Test');
      notifier.setAmount(0);
      await notifier.save();
      expect(container.read(budgetFormProvider).error, 'Amount must be greater than 0');
    });

    test('save create success calls createBudget', () async {
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(budgetFormProvider.notifier);
      notifier.setName('New Budget');
      notifier.setAmount(500);
      await notifier.save();

      expect(container.read(budgetFormProvider).isSuccess, true);
      verify(() => mockRepo.createBudget(any())).called(1);
    });

    test('save create failure shows error', () async {
      when(() => mockRepo.createBudget(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(budgetFormProvider.notifier);
      notifier.setName('New Budget');
      notifier.setAmount(500);
      await notifier.save();
      expect(container.read(budgetFormProvider).error, 'fail');
      expect(container.read(budgetFormProvider).isSaving, false);
    });

    test('save update success calls updateBudget', () async {
      final budget = sampleBudget();
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(budgetFormProvider.notifier);
      notifier.init(budget);
      notifier.setName('Updated');
      await notifier.save();

      verify(() => mockRepo.updateBudget(any())).called(1);
      expect(container.read(budgetFormProvider).isSuccess, true);
    });

    test('save update failure shows error', () async {
      when(() => mockRepo.updateBudget(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('db')));
      final budget = sampleBudget();
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(budgetFormProvider.notifier);
      notifier.init(budget);
      notifier.setName('Updated');
      await notifier.save();
      expect(container.read(budgetFormProvider).error, 'db');
    });

    test('monthly resetDay saving logic uses default 1 when null', () async {
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(budgetFormProvider.notifier);
      notifier.setName('Monthly Test');
      notifier.setAmount(1000);
      notifier.setPeriod(BudgetPeriod.monthly);
      notifier.setResetDay(null);
      await notifier.save();

      // Should have called createBudget with resetDay 1 (checked via captured model)
      final captured = verify(() => mockRepo.createBudget(captureAny())).captured.first as BudgetModel;
      expect(captured.resetDay, 1);
    });

    test('yearly period save has no resetDay and no endDate', () async {
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mockRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(budgetFormProvider.notifier);
      notifier.setName('Yearly');
      notifier.setAmount(2000);
      notifier.setPeriod(BudgetPeriod.yearly);
      await notifier.save();

      final captured = verify(() => mockRepo.createBudget(captureAny())).captured.first as BudgetModel;
      expect(captured.resetDay, isNull);
      expect(captured.endDate, isNull);
    });

    testWidgets('show helper creates sheet with New Budget', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetRepositoryProvider.overrideWithValue(mockRepo),
            dashboardProvider.overrideWith(
              () => _FakeDashboardNotifier(DashboardState(accounts: sampleAccounts(), isLoading: false)),
            ),
            categoryListProvider.overrideWith(
              () => _FakeCategoryNotifier(sampleCategories()),
            ),
          ],
          child: TranslationProvider(
            child: MaterialApp(
              builder: (context, child) => FTheme(data: lightTheme, child: child!),
              home: Builder(
                builder: (context) => Scaffold(
                  body: ElevatedButton(onPressed: () => BudgetFormSheet.show(context), child: const Text('OpenBudget')),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('OpenBudget'));
      await tester.pumpAndSettle();
      expect(find.text('New Budget'), findsOneWidget);
    });

    testWidgets('show helper with initialBudget shows Edit Budget', (tester) async {
      final budget = sampleBudget();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetRepositoryProvider.overrideWithValue(mockRepo),
            dashboardProvider.overrideWith(
              () => _FakeDashboardNotifier(DashboardState(accounts: sampleAccounts(), isLoading: false)),
            ),
            categoryListProvider.overrideWith(
              () => _FakeCategoryNotifier(sampleCategories()),
            ),
          ],
          child: TranslationProvider(
            child: MaterialApp(
              builder: (context, child) => FTheme(data: lightTheme, child: child!),
              home: Builder(
                builder: (context) => Scaffold(
                  body: ElevatedButton(
                    onPressed: () => BudgetFormSheet.show(context, initialBudget: budget),
                    child: const Text('OpenBudgetEdit'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('OpenBudgetEdit'));
      await tester.pumpAndSettle();
      expect(find.text('Edit Budget'), findsOneWidget);
    });

    testWidgets('name field updates via EditableText', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      final firstField = find.byType(EditableText).first;
      await tester.enterText(firstField, 'Entertainment');
      await tester.pumpAndSettle();
      expect(find.text('Entertainment'), findsOneWidget);
    });
  });
}

class _FakeDashboardNotifier extends DashboardNotifier {
  final DashboardState _state;
  _FakeDashboardNotifier(this._state);
  @override
  DashboardState build() => _state;
  @override
  Future<void> refresh() async {}
}

class _FakeCategoryNotifier extends CategoryListNotifier {
  final List<CategoryModel> _categories;
  _FakeCategoryNotifier(this._categories);
  @override
  Future<List<CategoryModel>> build() => Future.value(_categories);
  @override
  Future<void> refresh() async {}
}

class _FakeBudgetListNotifier extends BudgetListNotifier {
  _FakeBudgetListNotifier(this.repo);
  final MockBudgetRepository repo;
  @override
  Future<List<BudgetModel>> build() async {
    final result = await repo.getBudgets();
    return switch (result) {
      Success(value: final budgets) => budgets,
      ErrorResult(error: final failure) => throw Exception(failure.message),
    };
  }

  @override
  Future<void> deleteBudget(String id) async {
    await repo.deleteBudget(id);
  }
}

class _FakeBudgetFormNotifier extends BudgetFormNotifier {
  final BudgetFormState _state;
  _FakeBudgetFormNotifier(this._state);
  @override
  BudgetFormState build() => _state;
  @override
  void init(
    BudgetModel? budget, {
    String? initialName,
    int? initialAmount,
    BudgetPeriod? initialPeriod,
    String? initialCategoryId,
    String? initialAccountId,
  }) {}
  @override
  Future<void> save() async {}
}
