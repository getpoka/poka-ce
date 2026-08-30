import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile_icon.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  Widget buildSubject({
    required Color catColor,
    required IconData catIcon,
    IconData? subCatIcon,
    Color? subCatColor,
    bool isGroup = false,
    bool isExpanded = false,
    bool isSmall = false,
  }) {
    return FTheme(
      data: lightTheme,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TransactionTileIcon(
          catColor: catColor,
          catIcon: catIcon,
          subCatIcon: subCatIcon,
          subCatColor: subCatColor,
          isGroup: isGroup,
          isExpanded: isExpanded,
          isSmall: isSmall,
        ),
      ),
    );
  }

  group('TransactionTileIcon', () {
    testWidgets('renders basic PokaIcon', (tester) async {
      await tester.pumpWidget(
        buildSubject(
          catColor: Colors.blue,
          catIcon: FPhosphorIcons.car,
        ),
      );

      expect(find.byType(PokaIcon), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.car), findsOneWidget);
    });

    testWidgets('renders sub-category badge when subCatIcon is provided', (tester) async {
      await tester.pumpWidget(
        buildSubject(
          catColor: Colors.blue,
          catIcon: FPhosphorIcons.car,
          subCatIcon: FPhosphorIcons.gasPump,
          subCatColor: Colors.red,
        ),
      );

      // Both the main icon and the subcategory badge icon should exist.
      expect(find.byIcon(FPhosphorIcons.car), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.gasPump), findsOneWidget);
    });

    testWidgets('renders group caret when isGroup is true', (tester) async {
      await tester.pumpWidget(
        buildSubject(
          catColor: Colors.blue,
          catIcon: FPhosphorIcons.car,
          isGroup: true,
        ),
      );

      expect(find.byIcon(FPhosphorIcons.caretDown), findsOneWidget);
    });

    testWidgets('caret rotation is applied when isExpanded is true', (tester) async {
      await tester.pumpWidget(
        buildSubject(
          catColor: Colors.blue,
          catIcon: FPhosphorIcons.car,
          isGroup: true,
          isExpanded: true,
        ),
      );

      final rotationFinder = find.byType(AnimatedRotation);
      expect(rotationFinder, findsOneWidget);
      final AnimatedRotation rotation = tester.widget(rotationFinder);
      expect(rotation.turns, 0.5);
    });
  });
}
