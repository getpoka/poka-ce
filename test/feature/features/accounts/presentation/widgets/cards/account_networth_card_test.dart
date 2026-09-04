import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_networth_card.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_sparkline.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget createWidgetUnderTest({
    double netWorth = 1000.0,
    double totalAssets = 1500.0,
    double totalLiabilities = 500.0,
    int activeAccountCount = 2,
    String currency = 'USD',
    bool isBalanceVisible = true,
    List<double>? sparklineData,
  }) {
    return ProviderScope(
      overrides: [
        balanceVisibilityProvider.overrideWith(() => _FakeBalanceVisibilityNotifier(initial: isBalanceVisible)),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier(currency)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: Scaffold(
            body: SingleChildScrollView(
              child: AccountNetworthCard(
                netWorth: netWorth,
                totalAssets: totalAssets,
                totalLiabilities: totalLiabilities,
                activeAccountCount: activeAccountCount,
                sparklineData: sparklineData,
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('AccountNetworthCard', () {
    testWidgets('displays correct text when visible', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          netWorth: 1234.56,
          totalAssets: 2000,
          totalLiabilities: 765.44,
          activeAccountCount: 3,
        ),
      );
      await tester.pump();

      expect(find.textContaining('USD'), findsWidgets);
      // NumberFormat will format with comma and 2 decimals for visible
      expect(find.textContaining('1,234'), findsWidgets);
      expect(find.textContaining('2,000'), findsWidgets);
      expect(find.text('3 accounts'), findsOneWidget);
      expect(find.text('Net Worth'), findsWidgets);
      expect(find.text('Assets'), findsWidgets);
      expect(find.text('Liabilities'), findsWidgets);
      expect(find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.eye), findsOneWidget);
    });

    testWidgets('obscures text when isBalanceVisible is false', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          netWorth: 1234.56,
          isBalanceVisible: false,
        ),
      );
      await tester.pump();

      expect(find.text('USD ••••••'), findsNWidgets(3)); // net worth, assets, liabilities
      // should not show raw formatted value
      expect(find.textContaining('1,234'), findsNothing);
      expect(
        find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.eyeClosed),
        findsOneWidget,
      );
    });

    testWidgets('calls toggle and changes icon when eye is tapped', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(),
      );
      await tester.pump();

      expect(find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.eye), findsOneWidget);

      await tester.tap(find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.eye));
      await tester.pump();

      // After tap, icon should change to eyeClosed via provider
      expect(
        find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.eyeClosed),
        findsOneWidget,
      );
      // amounts should now be obscured
      expect(find.text('USD ••••••'), findsNWidgets(3));
    });

    testWidgets('tapping eye when hidden makes visible again', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          netWorth: 500,
          isBalanceVisible: false,
        ),
      );
      await tester.pump();
      expect(
        find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.eyeClosed),
        findsOneWidget,
      );
      await tester.tap(find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.eyeClosed));
      await tester.pump();
      expect(find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.eye), findsOneWidget);
      expect(find.textContaining('500'), findsWidgets);
    });

    testWidgets('displays zero accounts and handles zero balances', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          netWorth: 0,
          totalAssets: 0,
          totalLiabilities: 0,
          activeAccountCount: 0,
        ),
      );
      await tester.pump();
      expect(find.text('0 accounts'), findsOneWidget);
      expect(find.textContaining('USD'), findsWidgets);
    });

    testWidgets('handles different currency and large numbers', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          netWorth: 1000000.5,
          totalAssets: 2000000,
          totalLiabilities: 999999.5,
          activeAccountCount: 10,
          currency: 'IDR',
        ),
      );
      await tester.pump();
      expect(find.textContaining('IDR'), findsWidgets);
      expect(find.text('10 accounts'), findsOneWidget);
    });

    testWidgets('renders pills and sub balances with icons', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      // wallet and bank icons in pills
      expect(find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.wallet), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.bank), findsOneWidget);
      // sub balance icons
      expect(
        find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.trendUp),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((w) => w is Icon && w.icon == FPhosphorIcons.trendDown),
        findsOneWidget,
      );
      // divider removed from UI
    });

    testWidgets('renders sparkline in background when sparklineData is provided', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          sparklineData: [1000, 1100, 1050, 1200, 1150, 1300, 1400],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PokaSparkline), findsOneWidget);
    });
  });
}

class _FakeBalanceVisibilityNotifier extends BalanceVisibility {
  _FakeBalanceVisibilityNotifier({required this.initial});

  final bool initial;

  @override
  bool build() => initial;

  @override
  void toggle() => state = !state;
}

class _FakeSettingsNotifier extends SettingsNotifier {
  final String currency;
  _FakeSettingsNotifier(this.currency);

  @override
  SettingsState build() {
    return SettingsState(
      settings: SettingsModel(
        themeMode: 'system',
        language: 'en',
        baseCurrency: CurrencyModel(
          id: '1',
          code: currency,
          symbol: currency,
          precision: 2,
          name: 'USD',
        ),
      ),
    );
  }
}
