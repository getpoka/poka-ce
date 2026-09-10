import 'dart:ui';

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

    testWidgets('watchdog timer dismisses toast when internal timer is interrupted by hover', (tester) async {
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

      // Simulate mouse hovering over toast to interrupt/cancel ForUI's internal timer via MouseRegion.onEnter
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      await gesture.moveTo(tester.getCenter(find.text('Watchdog Test')));
      await tester.pump();

      // Advance past normal duration (2s). Internal timer was cancelled by MouseRegion.onEnter,
      // so without watchdog it would remain indefinitely.
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Watchdog Test'), findsOneWidget);
      expect(dismissed, isFalse);

      // Advance past watchdog duration (+300ms post-frame)
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();

      expect(find.text('Watchdog Test'), findsNothing);
      expect(dismissed, isTrue);

      await gesture.removePointer();
      await tester.pump(const Duration(milliseconds: 300));
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
