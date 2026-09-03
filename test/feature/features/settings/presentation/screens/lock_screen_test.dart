import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';
import 'package:poka_ce/features/settings/presentation/screens/lock_screen.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockAppLockController extends Notifier<AppLockState> with Mock implements AppLockController {
  final AppLockState initialState;
  MockAppLockController(this.initialState);

  @override
  AppLockState build() => initialState;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  GoRouter buildRouter() => GoRouter(
    initialLocation: '/lock',
    routes: [
      GoRoute(path: '/lock', builder: (_, __) => const LockScreen()),
      GoRoute(
        path: '/',
        builder: (_, __) => const Scaffold(body: Text('Home')),
      ),
    ],
  );

  Widget buildWidget(AppLockState state) {
    return ProviderScope(
      overrides: [
        appLockControllerProvider.overrideWith(() => MockAppLockController(state)),
      ],
      child: TranslationProvider(
        child: MaterialApp.router(
          routerConfig: buildRouter(),
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
        ),
      ),
    );
  }

  group('LockScreen', () {
    testWidgets('renders pin entry ui', (tester) async {
      await tester.pumpWidget(buildWidget(const AppLockState(isEnabled: true, isAuthenticated: false)));
      await tester.pumpAndSettle();

      expect(find.text('Enter PIN'), findsOneWidget);
      expect(find.text('Enter 6-digit PIN'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('typing digits fills pin and triggers verification', (tester) async {
      final controller = MockAppLockController(const AppLockState(isEnabled: true, isAuthenticated: false));
      when(() => controller.verifyPin(any())).thenAnswer((_) async => PinVerificationResult.wrongPin);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appLockControllerProvider.overrideWith(() => controller)],
          child: TranslationProvider(
            child: MaterialApp.router(
              routerConfig: buildRouter(),
              builder: (context, child) => FTheme(
                data: lightTheme,
                child: FToaster(child: child!),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      for (final digit in ['1', '2', '3', '4', '5', '6']) {
        await tester.tap(find.text(digit));
        await tester.pump(const Duration(milliseconds: 50));
      }
      await tester.pumpAndSettle();

      verify(() => controller.verifyPin('123456')).called(1);
      expect(find.text('Incorrect PIN'), findsOneWidget);
    });

    testWidgets('successful pin navigates home', (tester) async {
      final controller = MockAppLockController(const AppLockState(isEnabled: true, isAuthenticated: false));
      when(() => controller.verifyPin(any())).thenAnswer((_) async => PinVerificationResult.success);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appLockControllerProvider.overrideWith(() => controller)],
          child: TranslationProvider(
            child: MaterialApp.router(
              routerConfig: buildRouter(),
              builder: (context, child) => FTheme(
                data: lightTheme,
                child: FToaster(child: child!),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      for (final digit in ['9', '8', '7', '6', '5', '4']) {
        await tester.tap(find.text(digit));
        await tester.pump(const Duration(milliseconds: 50));
      }
      await tester.pumpAndSettle();

      verify(() => controller.verifyPin('987654')).called(1);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('backspace removes last digit', (tester) async {
      final controller = MockAppLockController(const AppLockState(isEnabled: true, isAuthenticated: false));
      when(() => controller.verifyPin(any())).thenAnswer((_) async => PinVerificationResult.wrongPin);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appLockControllerProvider.overrideWith(() => controller)],
          child: TranslationProvider(
            child: MaterialApp.router(
              routerConfig: buildRouter(),
              builder: (context, child) => FTheme(
                data: lightTheme,
                child: FToaster(child: child!),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.text('2'));
      await tester.pump(const Duration(milliseconds: 50));

      final backspaceFinder = find.byIcon(FPhosphorIcons.backspace);
      expect(backspaceFinder, findsOneWidget);
      await tester.tap(backspaceFinder);
      await tester.pumpAndSettle();

      // Remaining pin is '1'; verification never triggered.
      verifyNever(() => controller.verifyPin(any()));
    });

    testWidgets('lockout ignores key presses and shows countdown', (tester) async {
      final controller = MockAppLockController(
        AppLockState(
          isEnabled: true,
          isAuthenticated: false,
          lockoutUntil: DateTime.now().add(const Duration(minutes: 1)),
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appLockControllerProvider.overrideWith(() => controller)],
          child: TranslationProvider(
            child: MaterialApp.router(
              routerConfig: buildRouter(),
              builder: (context, child) => FTheme(
                data: lightTheme,
                child: FToaster(child: child!),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Try again in'), findsOneWidget);

      // Key presses are ignored during lockout.
      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();
      verifyNever(() => controller.verifyPin(any()));
    });
  });
}
