import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/shared/widgets/poka_add_transaction_fab.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap(Widget child) {
    return MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('PokaAddTransactionFab', () {
    testWidgets('renders key and plus icon properly', (tester) async {
      await tester.pumpWidget(wrap(const PokaAddTransactionFab()));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('transaction-add-button')), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.plus), findsOneWidget);
    });

    testWidgets('calls custom onTap when provided', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        wrap(
          PokaAddTransactionFab(
            onTap: () {
              tapped = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('transaction-add-button')));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('renders outer ring halo in card color', (tester) async {
      await tester.pumpWidget(wrap(const PokaAddTransactionFab()));
      await tester.pumpAndSettle();

      final containers = tester
          .widgetList<Container>(
            find.descendant(
              of: find.byKey(const Key('transaction-add-button')),
              matching: find.byType(Container),
            ),
          )
          .toList();

      expect(containers.length, greaterThanOrEqualTo(2));
      final outerContainer = containers.first;
      final outerDecoration = outerContainer.decoration as BoxDecoration?;
      expect(outerDecoration?.shape, BoxShape.circle);
      expect(outerDecoration?.color, lightTheme.colors.card);
      expect(outerContainer.padding, const EdgeInsets.all(3));
    });
  });
}
