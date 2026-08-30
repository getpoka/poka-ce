import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/shared/widgets/keypad.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrap(Widget child) => MaterialApp(
  builder: (context, c) => FTheme(data: lightTheme, child: c!),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Keypad', () {
    testWidgets('renders digits 0-9', (tester) async {
      await tester.pumpWidget(
        wrap(
          Keypad(
            isBiometricActive: false,
            hasBiometric: true,
            onKeyPressed: (_) {},
            onBackspacePressed: () {},
            onBiometricPressed: () {},
          ),
        ),
      );

      for (var i = 0; i <= 9; i++) {
        expect(find.text('$i'), findsOneWidget);
      }
    });

    testWidgets('digit tap fires onKeyPressed with correct value', (tester) async {
      final pressed = <String>[];
      await tester.pumpWidget(
        wrap(
          Keypad(
            isBiometricActive: false,
            hasBiometric: false,
            onKeyPressed: pressed.add,
            onBackspacePressed: () {},
            onBiometricPressed: () {},
          ),
        ),
      );

      await tester.tap(find.text('7'));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.tap(find.text('0'));
      await tester.pump(const Duration(milliseconds: 200));

      expect(pressed, ['7', '0']);
    });

    testWidgets('backspace placeholder present when biometrics off', (tester) async {
      await tester.pumpWidget(
        wrap(
          Keypad(
            isBiometricActive: false,
            hasBiometric: false,
            onKeyPressed: (_) {},
            onBackspacePressed: () {},
            onBiometricPressed: () {},
          ),
        ),
      );

      // Bottom row: SizedBox placeholder + digit 0 + backspace button
      expect(find.text('0'), findsOneWidget);
      expect(find.byType(FCircularProgress), findsNothing);
    });

    testWidgets('hasBiometric false shows placeholder SizedBox', (tester) async {
      await tester.pumpWidget(
        wrap(
          Keypad(
            isBiometricActive: false,
            hasBiometric: false,
            onKeyPressed: (_) {},
            onBackspacePressed: () {},
            onBiometricPressed: () {},
          ),
        ),
      );

      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(FCircularProgress), findsNothing);
    });

    testWidgets('isBiometricActive true shows circular progress', (tester) async {
      await tester.pumpWidget(
        wrap(
          Keypad(
            isBiometricActive: true,
            hasBiometric: true,
            onKeyPressed: (_) {},
            onBackspacePressed: () {},
            onBiometricPressed: () {},
          ),
        ),
      );

      expect(find.byType(FCircularProgress), findsOneWidget);
    });

    testWidgets('renders tappable buttons for all keys', (tester) async {
      await tester.pumpWidget(
        wrap(
          Keypad(
            isBiometricActive: false,
            hasBiometric: true,
            onKeyPressed: (_) {},
            onBackspacePressed: () {},
            onBiometricPressed: () {},
          ),
        ),
      );

      // 10 digits + backspace + biometric = 12 tappable buttons
      // FTappable's constructor produces AnimatedTappable instances, so match by subtype.
      expect(find.byWidgetPredicate((w) => w is FTappable), findsNWidgets(12));
    });
  });
}
