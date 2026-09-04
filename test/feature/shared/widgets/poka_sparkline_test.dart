import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/shared/widgets/poka_sparkline.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrap(Widget child) => MaterialApp(
  builder: (context, c) => FTheme(data: lightTheme, child: c!),
  home: Scaffold(
    body: Center(child: SizedBox(width: 300, height: 100, child: child)),
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Finder sparklinePaint() => find.descendant(
    of: find.byType(PokaSparkline),
    matching: find.byType(CustomPaint),
  );

  group('PokaSparkline', () {
    testWidgets('renders SizedBox.shrink when points is empty', (tester) async {
      await tester.pumpWidget(wrap(const PokaSparkline(points: [])));
      await tester.pumpAndSettle();

      expect(sparklinePaint(), findsNothing);
    });

    testWidgets('renders CustomPaint when points are provided', (tester) async {
      await tester.pumpWidget(
        wrap(
          const PokaSparkline(
            points: [100, 150, 120, 200, 180, 250, 300],
          ),
        ),
      );

      expect(sparklinePaint(), findsOneWidget);
      await tester.pumpAndSettle();
      expect(sparklinePaint(), findsOneWidget);
    });

    testWidgets('renders properly with flat line (identical values)', (tester) async {
      await tester.pumpWidget(
        wrap(
          const PokaSparkline(
            points: [200, 200, 200, 200],
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(sparklinePaint(), findsOneWidget);
    });

    testWidgets('renders single point without crash', (tester) async {
      await tester.pumpWidget(
        wrap(
          const PokaSparkline(
            points: [100],
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(sparklinePaint(), findsOneWidget);
    });

    testWidgets('renders with isCurved false (straight lines)', (tester) async {
      await tester.pumpWidget(
        wrap(
          const PokaSparkline(
            points: [10, 50, 30, 80],
            isCurved: false,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(sparklinePaint(), findsOneWidget);
    });

    testWidgets('respects showEndDot false', (tester) async {
      await tester.pumpWidget(
        wrap(
          const PokaSparkline(
            points: [10, 20, 30],
            showEndDot: false,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(sparklinePaint(), findsOneWidget);
    });
  });
}
