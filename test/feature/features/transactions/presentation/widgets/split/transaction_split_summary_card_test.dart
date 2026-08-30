import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/split/transaction_split_summary_card.dart';
import 'package:poka_ce/theme/theme.dart';

class FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState(isLoading: false);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget(Widget child) {
    return ProviderScope(
      overrides: [
        settingsProvider.overrideWith(FakeSettingsNotifier.new),
      ],
      child: MaterialApp(
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: child!,
        ),
        home: Scaffold(body: child),
      ),
    );
  }

  group('TransactionSplitSummaryCard', () {
    testWidgets('renders correctly and handles callbacks', (tester) async {
      final splits = [
        SplitItem(id: '1', amount: 50, categoryId: 'c1'),
        SplitItem(id: '2', amount: 25, categoryId: 'c2'),
      ];

      bool editCalled = false;
      bool clearCalled = false;

      await tester.pumpWidget(
        buildTestableWidget(
          TransactionSplitSummaryCard(
            splits: splits,
            transactionType: TransactionType.expense,
            onEdit: () => editCalled = true,
            onClear: () => clearCalled = true,
          ),
        ),
      );

      // Verify title "2 split items"
      expect(find.text('2 split items'), findsOneWidget);

      // Verify amount (50 + 25)
      expect(find.textContaining('75'), findsOneWidget);

      // Verify edit button and tap
      await tester.tap(find.byIcon(FPhosphorIcons.pencilSimple));
      expect(editCalled, true);

      // Verify clear button and tap
      await tester.tap(find.byIcon(FPhosphorIcons.x));
      expect(clearCalled, true);

      await tester.pumpAndSettle();
    });
  });
}
