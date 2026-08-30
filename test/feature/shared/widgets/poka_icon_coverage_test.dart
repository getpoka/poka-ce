import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrapIcon(PokaIcon icon) {
  return MaterialApp(
    builder: (context, child) => FTheme(data: lightTheme, child: child!),
    home: Scaffold(body: Center(child: icon)),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PokaIcon coverage', () {
    testWidgets('small size renders 36 box and 18 icon', (tester) async {
      await tester.pumpWidget(wrapIcon(const PokaIcon(icon: Icons.home, size: PokaIconSize.small)));
      expect(tester.getSize(find.byType(Container)), const Size(36, 36));
      final phosphor = tester.widget<Icon>(find.byType(Icon));
      expect(phosphor.size, 18);
    });

    testWidgets('medium size renders 44 box and 22 icon', (tester) async {
      await tester.pumpWidget(wrapIcon(const PokaIcon(icon: Icons.home, size: PokaIconSize.medium)));
      expect(tester.getSize(find.byType(Container)), const Size(44, 44));
      expect(tester.widget<Icon>(find.byType(Icon)).size, 22);
    });

    testWidgets('large size renders 52 box and 26 icon', (tester) async {
      await tester.pumpWidget(wrapIcon(const PokaIcon(icon: Icons.home, size: PokaIconSize.large)));
      expect(tester.getSize(find.byType(Container)), const Size(52, 52));
      expect(tester.widget<Icon>(find.byType(Icon)).size, 26);
    });

    testWidgets('hero size renders 64 box and 32 icon', (tester) async {
      await tester.pumpWidget(wrapIcon(const PokaIcon(icon: Icons.home, size: PokaIconSize.hero)));
      expect(tester.getSize(find.byType(Container)), const Size(64, 64));
      expect(tester.widget<Icon>(find.byType(Icon)).size, 32);
    });

    testWidgets('circle shape uses BoxShape.circle and no borderRadius', (tester) async {
      await tester.pumpWidget(
        wrapIcon(const PokaIcon(icon: Icons.home, shape: PokaIconShape.circle)),
      );
      final container = tester.widget<Container>(find.byType(Container));
      final dec = container.decoration as BoxDecoration;
      expect(dec.shape, BoxShape.circle);
      expect(dec.borderRadius, isNull);
    });

    testWidgets('square shape uses rectangle and borderRadius 10', (tester) async {
      await tester.pumpWidget(
        wrapIcon(const PokaIcon(icon: Icons.home, shape: PokaIconShape.square)),
      );
      final container = tester.widget<Container>(find.byType(Container));
      final dec = container.decoration as BoxDecoration;
      expect(dec.shape, BoxShape.rectangle);
      expect(dec.borderRadius, BorderRadius.circular(10));
    });

    testWidgets('default color uses theme primary when color null', (tester) async {
      await tester.pumpWidget(wrapIcon(const PokaIcon(icon: Icons.home)));
      final phosphor = tester.widget<Icon>(find.byType(Icon));
      final expected = lightTheme.colors.primary;
      expect(phosphor.color, expected);
      final container = tester.widget<Container>(find.byType(Container));
      final dec = container.decoration as BoxDecoration;
      // bgColor alpha 0.15
      expect(dec.color, expected.withValues(alpha: 0.15));
    });

    testWidgets('custom color is used for icon and background', (tester) async {
      const custom = Colors.red;
      await tester.pumpWidget(
        wrapIcon(const PokaIcon(icon: Icons.home, color: custom)),
      );
      final phosphor = tester.widget<Icon>(find.byType(Icon));
      expect(phosphor.color, custom);
      final dec = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
      expect(dec.color, custom.withValues(alpha: 0.15));
    });

    testWidgets('default hasBorder is false and gives no border', (tester) async {
      await tester.pumpWidget(
        wrapIcon(const PokaIcon(icon: Icons.home)),
      );
      final dec = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
      expect(dec.border, isNull);
    });

    testWidgets('hasBorder true gives border with effectiveColor alpha 0.25', (tester) async {
      const custom = Colors.blue;
      await tester.pumpWidget(
        wrapIcon(const PokaIcon(icon: Icons.home, color: custom, hasBorder: true)),
      );
      final dec = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
      expect(dec.border, isNotNull);
      final border = dec.border as Border;
      expect(border.top.color, custom.withValues(alpha: 0.25));
    });

    testWidgets('useThemeBorderColor true uses theme border color', (tester) async {
      await tester.pumpWidget(
        wrapIcon(const PokaIcon(icon: Icons.home, useThemeBorderColor: true, hasBorder: true)),
      );
      final dec = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
      expect(dec.border, isNotNull);
      final border = dec.border as Border;
      expect(border.top.color, lightTheme.colors.border);
    });

    testWidgets('useThemeBorderColor false uses effectiveColor alpha 0.25', (tester) async {
      const custom = Colors.green;
      await tester.pumpWidget(
        wrapIcon(const PokaIcon(icon: Icons.home, color: custom, useThemeBorderColor: false, hasBorder: true)),
      );
      final dec = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
      final border = dec.border as Border;
      expect(border.top.color, custom.withValues(alpha: 0.25));
    });

    testWidgets('useThemeBorderColor true with hasBorder false still no border', (tester) async {
      await tester.pumpWidget(
        wrapIcon(
          const PokaIcon(icon: Icons.home, useThemeBorderColor: true, hasBorder: false),
        ),
      );
      final dec = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
      expect(dec.border, isNull);
    });

    testWidgets('all shape and size combos render without error', (tester) async {
      for (final shape in PokaIconShape.values) {
        for (final size in PokaIconSize.values) {
          await tester.pumpWidget(
            wrapIcon(PokaIcon(icon: Icons.star, shape: shape, size: size)),
          );
          expect(find.byType(Icon), findsOneWidget);
          expect(find.byType(Container), findsOneWidget);
        }
      }
    });

    testWidgets('darkTheme also works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FTheme(data: darkTheme, child: child!),
          home: const Scaffold(
            body: Center(child: PokaIcon(icon: Icons.home)),
          ),
        ),
      );
      final phosphor = tester.widget<Icon>(find.byType(Icon));
      expect(phosphor.color, darkTheme.colors.primary);
    });

    testWidgets('hero circle with custom color and theme border', (tester) async {
      await tester.pumpWidget(
        wrapIcon(
          const PokaIcon(
            icon: Icons.rocket,
            shape: PokaIconShape.circle,
            size: PokaIconSize.hero,
            color: Colors.purple,
            hasBorder: true,
            useThemeBorderColor: true,
          ),
        ),
      );
      expect(tester.getSize(find.byType(Container)), const Size(64, 64));
      final dec = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
      expect(dec.shape, BoxShape.circle);
      expect(dec.border, isNotNull);
      expect((dec.border as Border).top.color, lightTheme.colors.border);
      expect(tester.widget<Icon>(find.byType(Icon)).size, 32);
    });

    testWidgets('small square no border with custom color', (tester) async {
      await tester.pumpWidget(
        wrapIcon(
          const PokaIcon(
            icon: Icons.wallet,
            shape: PokaIconShape.square,
            size: PokaIconSize.small,
            color: Colors.orange,
            hasBorder: false,
          ),
        ),
      );
      final dec = tester.widget<Container>(find.byType(Container)).decoration as BoxDecoration;
      expect(dec.border, isNull);
      expect(dec.borderRadius, BorderRadius.circular(10));
      expect(tester.getSize(find.byType(Container)), const Size(36, 36));
    });
  });
}
