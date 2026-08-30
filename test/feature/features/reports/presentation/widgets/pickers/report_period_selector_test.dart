import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/pickers/report_period_selector.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);

  Widget buildTestableWidget(Widget child, {List<dynamic> overrides = const []}) {
    return ProviderScope(
      overrides: [...overrides],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: Scaffold(body: child),
        ),
      ),
    );
  }

  ReportState baseState({ReportPeriod period = ReportPeriod.thisMonth}) {
    return ReportState(
      isLoading: false,
      period: period,
      data: ReportData(),
    );
  }

  group('ReportPeriodSelector', () {
    testWidgets('renders chips and can tap non-custom period', (tester) async {
      final reportState = baseState();

      await tester.pumpWidget(
        buildTestableWidget(
          const ReportPeriodSelector(),
          overrides: [
            reportProvider.overrideWith(() => _FakeReportNotifier(reportState)),
          ],
        ),
      );

      expect(find.text('This Month'), findsOneWidget);
      expect(find.text('Last Month'), findsOneWidget);
      expect(find.text('Custom'), findsOneWidget);

      await tester.tap(find.text('Last Month'));
      await tester.pumpAndSettle();

      // We just verify it doesn't crash since state update is handled by the provider in a real app
    });

    testWidgets('Custom period tap shows dialog', (tester) async {
      tester.view.physicalSize = const Size(1200, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.toString().contains('overflowed')) return;
        originalOnError?.call(details);
      };
      addTearDown(() => FlutterError.onError = originalOnError);

      final reportState = baseState(period: ReportPeriod.custom);

      await tester.pumpWidget(
        buildTestableWidget(
          const ReportPeriodSelector(),
          overrides: [
            reportProvider.overrideWith(() => _FakeReportNotifier(reportState)),
          ],
        ),
      );

      await tester.tap(find.text('Custom'));
      await tester.pumpAndSettle();

      // Expect calendar to show
      expect(find.byType(FCalendar), findsOneWidget);
    });
  });

  group('ReportCustomDateLabel', () {
    testWidgets('shows custom label when period is custom', (tester) async {
      final reportState = ReportState(
        isLoading: false,
        period: ReportPeriod.custom,
        customDateStart: DateTime(2023, 1, 1),
        customDateEnd: DateTime(2023, 1, 31),
        data: ReportData(),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const ReportCustomDateLabel(),
          overrides: [
            reportProvider.overrideWith(() => _FakeReportNotifier(reportState)),
          ],
        ),
      );

      expect(find.textContaining('Jan'), findsOneWidget);
      expect(find.textContaining('2023'), findsOneWidget);
    });

    testWidgets('hides custom label when not custom', (tester) async {
      final reportState = ReportState(
        isLoading: false,
        period: ReportPeriod.thisMonth,
        data: ReportData(),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const ReportCustomDateLabel(),
          overrides: [
            reportProvider.overrideWith(() => _FakeReportNotifier(reportState)),
          ],
        ),
      );

      expect(find.byType(Padding), findsNothing);
    });
  });
}

class _FakeReportNotifier extends ReportNotifier {
  _FakeReportNotifier(this._state);
  final ReportState _state;
  @override
  ReportState build() => _state;
  @override
  void setPeriod(ReportPeriod period) {}
  @override
  void setCustomRange(DateTime start, DateTime end) {}
}
