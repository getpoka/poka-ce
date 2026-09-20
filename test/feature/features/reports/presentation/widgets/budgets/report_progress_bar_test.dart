import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budgets/report_progress_bar.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap({required double progress, required Color color, bool animated = false}) {
    return MaterialApp(
      builder: (context, child) => FTheme(data: lightTheme, child: child!),
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 200,
            child: ReportProgressBar(progress: progress, color: color, animated: animated),
          ),
        ),
      ),
    );
  }

  group('ReportProgressBar', () {
    testWidgets('renders non-animated progress bar with FractionallySizedBox', (tester) async {
      await tester.pumpWidget(wrap(progress: 0.6, color: Colors.blue, animated: false));

      final sizedBoxFinder = find.byType(FractionallySizedBox);
      expect(sizedBoxFinder, findsOneWidget);

      final fractionalSizedBox = tester.widget<FractionallySizedBox>(sizedBoxFinder);
      expect(fractionalSizedBox.widthFactor, 0.6);
    });

    testWidgets('renders animated progress bar with TweenAnimationBuilder', (tester) async {
      await tester.pumpWidget(wrap(progress: 0.8, color: Colors.red, animated: true));

      expect(find.byType(TweenAnimationBuilder<double>), findsOneWidget);
      await tester.pumpAndSettle();

      final fractionalSizedBox = tester.widget<FractionallySizedBox>(find.byType(FractionallySizedBox));
      expect(fractionalSizedBox.widthFactor, 0.8);
    });
  });
}
