import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/reconcile_account_balance_use_case.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_reconcile_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockReconcileAccountBalanceUseCase extends Mock implements ReconcileAccountBalanceUseCase {}

class FakeAccountModel extends Fake implements AccountModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockReconcileAccountBalanceUseCase mockReconcile;

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(FakeAccountModel());
  });

  setUp(() {
    mockReconcile = MockReconcileAccountBalanceUseCase();
  });

  final testPocket = AccountModel(
    id: 'pocket-1',
    name: 'BCA Utama',
    type: AccountType.assets,
    balance: 300000,
    initialBalance: 300000,
    parentId: 'root-1',
    isDefault: true,
    createdAt: DateTime.utc(2026, 9, 20),
    updatedAt: DateTime.utc(2026, 9, 20),
  );

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [reconcileAccountBalanceUseCaseProvider.overrideWithValue(mockReconcile)],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(body: AccountReconcileSheet(account: testPocket, currentBalance: 300000)),
        ),
      ),
    );
  }

  testWidgets('renders account name and current balance in Poka', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('BCA Utama'), findsOneWidget);
    expect(find.text(t.accounts.currentBalanceInPoka), findsOneWidget);
    expect(find.text(t.accounts.actualBalance), findsOneWidget);
    expect(find.text(t.accounts.saveAdjustment), findsOneWidget);
  });

  testWidgets('triggers reconcile use case on save', (tester) async {
    when(
      () => mockReconcile.execute(
        account: any(named: 'account'),
        currentBalance: any(named: 'currentBalance'),
        targetBalance: any(named: 'targetBalance'),
        note: any(named: 'note'),
      ),
    ).thenAnswer((_) async => Success(testPocket));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Tap Save Adjustment
    await tester.tap(find.text(t.accounts.saveAdjustment));
    await tester.pumpAndSettle();

    verify(() => mockReconcile.execute(account: testPocket, currentBalance: 300000, targetBalance: 300000, note: null))
        .called(1);
  });
}
