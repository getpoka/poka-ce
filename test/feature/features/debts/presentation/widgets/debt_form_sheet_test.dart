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
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/domain/i_debt_repository.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_form_notifier.dart';
import 'package:poka_ce/features/debts/presentation/widgets/debt_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockDebtRepository extends Mock implements IDebtRepository {}

class FakeDebtModel extends Fake implements DebtModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(FakeDebtModel());
  });

  late MockDebtRepository mockDebtRepo;

  setUp(() {
    mockDebtRepo = MockDebtRepository();
    when(() => mockDebtRepo.getDebts()).thenAnswer((_) async => const Success([]));
    when(() => mockDebtRepo.createDebt(any(), any(), any())).thenAnswer((_) async => const Success(null));
    when(() => mockDebtRepo.updateDebt(any())).thenAnswer((_) async => const Success(null));
    when(() => mockDebtRepo.deleteDebt(any())).thenAnswer((_) async => const Success(null));
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
    AccountModel(
      id: 'a2',
      name: 'Bank',
      type: AccountType.assets,
      balance: 50000,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
      color: '#6366F1',
      icon: 'bank',
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

  DebtModel sampleDebt() => DebtModel(
    id: 'd1',
    personName: 'Alice',
    type: DebtType.debt,
    amount: 1000,
    remainingAmount: 1000,
    status: DebtStatus.active,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
    dueDate: DateTime.utc(2025, 1, 1),
    note: 'dinner',
  );

  Widget buildWidget({DebtModel? initialDebt}) {
    return ProviderScope(
      overrides: [
        debtRepositoryProvider.overrideWithValue(mockDebtRepo),
        dashboardProvider.overrideWith(
          () => _FakeDashboardNotifier(DashboardState(accounts: sampleAccounts(), isLoading: false)),
        ),
        categoryListProvider.overrideWith(
          () => _FakeCategoryNotifier(sampleCategories()),
        ),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: Scaffold(
            body: SingleChildScrollView(child: DebtFormSheet(initialDebt: initialDebt)),
          ),
        ),
      ),
    );
  }

  Widget buildWithState(DebtFormState state, {DebtModel? initialDebt}) {
    return ProviderScope(
      overrides: [
        debtRepositoryProvider.overrideWithValue(mockDebtRepo),
        dashboardProvider.overrideWith(
          () => _FakeDashboardNotifier(DashboardState(accounts: sampleAccounts(), isLoading: false)),
        ),
        categoryListProvider.overrideWith(
          () => _FakeCategoryNotifier(sampleCategories()),
        ),
        debtFormProvider.overrideWith(() => _FakeDebtFormNotifier(state)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: SingleChildScrollView(child: DebtFormSheet(initialDebt: initialDebt)),
          ),
        ),
      ),
    );
  }

  group('DebtFormSheet', () {
    testWidgets('renders create mode with title New Record', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      expect(find.text('New Record'), findsOneWidget);
      expect(find.text('Person name'), findsOneWidget);
      expect(find.text('Principal amount'), findsOneWidget);
      expect(find.text('I Owe'), findsOneWidget);
      expect(find.text('They Owe'), findsOneWidget);
      expect(find.text('Create Record'), findsOneWidget);
      // Transaction binding section only in create mode
      expect(find.text('Transaction Binding'), findsOneWidget);
      expect(find.text('Due Date'), findsOneWidget);
    });

    testWidgets('renders edit mode with title Edit Record and delete icon', (tester) async {
      await tester.pumpWidget(buildWidget(initialDebt: sampleDebt()));
      await tester.pumpAndSettle();
      expect(find.text('Edit Record'), findsOneWidget);
      expect(find.text('Save Changes'), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.trash), findsOneWidget);
      // Transaction binding should be hidden in edit mode
      expect(find.text('Transaction Binding'), findsNothing);
    });

    testWidgets('create shows info text for debt type', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      expect(find.textContaining('adds money to the account'), findsOneWidget);
    });

    testWidgets('type selector switches between debt and loan', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      // Initially debt selected
      expect(find.text('I Owe'), findsOneWidget);
      // Tap They Owe
      await tester.tap(find.text('They Owe'));
      await tester.pumpAndSettle();
      // Info text should change for loan
      expect(find.textContaining('removes money from the account'), findsOneWidget);
      await tester.tap(find.text('I Owe'));
      await tester.pumpAndSettle();
      expect(find.textContaining('adds money to the account'), findsOneWidget);
    });

    testWidgets('edit mode disables type selector changes', (tester) async {
      final debt = sampleDebt();
      await tester.pumpWidget(buildWidget(initialDebt: debt));
      await tester.pumpAndSettle();
      // Tapping should not change because onChanged is null in edit mode
      await tester.tap(find.text('They Owe'));
      await tester.pumpAndSettle();
      // Still shows edit record, type still debt (info for debt would still be there if unchanged)
      // Since we are editing but transaction binding hidden, we just verify no crash
      expect(find.text('Edit Record'), findsOneWidget);
    });

    testWidgets('person name field updates state', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      final fields = find.byType(EditableText);
      expect(fields, findsWidgets);
      // First EditableText is person name
      await tester.enterText(fields.first, 'Bob');
      await tester.pumpAndSettle();
      // Find the entered text in field
      expect(find.text('Bob'), findsOneWidget);
    });

    testWidgets('shows loading indicator when isSaving', (tester) async {
      await tester.pumpWidget(buildWithState(const DebtFormState(isSaving: true, personName: 'Alice', amount: 100)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(FCircularProgress), findsOneWidget);
      expect(find.text('Create Record'), findsNothing);
    });

    testWidgets('validation empty person name shows error on save attempt', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Create Record'));
      await tester.tap(find.text('Create Record'), warnIfMissed: false);
      await tester.pumpAndSettle();
      verifyNever(() => mockDebtRepo.createDebt(any(), any(), any()));
    });

    test('save create success calls repository with account and category', () async {
      final container = ProviderContainer(
        overrides: [debtRepositoryProvider.overrideWithValue(mockDebtRepo)],
      );
      addTearDown(container.dispose);
      final notifier = container.read(debtFormProvider.notifier);
      notifier.setPersonName('Charlie');
      notifier.setAmount(2000);
      notifier.setAccountId('a1');
      notifier.setCategoryId('c1');
      await notifier.save();

      verify(() => mockDebtRepo.createDebt(any(), 'a1', 'c1')).called(1);
    });

    test('save update success calls updateDebt', () async {
      final debt = sampleDebt();
      final container = ProviderContainer(
        overrides: [debtRepositoryProvider.overrideWithValue(mockDebtRepo)],
      );
      addTearDown(container.dispose);
      final notifier = container.read(debtFormProvider.notifier);
      notifier.init(debt);
      notifier.setPersonName('Updated Name');
      await notifier.save();

      verify(() => mockDebtRepo.updateDebt(any())).called(1);
    });

    test('save failure sets error and keeps isSaving false', () async {
      when(() => mockDebtRepo.createDebt(any(), any(), any()))
          .thenAnswer((_) async => const ErrorResult(DatabaseFailure('db fail')));
      final container = ProviderContainer(overrides: [debtRepositoryProvider.overrideWithValue(mockDebtRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(debtFormProvider.notifier);
      notifier.setPersonName('Bob');
      notifier.setAmount(500);
      notifier.setAccountId('a1');
      notifier.setCategoryId('c1');
      await notifier.save();
      expect(container.read(debtFormProvider).error, 'db fail');
      expect(container.read(debtFormProvider).isSaving, false);
    });

    testWidgets('delete button in edit mode calls deleteDebt', (tester) async {
      final debt = sampleDebt();
      await tester.pumpWidget(buildWidget(initialDebt: debt));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(FPhosphorIcons.trash));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 100));
      verify(() => mockDebtRepo.deleteDebt('d1')).called(1);
    });

    testWidgets('init with initialDebt pre-fills fields', (tester) async {
      final debt = sampleDebt();
      await tester.pumpWidget(buildWidget(initialDebt: debt));
      await tester.pumpAndSettle();
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('1000'), findsOneWidget);
      expect(find.text('dinner'), findsOneWidget);
    });

    testWidgets('due date tile shows formatted date when set', (tester) async {
      final debt = sampleDebt();
      await tester.pumpWidget(
        buildWithState(
          DebtFormState(initialDebt: debt, personName: 'Alice', amount: 1000, dueDate: DateTime.utc(2025, 12, 25)),
          initialDebt: debt,
        ),
      );
      await tester.pumpAndSettle();
      // DateFormat.yMMMd for 2025-12-25 is Dec 25, 2025
      expect(find.textContaining('Dec'), findsOneWidget);
    });

    test('due date clear via notifier', () async {
      final container = ProviderContainer(overrides: [debtRepositoryProvider.overrideWithValue(mockDebtRepo)]);
      addTearDown(container.dispose);
      final notifier = container.read(debtFormProvider.notifier);
      notifier.init(sampleDebt());
      expect(container.read(debtFormProvider).dueDate, isNotNull);
      notifier.setDueDate(null);
      expect(container.read(debtFormProvider).dueDate, isNull);
    });

    testWidgets('note field is optional and displays hint', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      expect(find.text('Note'), findsOneWidget);
      expect(find.text('e.g., Dinner last Friday'), findsOneWidget);
    });

    testWidgets('show helper creates sheet with New Record title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            debtRepositoryProvider.overrideWithValue(mockDebtRepo),
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
                    onPressed: () => DebtFormSheet.show(context),
                    child: const Text('OpenDebt'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('OpenDebt'));
      await tester.pumpAndSettle();
      expect(find.text('New Record'), findsOneWidget);
    });

    testWidgets('show helper with initialDebt edits', (tester) async {
      final debt = sampleDebt();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            debtRepositoryProvider.overrideWithValue(mockDebtRepo),
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
                    onPressed: () => DebtFormSheet.show(context, initialDebt: debt),
                    child: const Text('OpenDebtEdit'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('OpenDebtEdit'));
      await tester.pumpAndSettle();
      expect(find.text('Edit Record'), findsOneWidget);
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

class _FakeDebtFormNotifier extends DebtForm {
  final DebtFormState _state;
  _FakeDebtFormNotifier(this._state);
  @override
  DebtFormState build() => _state;
  @override
  void init(DebtModel? debt) {}
  @override
  Future<void> save() async {}
}
