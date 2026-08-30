import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet_header.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrapHeader({
  required String title,
  Widget? leading,
  Widget? trailing,
  bool showCloseButton = true,
}) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(
        body: PokaSheetHeader(
          title: title,
          leading: leading,
          trailing: trailing,
          showCloseButton: showCloseButton,
        ),
      ),
    ),
  );
}

Widget wrapHeaderWithNavigator({
  required String title,
  Widget? leading,
  Widget? trailing,
  bool showCloseButton = true,
  void Function(dynamic)? onPop,
}) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<String>(
                MaterialPageRoute(
                  builder: (_) => FTheme(
                    data: lightTheme,
                    child: Scaffold(
                      body: PokaSheetHeader(
                        title: title,
                        leading: leading,
                        trailing: trailing,
                        showCloseButton: showCloseButton,
                      ),
                    ),
                  ),
                ),
              );
              if (onPop != null) onPop(result);
            },
            child: const Text('Push Header'),
          ),
        ),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  group('PokaSheetHeader', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(wrapHeader(title: 'My Title'));
      expect(find.text('My Title'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('My Title'));
      expect(textWidget.textAlign, TextAlign.center);
      expect(textWidget.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('renders leading when provided', (tester) async {
      await tester.pumpWidget(
        wrapHeader(title: 'Title', leading: const Text('Leading')),
      );
      expect(find.text('Leading'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('shows SizedBox.shrink when leading is null', (tester) async {
      await tester.pumpWidget(wrapHeader(title: 'Title'));
      // Should have at least one SizedBox.shrink for missing leading
      expect(find.byType(PokaSheetHeader), findsOneWidget);
      // Row should contain SizedBox.shrink for leading
      final row = tester.widget<Row>(
        find.descendant(of: find.byType(PokaSheetHeader), matching: find.byType(Row)),
      );
      expect(row.children.length, 2);
      // First child should be SizedBox.shrink (when leading null)
      expect(row.children.first, isA<SizedBox>());
    });

    testWidgets('renders trailing when provided', (tester) async {
      await tester.pumpWidget(
        wrapHeader(title: 'Title', trailing: const Text('Trailing')),
      );
      expect(find.text('Trailing'), findsOneWidget);
      // Should NOT show close button X when trailing provided
      expect(find.byIcon(FPhosphorIcons.x), findsNothing);
    });

    testWidgets('trailing overrides close button even when showCloseButton true', (tester) async {
      await tester.pumpWidget(
        wrapHeader(
          title: 'Title',
          trailing: const Icon(FPhosphorIcons.check),
          showCloseButton: true,
        ),
      );
      expect(find.byIcon(FPhosphorIcons.check), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.x), findsNothing);
    });

    testWidgets('trailing overrides close button when showCloseButton false', (tester) async {
      await tester.pumpWidget(
        wrapHeader(
          title: 'Title',
          trailing: const Text('Custom'),
          showCloseButton: false,
        ),
      );
      expect(find.text('Custom'), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.x), findsNothing);
    });

    testWidgets('showCloseButton true renders FButton.icon with X', (tester) async {
      await tester.pumpWidget(wrapHeader(title: 'Title', showCloseButton: true));
      expect(find.byIcon(FPhosphorIcons.x), findsOneWidget);
      expect(find.byType(FButton), findsOneWidget);
    });

    testWidgets('showCloseButton false renders no close button when no trailing', (tester) async {
      await tester.pumpWidget(wrapHeader(title: 'Title', showCloseButton: false));
      expect(find.byIcon(FPhosphorIcons.x), findsNothing);
      // FButton should not be present (no trailing)
      expect(find.byType(FButton), findsNothing);
    });

    testWidgets('showCloseButton false with no trailing shows two SizedBox.shrink in Row', (tester) async {
      await tester.pumpWidget(wrapHeader(title: 'Title', showCloseButton: false));
      final row = tester.widget<Row>(
        find.descendant(of: find.byType(PokaSheetHeader), matching: find.byType(Row)),
      );
      expect(row.children.length, 2);
      // Both should be SizedBox.shrink placeholders
      expect(row.children[0], isA<SizedBox>());
      expect(row.children[1], isA<SizedBox>());
    });

    testWidgets('close button pop dismisses route', (tester) async {
      String? popped;
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            builder: (context, c) => FTheme(data: lightTheme, child: c!),
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push<String>(
                      MaterialPageRoute(
                        builder: (_) => FTheme(
                          data: lightTheme,
                          child: Scaffold(
                            body: PokaSheetHeader(
                              title: 'Close Test',
                              showCloseButton: true,
                            ),
                          ),
                        ),
                      ),
                    );
                    popped = result ?? 'popped_null';
                  },
                  child: const Text('Push'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Push'));
      await tester.pumpAndSettle();
      expect(find.text('Close Test'), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.x), findsOneWidget);

      await tester.tap(find.byIcon(FPhosphorIcons.x));
      await tester.pumpAndSettle();

      // After pop, header should be gone, original button visible
      expect(find.text('Close Test'), findsNothing);
      expect(find.text('Push'), findsOneWidget);
      // popped will be null because pop() without value returns null, we interpret as 'popped_null'
      expect(popped, 'popped_null');
    });

    testWidgets('close button tap via FButton calls Navigator.pop', (tester) async {
      bool popped = false;
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            builder: (context, c) => FTheme(data: lightTheme, child: c!),
            home: PokaSheetHeader(title: 'Pop', showCloseButton: true),
          ),
        ),
      );

      // Wrap in Navigator to actually test pop
      // Instead, test that onPress pops when inside a route
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            builder: (context, c) => FTheme(data: lightTheme, child: c!),
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (ctx) => FTheme(
                        data: lightTheme,
                        child: const Scaffold(
                          body: PokaSheetHeader(title: 'Dialog Header', showCloseButton: true),
                        ),
                      ),
                    );
                    popped = true;
                  },
                  child: const Text('Open Dialog'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();
      expect(find.text('Dialog Header'), findsOneWidget);
      await tester.tap(find.byIcon(FPhosphorIcons.x));
      await tester.pumpAndSettle();
      expect(popped, isTrue);
      expect(find.text('Dialog Header'), findsNothing);
    });

    testWidgets('header has correct padding', (tester) async {
      await tester.pumpWidget(wrapHeader(title: 'Pad'));
      final paddings = tester.widgetList<Padding>(
        find.descendant(of: find.byType(PokaSheetHeader), matching: find.byType(Padding)),
      );
      expect(paddings, isNotEmpty);
      final padding = paddings.first;
      expect(padding.padding, const EdgeInsets.fromLTRB(12, 0, 12, 12));
    });

    testWidgets('header Stack alignment center and Row spaceBetween', (tester) async {
      await tester.pumpWidget(wrapHeader(title: 'Align', leading: const Text('L')));
      final stack = tester.widget<Stack>(
        find.descendant(of: find.byType(PokaSheetHeader), matching: find.byType(Stack)),
      );
      expect(stack.alignment, Alignment.center);
      final row = tester.widget<Row>(
        find.descendant(of: find.byType(PokaSheetHeader), matching: find.byType(Row)),
      );
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });

    testWidgets('title is centered even with leading and trailing', (tester) async {
      await tester.pumpWidget(
        wrapHeader(
          title: 'Centered',
          leading: const Text('L'),
          trailing: const Text('R'),
        ),
      );
      expect(find.text('Centered'), findsOneWidget);
      expect(find.text('L'), findsOneWidget);
      expect(find.text('R'), findsOneWidget);
      // Stack should contain Text and Row
      final stack = tester.widget<Stack>(
        find.descendant(of: find.byType(PokaSheetHeader), matching: find.byType(Stack)),
      );
      expect(stack.children.length, 2);
    });

    testWidgets('leading icon widget displayed correctly', (tester) async {
      await tester.pumpWidget(
        wrapHeader(
          title: 'Title',
          leading: const Icon(FPhosphorIcons.house, size: 20),
        ),
      );
      expect(find.byIcon(FPhosphorIcons.house), findsOneWidget);
    });
  });
}
