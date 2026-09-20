import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/presentation/widgets/period/report_custom_range_dialog.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);

  testWidgets('ReportCustomRangeDialog renders calendar grid when opened', (tester) async {
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.toString().contains('overflowed')) return;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    final now = DateTime.now();
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showFDialog<void>(
                        context: context,
                        builder: (context, style, animation) =>
                            ReportCustomRangeDialog(initial: null, now: now, animation: animation),
                      );
                    },
                    child: const Text('Open Dialog'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    expect(find.byType(ReportCustomRangeDialog), findsOneWidget);
    expect(find.byType(FCalendar), findsOneWidget);
  });
}
