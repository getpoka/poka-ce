import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/list/transaction_empty_period.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    await initializeDateFormatting('en');
  });

  Widget buildSubject({required TransactionListState state, required VoidCallback onToday}) {
    return FTheme(
      data: lightTheme,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: TransactionEmptyPeriod(state: state, onToday: onToday),
        ),
      ),
    );
  }

  group('TransactionEmptyPeriod', () {
    testWidgets('renders empty view with period label', (tester) async {
      final state = TransactionListState(
        focusedDate: DateTime.now(),
        transactions: const [],
        viewMode: TransactionViewMode.month,
      );

      await tester.pumpWidget(buildSubject(state: state, onToday: () {}));
      await tester.pumpAndSettle();

      expect(find.byType(PokaEmptyView), findsOneWidget);
      expect(find.text(t.transactions.noTransactions), findsOneWidget);
    });

    testWidgets('displays action button when not in current period and calls onToday', (tester) async {
      var onTodayCalled = false;
      final pastDate = DateTime(2020, 1, 1);
      final state = TransactionListState(
        focusedDate: pastDate,
        transactions: const [],
        viewMode: TransactionViewMode.month,
      );

      await tester.pumpWidget(
        buildSubject(
          state: state,
          onToday: () {
            onTodayCalled = true;
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(t.transactions.goToToday), findsOneWidget);
      await tester.tap(find.text(t.transactions.goToToday));
      await tester.pumpAndSettle();

      expect(onTodayCalled, isTrue);
    });
  });
}
