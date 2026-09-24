import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_aggregate.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/domain/i_goal_repository.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_form_sheet.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockGoalRepository extends Mock implements IGoalRepository {}

class FakeGoalModel extends Fake implements GoalModel {}

class _FakeAccountListNotifier extends AccountListNotifier {
  _FakeAccountListNotifier(this._state);
  final AccountListState _state;
  @override
  Stream<AccountListState> build() => Stream.value(_state);
}

class _TestSettingsNotifier extends SettingsNotifier {
  _TestSettingsNotifier(this._initialState);
  final SettingsState _initialState;

  @override
  SettingsState build() => _initialState;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(FakeGoalModel());
  });

  late MockGoalRepository mockGoalRepo;

  setUp(() {
    mockGoalRepo = MockGoalRepository();
    when(() => mockGoalRepo.createGoal(any())).thenAnswer((_) async => const Success(null));
    when(() => mockGoalRepo.updateGoal(any())).thenAnswer((_) async => const Success(null));
  });

  final now = DateTime.utc(2024, 1, 1);

  List<AccountModel> sampleAccounts() => [
    AccountModel(
      id: 'acc-1',
      name: 'Main Bank',
      type: AccountType.assets,
      balance: 100000,
      initialBalance: 100000,
      createdAt: now,
      updatedAt: now,
    ),
  ];

  AccountListState sampleAccountListState() {
    final accs = sampleAccounts();
    return AccountListState(
      accounts: accs,
      aggregates: [AccountAggregate(account: accs.first, pockets: const [])],
    );
  }

  Widget createWidgetUnderTest({GoalModel? initialGoal, int precision = 0}) {
    final settingsState = SettingsState(
      settings: SettingsModel(
        themeMode: 'system',
        baseCurrency: CurrencyModel(id: 'c1', code: 'USD', name: 'US Dollar', symbol: r'$', precision: precision),
      ),
    );

    return ProviderScope(
      overrides: [
        goalRepositoryProvider.overrideWithValue(mockGoalRepo),
        accountListProvider.overrideWith(() => _FakeAccountListNotifier(sampleAccountListState())),
        settingsProvider.overrideWith(() => _TestSettingsNotifier(settingsState)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(body: GoalFormSheet(initialGoal: initialGoal)),
        ),
      ),
    );
  }

  group('GoalFormSheet Minor Currency Units', () {
    testWidgets('pre-fills target amount using toMajorExpression with precision 2', (tester) async {
      final goal = GoalModel(
        id: 'g1',
        name: 'New Laptop',
        targetAmount: 500000, // 5,000.00 in precision 2
        accountId: 'pocket-1',
        parentAccountId: 'acc-1',
        createdAt: now,
        updatedAt: now,
      );

      await tester.pumpWidget(createWidgetUnderTest(initialGoal: goal, precision: 2));
      await tester.pumpAndSettle();

      // EditableText for amount should display '5000'
      expect(find.text('5000'), findsOneWidget);
      expect(find.text('New Laptop'), findsOneWidget);
    });

    testWidgets('saves target amount converted to minor units with precision 2', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(precision: 2));
      await tester.pumpAndSettle();

      // Enter name
      final fields = find.byType(EditableText);
      await tester.enterText(fields.first, 'Vacation');
      // Enter amount: '250.50' -> 25050 minor units
      await tester.enterText(fields.at(1), '250.50');
      await tester.pumpAndSettle();

      // Tap Create Goal
      await tester.ensureVisible(find.text('Create Goal'));
      await tester.tap(find.text('Create Goal'));
      await tester.pumpAndSettle();

      final captured = verify(() => mockGoalRepo.createGoal(captureAny())).captured;
      expect(captured.isNotEmpty, isTrue);
      final createdGoal = captured.first as GoalModel;
      expect(createdGoal.name, 'Vacation');
      expect(createdGoal.targetAmount, 25050);
    });

    testWidgets('fails validation when target amount resolves to 0 minor units', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(precision: 2));
      await tester.pumpAndSettle();

      final fields = find.byType(EditableText);
      await tester.enterText(fields.first, 'Vacation');
      await tester.enterText(fields.at(1), '0');
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Create Goal'));
      await tester.tap(find.text('Create Goal'));
      await tester.pumpAndSettle();

      verifyNever(() => mockGoalRepo.createGoal(any()));
      expect(find.text('Target amount must be greater than 0'), findsOneWidget);
    });
  });
}
