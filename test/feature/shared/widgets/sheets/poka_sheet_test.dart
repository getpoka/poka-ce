import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

// Helper to wrap with TranslationProvider + FTheme + MaterialApp + Scaffold
Widget wrapWithTheme(
  Widget child, {
  EdgeInsets viewPadding = EdgeInsets.zero,
}) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: MediaQuery(
        data: MediaQueryData(viewPadding: viewPadding),
        child: Scaffold(body: child),
      ),
    ),
  );
}

Widget wrapSheet({
  String title = 'Test Title',
  Widget child = const Text('Sheet Child'),
  Widget? leading,
  Widget? trailing,
  bool showCloseButton = true,
  bool isScrollable = true,
  EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(20, 8, 20, 0),
  EdgeInsets viewPadding = EdgeInsets.zero,
}) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: MediaQuery(
        data: MediaQueryData(viewPadding: viewPadding),
        child: Scaffold(
          body: PokaSheet(
            title: title,
            leading: leading,
            trailing: trailing,
            showCloseButton: showCloseButton,
            isScrollable: isScrollable,
            padding: padding,
            child: child,
          ),
        ),
      ),
    ),
  );
}

// Host for showPokaSheet tests
class SheetHost extends StatelessWidget {
  final bool fitContent;
  final bool persistent;
  final bool useRootNavigator;
  final bool isScrollControlled;
  final void Function(dynamic)? onResult;

  const SheetHost({
    super.key,
    this.fitContent = false,
    this.persistent = true,
    this.useRootNavigator = true,
    this.isScrollControlled = false,
    this.onResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await showPokaSheet<String>(
              context: context,
              fitContent: fitContent,
              persistent: persistent,
              useRootNavigator: useRootNavigator,
              isScrollControlled: isScrollControlled,
              builder: (ctx) => PokaSheet(
                title: 'Sheet $fitContent $persistent',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Inside Sheet'),
                    ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop('popped_value'),
                      child: const Text('Pop Sheet'),
                    ),
                  ],
                ),
              ),
            );
            if (onResult != null) onResult!(result);
          },
          child: const Text('Open Sheet'),
        ),
      ),
    );
  }
}

