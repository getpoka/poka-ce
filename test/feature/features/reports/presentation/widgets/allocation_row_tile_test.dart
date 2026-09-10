import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/presentation/widgets/allocation_row_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap({bool? isVisible, bool isBalanceVisible = true}) {
    return ProviderScope(
      overrides: [
        balanceVisibilityProvider.overrideWithValue(isBalanceVisible),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AllocationRowTile(
                label: 'Needs',
                hint: '50%',
                amount: 5000,
                color: Colors.blue,
                ratio: 0.5,
                isVisible: isVisible,
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('AllocationRowTile', () {
    testWidgets('renders label, hint, ratio and compact amount', (tester) async {
      await tester.pumpWidget(wrap());

      expect(find.text('Needs'), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
      expect(find.text('50.0%'), findsOneWidget);
      expect(find.text('5.0K'), findsOneWidget);
    });

    testWidgets('obscures amount when balance visibility is false', (tester) async {
      await tester.pumpWidget(wrap(isBalanceVisible: false));

      expect(find.text('••••••'), findsOneWidget);
      expect(find.text('5.0K'), findsNothing);
    });

    testWidgets('respects explicit isVisible override parameter', (tester) async {
      await tester.pumpWidget(wrap(isVisible: false));

      expect(find.text('••••••'), findsOneWidget);
      expect(find.text('5.0K'), findsNothing);
    });
  });
}
