import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/shared/widgets/poka_toast.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildApp(Widget child) {
    return MaterialApp(
      builder: (context, child) => FTheme(
        data: lightTheme,
        child: FToaster(child: child!),
      ),
      home: Scaffold(body: child),
    );
  }

  group('showPokaToast', () {
    testWidgets('displays title and auto-dismisses after duration', (tester) async {
      var dismissed = false;

      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showPokaToast(
                  context: context,
                  title: const Text('Saved successfully'),
                  duration: const Duration(seconds: 3),
                  onDismiss: () => dismissed = true,
                );
              },
              child: const Text('Show Toast'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Saved successfully'), findsOneWidget);
      expect(dismissed, isFalse);

      // Advance past duration + watchdog
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(find.text('Saved successfully'), findsNothing);
      expect(dismissed, isTrue);
    });

    testWidgets('watchdog timer dismisses toast when still showing', (tester) async {
      var dismissed = false;

      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showPokaToast(
                  context: context,
                  title: const Text('Watchdog Test'),
                  duration: const Duration(seconds: 2),
                  onDismiss: () => dismissed = true,
                );
              },
              child: const Text('Trigger'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Trigger'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Watchdog Test'), findsOneWidget);

      // Advance time to allow duration + watchdog (2s + 300ms) to trigger
      await tester.pump(const Duration(milliseconds: 2500));
      await tester.pumpAndSettle();

      expect(find.text('Watchdog Test'), findsNothing);
      expect(dismissed, isTrue);
    });
  });

  group('showPokaActionToast', () {
    testWidgets('renders action button and triggers onAction callback when tapped', (tester) async {
      var actionTriggered = false;

      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showPokaActionToast(
                  context: context,
                  title: const Text('Item deleted'),
                  actionLabel: 'Undo',
                  onAction: () => actionTriggered = true,
                  duration: const Duration(seconds: 5),
                );
              },
              child: const Text('Delete'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Delete'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Item deleted'), findsOneWidget);
      expect(find.text('Undo'), findsOneWidget);

      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();

      expect(actionTriggered, isTrue);
      expect(find.text('Item deleted'), findsNothing);
    });
  });
}