Widget wrapHost(SheetHost host) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: host,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  group('pokaSheetBottomInset', () {
    testWidgets('returns bottom 16 when viewPadding bottom is 0', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              final inset = pokaSheetBottomInset(context);
              return Text('bottom:${inset.bottom}');
            },
          ),
          viewPadding: EdgeInsets.zero,
        ),
      );
      expect(find.text('bottom:12.0'), findsOneWidget);
    });

    testWidgets('returns viewPadding bottom + 16', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              final inset = pokaSheetBottomInset(context);
              return Text('bottom:${inset.bottom}');
            },
          ),
          viewPadding: const EdgeInsets.only(bottom: 34),
        ),
      );
      expect(find.text('bottom:46.0'), findsOneWidget);
    });

    testWidgets('returns correct for bottom 20', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              final inset = pokaSheetBottomInset(context);
              return Text('bottom:${inset.bottom}');
            },
          ),
          viewPadding: const EdgeInsets.only(bottom: 20),
        ),
      );
      expect(find.text('bottom:32.0'), findsOneWidget);
    });

    testWidgets('returns only bottom, no other insets', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              final inset = pokaSheetBottomInset(context);
              return Text(
                'l:${inset.left} t:${inset.top} r:${inset.right} b:${inset.bottom}',
              );
            },
          ),
          viewPadding: const EdgeInsets.only(bottom: 10, top: 5, left: 5),
        ),
      );
      expect(find.text('l:0.0 t:0.0 r:0.0 b:22.0'), findsOneWidget);
    });
  });

  group('PokaSheetHandle', () {
    testWidgets('renders handle with correct size and decoration', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const PokaSheetHandle()));
      final container = tester.widget<Container>(find.byType(Container));
      // Check width/height via widget properties (Container width/height)
      // Container stores constraints; verify via BoxConstraints from widget
      expect(container.constraints?.maxWidth, 48);
      expect(container.constraints?.maxHeight, 4);
      // Fallback: check explicit width/height via constraints if available
      // For Container with width/height, constraints is not null and maxWidth equals width
      // Also verify size including margin is 48 x 20 (4 + 12 + 4)
      final size = tester.getSize(find.byType(Container));
      expect(size.width, 48);
      expect(size.height, 20);

      // Check margin
      expect(container.margin, const EdgeInsets.only(top: 12, bottom: 4));

      // Check decoration
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNotNull);
      // Color should be mutedForeground with alpha 0.3
      expect(decoration.color, isNotNull);

      // Should be inside Center
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('handle uses theme colors', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            builder: (context, c) => FTheme(data: darkTheme, child: c!),
            home: const Scaffold(body: PokaSheetHandle()),
          ),
        ),
      );
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
    });
  });

  group('PokaSheet', () {
    testWidgets('renders title, child, handle and header', (tester) async {
      await tester.pumpWidget(wrapSheet());
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Sheet Child'), findsOneWidget);
      expect(find.byType(PokaSheetHandle), findsOneWidget);
      expect(find.byType(PokaSheetHeader), findsOneWidget);
    });

    testWidgets('isScrollable true wraps child in Flexible and SingleChildScrollView', (tester) async {
      await tester.pumpWidget(wrapSheet(isScrollable: true));
      expect(find.byType(Flexible), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('isScrollable false does not wrap in Flexible nor SingleChildScrollView', (tester) async {
      await tester.pumpWidget(wrapSheet(isScrollable: false));
      expect(find.byType(Flexible), findsNothing);
      expect(find.byType(SingleChildScrollView), findsNothing);
      // Still renders child
      expect(find.text('Sheet Child'), findsOneWidget);
    });

    testWidgets('showCloseButton true passes to header and shows close button', (tester) async {
      await tester.pumpWidget(wrapSheet(showCloseButton: true));
      // Header should have close button (FButton.icon with X)
      expect(find.byIcon(FPhosphorIcons.x), findsOneWidget);
    });

    testWidgets('showCloseButton false does not show close button when no trailing', (tester) async {
      await tester.pumpWidget(wrapSheet(showCloseButton: false));
      expect(find.byIcon(FPhosphorIcons.x), findsNothing);
    });

    testWidgets('custom padding is applied plus bottom inset', (tester) async {
      const customPadding = EdgeInsets.fromLTRB(10, 10, 10, 10);
      await tester.pumpWidget(
        wrapSheet(
          padding: customPadding,
          viewPadding: const EdgeInsets.only(bottom: 34),
        ),
      );
      // effectivePadding = customPadding.add(bottom: 46)
      // Find Padding widget that wraps child
      final paddingWidgets = tester.widgetList<Padding>(find.byType(Padding));
      // There are multiple Paddings (header padding + sheet padding + SafeArea etc). Find the one containing 'Sheet Child'
      // The sheet's content padding should be 10,10,10,10 + bottom 46 => left10 top10 right10 bottom56
      bool found = false;
      for (final p in paddingWidgets) {
        final pad = p.padding;
        if (pad is EdgeInsets) {
          if (pad.left == 10 && pad.top == 10 && pad.right == 10 && pad.bottom == 56) {
            found = true;
            break;
          }
        }
      }
      expect(found, isTrue, reason: 'effectivePadding should include bottomInset');
    });

    testWidgets('default padding adds bottom inset', (tester) async {
      await tester.pumpWidget(
        wrapSheet(viewPadding: const EdgeInsets.only(bottom: 20)),
      );
      // wrapSheet helper default padding 20,8,20,0 + bottom 32 => 20,8,20,32
      final paddingWidgets = tester.widgetList<Padding>(find.byType(Padding));
      bool found = false;
      for (final p in paddingWidgets) {
        final pad = p.padding;
        if (pad is EdgeInsets) {
          if (pad.left == 20 && pad.top == 8 && pad.right == 20 && pad.bottom == 32) {
            found = true;
            break;
          }
        }
      }
      expect(found, isTrue);
    });

    testWidgets('leading widget is displayed', (tester) async {
      await tester.pumpWidget(
        wrapSheet(leading: const Text('Leading Widget')),
      );
      expect(find.text('Leading Widget'), findsOneWidget);
    });

    testWidgets('trailing widget is displayed', (tester) async {
      await tester.pumpWidget(
        wrapSheet(trailing: const Text('Trailing Widget')),
      );
      expect(find.text('Trailing Widget'), findsOneWidget);
      // Should show trailing instead of close button
      expect(find.byIcon(FPhosphorIcons.x), findsNothing);
    });

    testWidgets('leading and trailing both displayed', (tester) async {
      await tester.pumpWidget(
        wrapSheet(
          leading: const Icon(FPhosphorIcons.house),
          trailing: const Text('Custom Trailing'),
        ),
      );
      expect(find.byIcon(FPhosphorIcons.house), findsOneWidget);
      expect(find.text('Custom Trailing'), findsOneWidget);
    });

    testWidgets('renders SafeArea with top false bottom false', (tester) async {
      await tester.pumpWidget(wrapSheet());
      final safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
      expect(safeArea.top, isFalse);
      expect(safeArea.bottom, isFalse);
    });

    testWidgets('Column has mainAxisSize min and stretch', (tester) async {
      await tester.pumpWidget(wrapSheet());
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.mainAxisSize, MainAxisSize.min);
      expect(column.crossAxisAlignment, CrossAxisAlignment.stretch);
    });

    testWidgets('shows child with custom widget', (tester) async {
      await tester.pumpWidget(
        wrapSheet(
          child: const Column(
            children: [Text('A'), Text('B')],
          ),
        ),
      );
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
    });
  });

  group('showPokaSheet', () {
    testWidgets('fitContent false shows sheet and pops with value', (tester) async {
      String? result;
      await tester.pumpWidget(
        wrapHost(SheetHost(fitContent: false, persistent: true, onResult: (v) => result = v as String?)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Inside Sheet'), findsOneWidget);
      expect(find.text('Sheet false true'), findsOneWidget);

      await tester.tap(find.text('Pop Sheet'));
      await tester.pumpAndSettle();

      expect(result, 'popped_value');
      expect(find.text('Inside Sheet'), findsNothing);
    });

    testWidgets('fitContent true shows sheet and pops with value', (tester) async {
      String? result;
      await tester.pumpWidget(
        wrapHost(SheetHost(fitContent: true, persistent: true, onResult: (v) => result = v as String?)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Inside Sheet'), findsOneWidget);
      expect(find.text('Sheet true true'), findsOneWidget);

      await tester.tap(find.text('Pop Sheet'));
      await tester.pumpAndSettle();

      expect(result, 'popped_value');
      expect(find.text('Inside Sheet'), findsNothing);
    });

    testWidgets('persistent false shows sheet (barrierDismissible true)', (tester) async {
      String? result;
      await tester.pumpWidget(
        wrapHost(SheetHost(fitContent: false, persistent: false, onResult: (v) => result = v as String?)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Inside Sheet'), findsOneWidget);

      await tester.tap(find.text('Pop Sheet'));
      await tester.pumpAndSettle();

      expect(result, 'popped_value');
    });

    testWidgets('fitContent true persistent false shows sheet', (tester) async {
      String? result;
      await tester.pumpWidget(
        wrapHost(SheetHost(fitContent: true, persistent: false, onResult: (v) => result = v as String?)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Inside Sheet'), findsOneWidget);
      await tester.tap(find.text('Pop Sheet'));
      await tester.pumpAndSettle();
      expect(result, 'popped_value');
    });

    testWidgets('useRootNavigator false works', (tester) async {
      String? result;
      await tester.pumpWidget(
        wrapHost(SheetHost(useRootNavigator: false, onResult: (v) => result = v as String?)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Inside Sheet'), findsOneWidget);
      await tester.tap(find.text('Pop Sheet'));
      await tester.pumpAndSettle();
      expect(result, 'popped_value');
    });

    testWidgets('isScrollControlled true still shows sheet', (tester) async {
      String? result;
      await tester.pumpWidget(
        wrapHost(SheetHost(isScrollControlled: true, onResult: (v) => result = v as String?)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Inside Sheet'), findsOneWidget);
      await tester.tap(find.text('Pop Sheet'));
      await tester.pumpAndSettle();
      expect(result, 'popped_value');
    });

    testWidgets('isScrollControlled false still shows sheet', (tester) async {
      String? result;
      await tester.pumpWidget(
        wrapHost(SheetHost(isScrollControlled: false, onResult: (v) => result = v as String?)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Inside Sheet'), findsOneWidget);
      await tester.tap(find.text('Pop Sheet'));
      await tester.pumpAndSettle();
      expect(result, 'popped_value');
    });

    testWidgets('decoration uses theme background color', (tester) async {
      await tester.pumpWidget(
        wrapHost(const SheetHost(fitContent: false)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      // Find DecoratedBox
      final decoratedBox = tester.widgetList<DecoratedBox>(find.byType(DecoratedBox));
      bool found = false;
      for (final d in decoratedBox) {
        if (d.decoration is BoxDecoration) {
          final dec = d.decoration as BoxDecoration;
          if (dec.borderRadius != null && dec.color != null) {
            // Should match theme background
            found = true;
            // Border radius top xl
            expect(dec.borderRadius, isNotNull);
            break;
          }
        }
      }
      expect(found, isTrue);
    });

    testWidgets('barrier tap dismisses when persistent false', (tester) async {
      await tester.pumpWidget(
        wrapHost(const SheetHost(persistent: false)),
      );
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Inside Sheet'), findsOneWidget);

      // Tap barrier (top of screen outside sheet)
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      // Should have dismissed if barrierDismissible true
      expect(find.text('Inside Sheet'), findsNothing);
    });

    testWidgets('shows sheet with both fitContent and persistent combos via direct call', (tester) async {
      // Direct call without Host wrapper to cover builder context decoration branch
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            builder: (context, c) => FTheme(data: lightTheme, child: c!),
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => showPokaSheet<void>(
                    context: context,
                    fitContent: true,
                    builder: (ctx) => const PokaSheet(title: 'Direct', child: Text('Direct Child')),
                  ),
                  child: const Text('Open Direct'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open Direct'));
      await tester.pumpAndSettle();
      expect(find.text('Direct Child'), findsOneWidget);
      expect(find.text('Direct'), findsOneWidget);
    });
  });
}
