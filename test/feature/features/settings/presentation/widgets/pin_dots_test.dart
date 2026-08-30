import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/settings/presentation/widgets/pin_dots.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrap(Widget child) => MaterialApp(
  builder: (context, c) => FTheme(data: lightTheme, child: c!),
  home: Scaffold(body: Center(child: child)),
);

/// Matches the circular dot containers rendered by [PinDots].
///
/// Container folds width/height into its constraints field, so size-based
/// predicates are unreliable; matching by circle decoration is exact.
bool isDotContainer(Widget w) {
  if (w is! Container) return false;
  final decoration = w.decoration;
  return decoration is BoxDecoration && decoration.shape == BoxShape.circle;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PinDots', () {
    testWidgets('renders maxLength dots by default', (tester) async {
      await tester.pumpWidget(wrap(const PinDots(pinLength: 0)));
      final row = tester.widget<Row>(find.byType(Row));
      expect(row.children.length, 6);
    });

    testWidgets('renders custom maxLength', (tester) async {
      await tester.pumpWidget(wrap(const PinDots(pinLength: 2, maxLength: 4)));
      final row = tester.widget<Row>(find.byType(Row));
      expect(row.children.length, 4);
    });

    testWidgets('filled dots use primary color, empty use muted', (tester) async {
      await tester.pumpWidget(wrap(const PinDots(pinLength: 3)));
      final containers = tester.widgetList<Container>(find.byWidgetPredicate(isDotContainer));
      expect(containers.length, 6);

      final decorations = containers.map((c) => c.decoration! as BoxDecoration).toList();
      // First 3 filled
      expect(decorations[0].color, isNot(decorations[5].color));
    });

    testWidgets('pinLength equal to maxLength fills all', (tester) async {
      await tester.pumpWidget(wrap(const PinDots(pinLength: 6)));
      final containers = tester.widgetList<Container>(find.byWidgetPredicate(isDotContainer));
      final decorations = containers.map((c) => c.decoration! as BoxDecoration).toList();
      final first = decorations.first.color;
      for (final d in decorations) {
        expect(d.color, first);
      }
    });

    testWidgets('zero length all dots empty style', (tester) async {
      await tester.pumpWidget(wrap(const PinDots(pinLength: 0)));
      final containers = tester.widgetList<Container>(find.byWidgetPredicate(isDotContainer));
      final decorations = containers.map((c) => c.decoration! as BoxDecoration).toList();
      final first = decorations.first.color;
      for (final d in decorations) {
        expect(d.color, first);
      }
    });
  });
}
