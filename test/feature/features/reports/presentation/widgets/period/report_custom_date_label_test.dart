import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/period/report_custom_date_label.dart';
import 'package:poka_ce/theme/theme.dart';

class _FakeReportNotifier extends ReportNotifier {
  _FakeReportNotifier(this._state);
  final ReportState _state;
  @override
  ReportState build() => _state;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildHarness(ReportState state) {
    return ProviderScope(
      overrides: [reportProvider.overrideWith(() => _FakeReportNotifier(state))],
      child: MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: const Scaffold(body: ReportCustomDateLabel()),
      ),
    );
  }

  testWidgets('ReportCustomDateLabel shows custom date label when custom', (tester) async {
    final state = ReportState(
      period: ReportPeriod.custom,
      customDateStart: DateTime(2025, 1, 1),
      customDateEnd: DateTime(2025, 1, 31),
    );

    await tester.pumpWidget(buildHarness(state));
    await tester.pumpAndSettle();

    expect(find.text('1 Jan 2025 – 31 Jan 2025'), findsOneWidget);
  });

  testWidgets('ReportCustomDateLabel renders nothing when not custom', (tester) async {
    const state = ReportState(period: ReportPeriod.thisMonth);

    await tester.pumpWidget(buildHarness(state));
    await tester.pumpAndSettle();

    expect(find.byType(Text), findsNothing);
  });
}
