import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/shared/widgets/poka_menu_group_card.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrap(Widget child) => MaterialApp(
  builder: (context, c) => FTheme(data: lightTheme, child: c!),
  home: Scaffold(body: child),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PokaMenuGroupCard', () {
    testWidgets('renders child inside card', (tester) async {
      await tester.pumpWidget(wrap(const PokaMenuGroupCard(child: Text('Row Content'))));
      expect(find.text('Row Content'), findsOneWidget);
    });

    testWidgets('card container clips children with anti alias', (tester) async {
      await tester.pumpWidget(wrap(const PokaMenuGroupCard(child: SizedBox())));
      // Find the outer decorated Container
      final containers = tester.widgetList<Container>(
        find.descendant(of: find.byType(PokaMenuGroupCard), matching: find.byType(Container)),
      );
      expect(containers, isNotEmpty);
      expect(containers.first.clipBehavior, Clip.antiAlias);
      expect(containers.first.decoration, isA<BoxDecoration>());
    });

    testWidgets('inner FTheme has transparent background', (tester) async {
      await tester.pumpWidget(wrap(const PokaMenuGroupCard(child: Text('X'))));
      await tester.pump();
      final themes = tester.widgetList<FTheme>(find.byType(FTheme));
      expect(themes.length, greaterThanOrEqualTo(2));
      expect(themes.last.data.colors.background, Colors.transparent);
    });
  });

  group('PokaMenuGroupLabel', () {
    testWidgets('renders uppercase text', (tester) async {
      await tester.pumpWidget(wrap(const PokaMenuGroupLabel('preferences')));
      expect(find.text('PREFERENCES'), findsOneWidget);
      expect(find.text('preferences'), findsNothing);
    });

    testWidgets('has accent bar container', (tester) async {
      await tester.pumpWidget(wrap(const PokaMenuGroupLabel('Account')));
      // Container folds width/height into its constraints field, so match the
      // accent bar by its primary-colored BoxDecoration.
      final bars = tester.widgetList<Container>(
        find.byWidgetPredicate(
          (w) => w is Container && w.constraints?.minWidth == 3 && w.decoration is BoxDecoration,
        ),
      );
      expect(bars, isNotEmpty);
    });

    testWidgets('row contains bar, spacing and text', (tester) async {
      await tester.pumpWidget(wrap(const PokaMenuGroupLabel('Security')));
      final row = tester.widget<Row>(find.byType(Row));
      expect(row.children.length, 3);
      expect(row.children[0], isA<Container>());
      expect(row.children[1], isA<SizedBox>());
      expect(row.children[2], isA<Text>());
    });

    testWidgets('icon data class usable', (tester) async {
      // Sanity check PhosphorIcons import used across menu items
      expect(FPhosphorIcons.gear, isA<IconData>());
    });
  });
}
