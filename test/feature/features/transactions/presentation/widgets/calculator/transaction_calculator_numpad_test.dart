import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/calculator/transaction_calculator_numpad.dart';

void main() {
  Widget wrapNumpad(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('TransactionCalculatorNumpad widget', () {
    testWidgets('renders all digit keys and operators', (tester) async {
      final values = <String>[];
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '',
            onKeyPressed: values.add,
            typeColor: Colors.green,
          ),
        ),
      );

      final expectedKeys = ['7', '8', '9', '÷', '4', '5', '6', '×', '1', '2', '3', '−', '0', '.', '+', '+/-'];

      for (final key in expectedKeys) {
        expect(find.text(key), findsOneWidget);
      }
      // Check checkmark icon
      expect(find.byIcon(FPhosphorIcons.check), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.backspace), findsOneWidget);
    });

    testWidgets('shows = when has operator', (tester) async {
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '10+5',
            onKeyPressed: (_) {},
            typeColor: Colors.green,
          ),
        ),
      );
      expect(find.text('='), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.check), findsNothing);
    });

    testWidgets('shows check when no operator', (tester) async {
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '10',
            onKeyPressed: (_) {},
            typeColor: Colors.green,
          ),
        ),
      );
      expect(find.text('='), findsNothing);
      expect(find.byIcon(FPhosphorIcons.check), findsOneWidget);
    });

    testWidgets('tapping digits and operators calls onKeyPressed', (tester) async {
      final values = <String>[];
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '',
            onKeyPressed: values.add,
            typeColor: Colors.green,
          ),
        ),
      );

      await tester.tap(find.text('7'));
      await tester.pump();
      await tester.tap(find.text('÷'));
      await tester.pump();
      await tester.tap(find.text('+/-'));
      await tester.pump();

      expect(values, ['7', '/', '+/-']);
    });

    testWidgets('tapping action key emits OK or = based on operator presence', (tester) async {
      final values = <String>[];
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '10+5',
            onKeyPressed: values.add,
            typeColor: Colors.green,
          ),
        ),
      );
      await tester.tap(find.text('='));
      await tester.pump();
      expect(values.last, '=');

      final values2 = <String>[];
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '10',
            onKeyPressed: values2.add,
            typeColor: Colors.green,
          ),
        ),
      );
      await tester.tap(find.byIcon(FPhosphorIcons.check));
      await tester.pump();
      expect(values2.last, 'OK');
    });

    testWidgets('long pressing 0 emits 000', (tester) async {
      final values = <String>[];
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '',
            onKeyPressed: values.add,
            typeColor: Colors.green,
          ),
        ),
      );
      await tester.longPress(find.text('0'));
      await tester.pump();
      expect(values.last, '000');
    });

    testWidgets('long pressing backspace emits C', (tester) async {
      final values = <String>[];
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '',
            onKeyPressed: values.add,
            typeColor: Colors.green,
          ),
        ),
      );
      await tester.longPress(find.byIcon(FPhosphorIcons.backspace));
      await tester.pump();
      expect(values.last, 'C');
    });

    testWidgets('template button when onTemplatePressed', (tester) async {
      bool templatePressed = false;
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '',
            onKeyPressed: (_) {},
            typeColor: Colors.green,
            onTemplatePressed: () => templatePressed = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(FPhosphorIcons.receipt));
      await tester.pump();
      expect(templatePressed, true);
    });

    testWidgets('split button when onSplitPressed', (tester) async {
      bool splitPressed = false;
      await tester.pumpWidget(
        wrapNumpad(
          TransactionCalculatorNumpad(
            value: '',
            onKeyPressed: (_) {},
            typeColor: Colors.green,
            showSplitButton: true,
            onSplitPressed: () => splitPressed = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(FPhosphorIcons.gitBranch));
      await tester.pump();
      expect(splitPressed, true);
    });
  });
}
