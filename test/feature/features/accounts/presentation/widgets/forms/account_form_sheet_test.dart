import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/create_account_use_case.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/update_account_use_case.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_form_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockCreateAccountUseCase extends Mock implements CreateAccountUseCase {}

class MockUpdateAccountUseCase extends Mock implements UpdateAccountUseCase {}

class FakeAccountModel extends Fake implements AccountModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(FakeAccountModel());
    registerFallbackValue(AccountType.assets);
  });

  late MockAccountRepository mockAccountRepo;
  late MockCreateAccountUseCase mockCreate;
  late MockUpdateAccountUseCase mockUpdate;

  setUp(() {
    mockAccountRepo = MockAccountRepository();
    mockCreate = MockCreateAccountUseCase();
    mockUpdate = MockUpdateAccountUseCase();

    when(() => mockAccountRepo.getAccounts()).thenAnswer((_) async => const Success([]));
  });

  Widget createWidgetUnderTest({AccountModel? initialAccount, String? parentAccountId}) {
    return ProviderScope(
      overrides: [
        accountRepositoryProvider.overrideWithValue(mockAccountRepo),
        createAccountUseCaseProvider.overrideWithValue(mockCreate),
        updateAccountUseCaseProvider.overrideWithValue(mockUpdate),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: AccountFormSheet(initialAccount: initialAccount, parentAccountId: parentAccountId),
          ),
        ),
      ),
    );
  }

  group('AccountFormSheet', () {
    testWidgets('renders fields and tabs correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Add Account'), findsOneWidget);
      expect(find.text('Assets'), findsOneWidget);
      expect(find.text('Liability'), findsOneWidget);
      expect(find.text('Goal'), findsNothing, reason: 'Goal tab should not be present');

      expect(find.text('Account Name'), findsOneWidget);
      expect(find.text('Initial Balance'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('shows validation error when name is empty and save is tapped', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Name cannot be empty'), findsOneWidget);
    });

    testWidgets('creates account when form is filled', (tester) async {
      when(
        () => mockCreate.execute(
          name: any(named: 'name'),
          type: any(named: 'type'),
          balance: any(named: 'balance'),
          icon: any(named: 'icon'),
          color: any(named: 'color'),
          parentId: any(named: 'parentId'),
          isActive: any(named: 'isActive'),
        ),
      ).thenAnswer((_) async => Success(FakeAccountModel()));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Enter name
      await tester.enterText(find.byType(EditableText).first, 'Main Wallet');
      // Enter balance
      await tester.enterText(find.byType(EditableText).last, '1000');

      await tester.pumpAndSettle();

      // Tap Save
      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle(); // Start save process

      verify(
        () => mockCreate.execute(
          name: 'Main Wallet',
          type: AccountType.assets,
          balance: 1000,
          icon: null,
          color: null,
          parentId: null,
          isActive: true,
        ),
      ).called(1);
    });

    testWidgets('changes account type when liability tab is tapped', (tester) async {
      when(
        () => mockCreate.execute(
          name: any(named: 'name'),
          type: any(named: 'type'),
          balance: any(named: 'balance'),
          icon: any(named: 'icon'),
          color: any(named: 'color'),
          parentId: any(named: 'parentId'),
          isActive: any(named: 'isActive'),
        ),
      ).thenAnswer((_) async => Success(FakeAccountModel()));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Tap liability tab
      await tester.tap(find.text('Liability'));
      await tester.pumpAndSettle();

      // Enter name
      await tester.enterText(find.byType(EditableText).first, 'Credit Card');
      await tester.pumpAndSettle();

      // Tap Save
      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle(); // Start save process

      verify(
        () => mockCreate.execute(
          name: 'Credit Card',
          type: AccountType.liability, // Assuming tab switch changes type
          balance: 0,
          icon: null,
          color: null,
          parentId: null,
          isActive: true,
        ),
      ).called(1);
    });

    testWidgets('renders pocket form without Initial Balance and without Tabs when parentAccountId is provided', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(parentAccountId: 'parent-123'));
      await tester.pumpAndSettle();

      expect(find.text('Add Pocket'), findsOneWidget);
      expect(find.text('Add Account'), findsNothing);
      expect(find.text('Assets'), findsNothing);
      expect(find.text('Liability'), findsNothing);
      expect(find.text('Pocket Name'), findsOneWidget);
      expect(find.text('Initial Balance'), findsNothing);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('creates pocket with balance 0 when saved', (tester) async {
      when(
        () => mockCreate.execute(
          name: any(named: 'name'),
          type: any(named: 'type'),
          balance: any(named: 'balance'),
          icon: any(named: 'icon'),
          color: any(named: 'color'),
          parentId: any(named: 'parentId'),
          isActive: any(named: 'isActive'),
        ),
      ).thenAnswer((_) async => Success(FakeAccountModel()));

      await tester.pumpWidget(createWidgetUnderTest(parentAccountId: 'parent-123'));
      await tester.pumpAndSettle();

      // Enter pocket name (only 1 EditableText in pocket form)
      await tester.enterText(find.byType(EditableText).first, 'Groceries');
      await tester.pumpAndSettle();

      // Tap Save
      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      verify(
        () => mockCreate.execute(
          name: 'Groceries',
          type: AccountType.assets,
          balance: 0,
          icon: null,
          color: null,
          parentId: 'parent-123',
          isActive: true,
        ),
      ).called(1);
    });
  });
}
