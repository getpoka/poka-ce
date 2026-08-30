import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/carousel_shared.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/i18n/strings.g.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget wrapWithTheme(Widget child) {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(body: child),
      ),
    );
  }

  group('DonutChartPainter', () {
    test('shouldRepaint returns true', () {
      final painter = DonutChartPainter(proportions: const [0.5, 0.5], colors: const [Colors.red, Colors.blue]);
      final old = DonutChartPainter(proportions: const [0.5, 0.5], colors: const [Colors.red, Colors.blue]);
      expect(painter.shouldRepaint(old), isTrue);
    });

    testWidgets('paints with empty proportions without crashing', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: DonutChartPainter(proportions: [], colors: []),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with empty colors without crashing', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: DonutChartPainter(proportions: [0.5], colors: []),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints single segment correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: DonutChartPainter(proportions: [1.0], colors: [Colors.red]),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints multiple segments with gap logic', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: DonutChartPainter(proportions: [0.5, 0.3, 0.2], colors: [Colors.red, Colors.green, Colors.blue]),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with small sweepAngle without gap subtraction', (tester) async {
      // proportions * 6.28319 <=0.1 => sweepAngle <=0.1, should not subtract gap
      // 0.01 * 6.28319 = 0.062 -> small
      await tester.pumpWidget(
        wrapWithTheme(
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: DonutChartPainter(proportions: [0.01, 0.99], colors: [Colors.red, Colors.blue]),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom strokeWidth', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: DonutChartPainter(proportions: [0.5, 0.5], colors: [Colors.red, Colors.blue], strokeWidth: 20),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with single segment and multiple colors gap edge', (tester) async {
      // Single segment should not apply gap subtraction (proportions.length >1 check)
      await tester.pumpWidget(
        wrapWithTheme(
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: DonutChartPainter(proportions: [1.0], colors: [Colors.purple]),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('buildCategoryStatRow', () {
    testWidgets('renders label value progress correctly', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return buildCategoryStatRow(context, 'Food', '1.0K', Colors.red, 0.5);
            },
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('1.0K'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('handles long label with ellipsis', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          SizedBox(
            width: 300,
            child: Builder(
              builder: (context) {
                return buildCategoryStatRow(
                  context,
                  'Very Long Category Name That Should Ellipsis',
                  '2.5K',
                  Colors.green,
                  0.8,
                );
              },
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.textContaining('Very Long'), findsOneWidget);
    });

    testWidgets('progress 0 and 1 edge cases', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Column(
            children: [
              Builder(builder: (context) => buildCategoryStatRow(context, 'A', '0', Colors.red, 0)),
              Builder(builder: (context) => buildCategoryStatRow(context, 'B', '1K', Colors.blue, 1.0)),
            ],
          ),
        ),
      );
      await tester.pump();
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNWidgets(2));
    });
  });
}
