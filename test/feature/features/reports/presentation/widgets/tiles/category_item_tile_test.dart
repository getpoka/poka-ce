import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/widgets/tiles/category_item_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap(ReportCategoryItem item) {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: CategoryItemTile(item: item, rank: 1),
          ),
        ),
      ),
    );
  }

  group('CategoryItemTile', () {
    testWidgets('renders rank, name, amount and ratio', (tester) async {
      final item = ReportCategoryItem(
        name: 'Food',
        color: '#FF0000',
        amount: 1500,
        ratio: 0.5,
        txCount: 3,
      );
      await tester.pumpWidget(wrap(item));

      expect(find.text('1'), findsOneWidget);
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('1.5K'), findsOneWidget);
      expect(find.text('50.0%'), findsOneWidget);
    });

    testWidgets('falls back to theme color for invalid hex', (tester) async {
      final item = ReportCategoryItem(
        name: 'Broken',
        color: 'oops',
        amount: 100,
        ratio: 1.0,
        txCount: 1,
      );
      await tester.pumpWidget(wrap(item));

      expect(find.text('Broken'), findsOneWidget);
      expect(find.text('100.0%'), findsOneWidget);
    });
  });
}
