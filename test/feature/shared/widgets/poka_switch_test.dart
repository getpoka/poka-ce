import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/shared/widgets/poka_switch.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrap(Widget child) => MaterialApp(
  builder: (context, c) => FTheme(data: lightTheme, child: c!),
  home: Scaffold(body: child),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PokaSwitch', () {
    testWidgets('renders FSwitch with value true', (tester) async {
      await tester.pumpWidget(wrap(PokaSwitch(value: true, onChange: (_) {})));
      expect(find.byType(FSwitch), findsOneWidget);
      expect(tester.widget<FSwitch>(find.byType(FSwitch)).value, isTrue);
    });

    testWidgets('renders FSwitch with value false', (tester) async {
      await tester.pumpWidget(wrap(PokaSwitch(value: false, onChange: (_) {})));
      expect(tester.widget<FSwitch>(find.byType(FSwitch)).value, isFalse);
    });

    testWidgets('tapping fires onChange with new value', (tester) async {
      bool? changed;
      await tester.pumpWidget(wrap(PokaSwitch(value: false, onChange: (v) => changed = v)));

      await tester.tap(find.byType(FSwitch));
      await tester.pumpAndSettle();

      expect(changed, isTrue);
    });

    testWidgets('applies custom scale via Transform.scale', (tester) async {
      await tester.pumpWidget(wrap(PokaSwitch(value: false, onChange: (_) {}, scale: 0.5)));
      final transform = tester.widget<Transform>(find.byType(Transform).first);
      expect(transform.transform[0], 0.5);
    });
  });
}
