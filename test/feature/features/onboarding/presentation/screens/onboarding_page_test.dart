import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:poka_ce/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class FakeSettingsNotifier extends SettingsNotifier {
  String? selectedCurrencyId;

  @override
  SettingsState build() => const SettingsState();

  @override
  Future<void> setBaseCurrency(String currencyId) async {
    selectedCurrencyId = currencyId;
  }

  @override
  Future<List<CurrencyModel>> getAvailableCurrencies() async {
    return [
      const CurrencyModel(
        id: 'usd',
        code: 'USD',
        symbol: '\$',
        name: 'US Dollar',
        precision: 2,
      ),
    ];
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget createWidgetUnderTest({FakeSettingsNotifier? notifier}) {
    final fakeNotifier = notifier ?? FakeSettingsNotifier();
    final router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('Dashboard Page')),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        settingsProvider.overrideWith(() => fakeNotifier),
      ],
      child: TranslationProvider(
        child: MaterialApp.router(
          routerConfig: router,
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
        ),
      ),
    );
  }

  testWidgets('OnboardingPage renders correctly and shows currencies', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Choose Your Base Currency'), findsWidgets);
    expect(find.text('US Dollar'), findsOneWidget);
  });

  testWidgets('selecting currency and tapping continue calls setBaseCurrency', (tester) async {
    final notifier = FakeSettingsNotifier();
    await tester.pumpWidget(createWidgetUnderTest(notifier: notifier));
    await tester.pumpAndSettle();

    // Button is disabled when no currency is selected
    expect(tester.widget<FButton>(find.widgetWithText(FButton, t.onboarding.continueWithCurrency)).onPress, isNull);

    // Tap US Dollar
    await tester.tap(find.text('US Dollar'));
    await tester.pumpAndSettle();

    // Button is now enabled
    expect(tester.widget<FButton>(find.widgetWithText(FButton, t.onboarding.continueWithCurrency)).onPress, isNotNull);

    await tester.tap(find.widgetWithText(FButton, t.onboarding.continueWithCurrency));
    await tester.pumpAndSettle();

    expect(notifier.selectedCurrencyId, 'usd');
    expect(find.text('Dashboard Page'), findsOneWidget);
  });
}
