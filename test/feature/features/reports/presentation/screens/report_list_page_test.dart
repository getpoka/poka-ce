import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/screens/report_list_page.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/data/excel_export_service.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockExcelExportService extends Mock implements ExcelExportService {}

class _FakeReportNotifier extends ReportNotifier {
  _FakeReportNotifier(this._state);
  final ReportState _state;
  @override
  ReportState build() => _state;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);

  late MockExcelExportService mockExcelExportService;

  setUp(() {
    mockExcelExportService = MockExcelExportService();
  });

  Widget buildTestableWidget(ReportState reportState) {
    return ProviderScope(
      overrides: [
        reportProvider.overrideWith(() => _FakeReportNotifier(reportState)),
        excelExportServiceProvider.overrideWithValue(mockExcelExportService),
        balanceVisibilityProvider.overrideWithValue(true),
        settingsProvider.overrideWithValue(const SettingsState(isLoading: false)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: const ReportListPage(),
        ),
      ),
    );
  }

  group('ReportListPage', () {
    testWidgets('shows loading indicator when state is loading', (tester) async {
      const state = ReportState(isLoading: true);
      await tester.pumpWidget(buildTestableWidget(state));
      await tester.pump();

      expect(find.byType(FCircularProgress), findsOneWidget);
    });

    testWidgets('renders header, export button, and tabs when loaded', (tester) async {
      const state = ReportState(
        isLoading: false,
        data: ReportData(
          summary: ReportSummary(totalIncome: 1000, totalExpense: 400),
        ),
      );

      await tester.pumpWidget(buildTestableWidget(state));
      await tester.pumpAndSettle();

      expect(find.text('Reports'), findsOneWidget);
      expect(find.text('Financial Overview'), findsOneWidget);
      expect(find.byKey(const Key('report-privacy-toggle-button')), findsOneWidget);
      expect(find.byKey(const Key('report-export-excel-button')), findsOneWidget);
      expect(find.text('Cashflow'), findsOneWidget);
      expect(find.text('Budgets & Goals'), findsOneWidget);
    });

    testWidgets('renders privacy toggle button and toggles visibility state', (tester) async {
      const state = ReportState(
        isLoading: false,
        data: ReportData(),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            reportProvider.overrideWith(() => _FakeReportNotifier(state)),
            excelExportServiceProvider.overrideWithValue(mockExcelExportService),
            settingsProvider.overrideWithValue(const SettingsState(isLoading: false)),
          ],
          child: TranslationProvider(
            child: MaterialApp(
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: const [
                ...FLocalizations.localizationsDelegates,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) => FTheme(
                data: lightTheme,
                child: FToaster(child: child!),
              ),
              home: const ReportListPage(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final toggleButton = find.byKey(const Key('report-privacy-toggle-button'));
      expect(toggleButton, findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.eye), findsOneWidget);

      await tester.tap(toggleButton);
      await tester.pumpAndSettle();
      expect(find.byIcon(FPhosphorIcons.eyeSlash), findsOneWidget);

      await tester.tap(toggleButton);
      await tester.pumpAndSettle();
      expect(find.byIcon(FPhosphorIcons.eye), findsOneWidget);
    });

    testWidgets('triggers exportAndShare and shows success toast when export button tapped', (tester) async {
      when(() => mockExcelExportService.exportAndShare(sharePositionOrigin: any(named: 'sharePositionOrigin')))
          .thenAnswer((_) async => Success(File('test.xlsx')));

      const state = ReportState(
        isLoading: false,
        data: ReportData(),
      );

      await tester.pumpWidget(buildTestableWidget(state));
      await tester.pumpAndSettle();

      final exportButton = find.byKey(const Key('report-export-excel-button'));
      expect(exportButton, findsOneWidget);

      await tester.tap(exportButton);
      await tester.pumpAndSettle();

      verify(() => mockExcelExportService.exportAndShare(sharePositionOrigin: any(named: 'sharePositionOrigin')))
          .called(1);
      expect(find.text('Excel exported successfully'), findsOneWidget);
    });

    testWidgets('shows error toast when export fails', (tester) async {
      when(() => mockExcelExportService.exportAndShare(sharePositionOrigin: any(named: 'sharePositionOrigin')))
          .thenAnswer((_) async => const ErrorResult(UnexpectedFailure('error')));

      const state = ReportState(
        isLoading: false,
        data: ReportData(),
      );

      await tester.pumpWidget(buildTestableWidget(state));
      await tester.pumpAndSettle();

      final exportButton = find.byKey(const Key('report-export-excel-button'));
      await tester.tap(exportButton);
      await tester.pumpAndSettle();

      verify(() => mockExcelExportService.exportAndShare(sharePositionOrigin: any(named: 'sharePositionOrigin')))
          .called(1);
      expect(find.text('Failed to export Excel file'), findsOneWidget);
    });
  });
}
