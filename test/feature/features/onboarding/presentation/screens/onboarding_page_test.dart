import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/data/settings_repository.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();

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

  Widget createWidgetUnderTest() {
    final fakeNotifier = FakeSettingsNotifier();

    return ProviderScope(
      overrides: [
        settingsProvider.overrideWith(() => fakeNotifier),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: const OnboardingPage(),
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
}
