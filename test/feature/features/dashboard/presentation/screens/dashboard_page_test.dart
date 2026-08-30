import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences prefs;
  setUp(() async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });
  Widget createWidgetUnderTest({
    DashboardState dashboardState = const DashboardState(),
  }) {
    return TranslationProvider(
      child: ProviderScope(
        overrides: [
          dashboardProvider.overrideWith(() => _FakeDashboardNotifier(dashboardState)),
          settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: MaterialApp(
          theme: ThemeData(),
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: const DashboardPage(),
        ),
      ),
    );
  }

  group('DashboardPage', () {
    testWidgets('shows CircularProgressIndicator when loading and no accounts', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          dashboardState: const DashboardState(isLoading: true, accounts: []),
        ),
      );

      expect(find.byType(FCircularProgress), findsOneWidget);
    });

    testWidgets('shows dashboard content when loaded', (tester) async {
      tester.view.physicalSize = const Size(900, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.toString().contains('overflowed')) return;
        originalOnError?.call(details);
      };
      addTearDown(() => FlutterError.onError = originalOnError);
      await tester.pumpWidget(
        createWidgetUnderTest(
          dashboardState: const DashboardState(
            isLoading: false,
            accounts: [],
            recentTransactions: [],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('My Finances'), findsOneWidget);
      expect(find.text('Net Worth'), findsWidgets);
      expect(find.text('Assets'), findsWidgets);
      expect(find.text('Liabilities'), findsWidgets);
    });
  });
}

class _FakeDashboardNotifier extends Notifier<DashboardState> implements DashboardNotifier {
  final DashboardState _initialState;

  _FakeDashboardNotifier(this._initialState);

  @override
  DashboardState build() {
    return _initialState;
  }

  @override
  Future<void> refresh() async {
    // do nothing in test
  }
}

class _FakeSettingsNotifier extends Notifier<SettingsState> implements SettingsNotifier {
  @override
  SettingsState build() {
    return const SettingsState();
  }

  @override
  Future<void> setThemeMode(String mode) async {}

  @override
  Future<void> setBaseCurrency(String currencyId) async {}

  @override
  Future<void> setLanguage(String language) async {}

  @override
  Future<void> setNumberFormat(String numberFormat) async {}

  @override
  Future<List<CurrencyModel>> getAvailableCurrencies() async => [];
}
