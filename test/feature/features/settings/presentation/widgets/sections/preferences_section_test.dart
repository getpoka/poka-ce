import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/multi_currency_provider.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/preferences_section.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockTransactionRepository extends Mock implements ITransactionRepository {}

class _FakeSettingsNotifier extends SettingsNotifier {
  _FakeSettingsNotifier([SettingsState? state]) : _initial = state ?? const SettingsState();
  final SettingsState _initial;

  @override
  SettingsState build() => _initial;

  @override
  Future<List<CurrencyModel>> getAvailableCurrencies() async => [];
}

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget createWidget({
    required List<TransactionModel> transactions,
    bool isMultiCurrency = false,
    required ITransactionRepository txRepo,
    LockedCurrencyTapHandler? lockedCurrencyTapHandler,
  }) {
    return ProviderScope(
      overrides: [
        isMultiCurrencyProvider.overrideWithValue(isMultiCurrency),
        if (lockedCurrencyTapHandler != null)
          lockedCurrencyTapHandlerProvider.overrideWithValue(lockedCurrencyTapHandler),
        recentTransactionsStreamProvider.overrideWith((ref) => Stream.value(transactions)),
        transactionRepositoryProvider.overrideWithValue(txRepo),
        settingsProvider.overrideWith(
          () => _FakeSettingsNotifier(
            SettingsState(
              settings: SettingsModel(
                themeMode: 'system',
                baseCurrency: CurrencyModel(id: 'curr-1', code: 'USD', name: 'US Dollar', symbol: '\$', precision: 2),
              ),
            ),
          ),
        ),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: const Scaffold(body: SingleChildScrollView(child: PreferencesSection())),
        ),
      ),
    );
  }

  testWidgets('PreferencesSection allows changing currency when no transactions exist', (tester) async {
    final mockRepo = MockTransactionRepository();
    when(() => mockRepo.getTransactions()).thenAnswer((_) async => const Success([]));

    await tester.pumpWidget(createWidget(transactions: [], txRepo: mockRepo));
    await tester.pumpAndSettle();

    expect(find.text('Base Currency'), findsOneWidget);
    expect(find.byIcon(FPhosphorIcons.lock), findsNothing);
  });

  testWidgets('PreferencesSection disables currency and shows toast on tap when transactions exist', (tester) async {
    final mockRepo = MockTransactionRepository();
    final sampleTx = TransactionModel(
      id: 'tx-1',
      accountId: 'acc-1',
      type: TransactionType.expense,
      amount: 1000,
      transactionDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    when(() => mockRepo.getTransactions()).thenAnswer((_) async => Success([sampleTx]));

    await tester.pumpWidget(createWidget(transactions: [sampleTx], txRepo: mockRepo));
    await tester.pumpAndSettle();

    // Verify lock icon is rendered
    expect(find.byIcon(FPhosphorIcons.lock), findsOneWidget);

    // Tap on currency setting
    await tester.tap(find.text('Base Currency'));
    await tester.pump();

    // Verify toast is displayed
    expect(
      find.text(
        'Currency cannot be changed after transactions are recorded. Please reset data if you wish to change it.',
      ),
      findsOneWidget,
    );

    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('PreferencesSection invokes lockedCurrencyTapHandler when locked and tapped', (tester) async {
    final mockRepo = MockTransactionRepository();
    final sampleTx = TransactionModel(
      id: 'tx-1',
      accountId: 'acc-1',
      type: TransactionType.expense,
      amount: 1000,
      transactionDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    when(() => mockRepo.getTransactions()).thenAnswer((_) async => Success([sampleTx]));

    bool customHandlerCalled = false;
    await tester.pumpWidget(
      createWidget(
        transactions: [sampleTx],
        txRepo: mockRepo,
        lockedCurrencyTapHandler: (context) {
          customHandlerCalled = true;
        },
      ),
    );
    await tester.pumpAndSettle();

    // Verify lock icon is rendered
    expect(find.byIcon(FPhosphorIcons.lock), findsOneWidget);

    // Tap on currency setting
    await tester.tap(find.text('Base Currency'));
    await tester.pump();

    // Verify custom handler is called instead of toast
    expect(customHandlerCalled, isTrue);
    expect(
      find.text(
        'Currency cannot be changed after transactions are recorded. Please reset data if you wish to change it.',
      ),
      findsNothing,
    );

    await tester.pump(const Duration(milliseconds: 100));
  });
}
