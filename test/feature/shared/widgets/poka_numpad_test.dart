import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/shared/widgets/poka_numpad.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrap(Widget child) => MaterialApp(
  builder: (context, c) => FTheme(data: lightTheme, child: c!),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PokaNumpad', () {
    testWidgets('renders all digits 0-9', (tester) async {
      await tester.pumpWidget(
        wrap(
          PokaNumpad(
            onNumberPressed: (_) {},
            onBackspacePressed: () {},
            onConfirmPressed: () {},
          ),
        ),
      );

      for (var i = 0; i <= 9; i++) {
        expect(find.text('$i'), findsOneWidget);
      }
    });

    testWidgets('number tap fires onNumberPressed', (tester) async {
      final pressed = <int>[];
      await tester.pumpWidget(
        wrap(
          PokaNumpad(
            onNumberPressed: pressed.add,
            onBackspacePressed: () {},
            onConfirmPressed: () {},
          ),
        ),
      );

      await tester.tap(find.text('5'));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.tap(find.text('9'));
      await tester.pump(const Duration(milliseconds: 200));

      expect(pressed, [5, 9]);
    });

    testWidgets('zero tap fires with 0', (tester) async {
      final pressed = <int>[];
      await tester.pumpWidget(
        wrap(
          PokaNumpad(
            onNumberPressed: pressed.add,
            onBackspacePressed: () {},
            onConfirmPressed: () {},
          ),
        ),
      );

      await tester.tap(find.text('0'));
      await tester.pump(const Duration(milliseconds: 200));
      expect(pressed, [0]);
    });
  });
}
