import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/list/transaction_list_summary_card.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

class FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState(isLoading: false);
}

class FakeBalanceVisibilityNotifier extends BalanceVisibility {
  @override
  bool build() => true;
}

void main() {
  Widget buildSubject(TransactionListState state) {
    return ProviderScope(
      overrides: [
        settingsProvider.overrideWith(FakeSettingsNotifier.new),
        balanceVisibilityProvider.overrideWith(FakeBalanceVisibilityNotifier.new),
      ],
      child: FTheme(
        data: lightTheme,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            body: SingleChildScrollView(
              child: TransactionListSummaryCard(state: state),
            ),
          ),
        ),
      ),
    );
  }

  group('TransactionListSummaryCard', () {
    testWidgets('renders empty state correctly', (tester) async {
      final state = TransactionListState(
        focusedDate: DateTime(2023, 10, 15),
        transactions: const [],
        viewMode: TransactionViewMode.month,
      );

      await tester.pumpWidget(buildSubject(state));

      expect(find.text('0 transactions'), findsOneWidget);
      expect(find.text('Monthly'), findsOneWidget);
      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
    });

    testWidgets('shows filter pill when filter is active', (tester) async {
      final state = TransactionListState(
        focusedDate: DateTime(2023, 10, 15),
        filter: const TransactionFilter(types: {TransactionType.expense}),
      );

      await tester.pumpWidget(buildSubject(state));

      expect(find.text('Filtered'), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.funnelSimple), findsOneWidget);
    });
  });
}
