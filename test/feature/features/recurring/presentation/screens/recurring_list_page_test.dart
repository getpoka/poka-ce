import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/screens/recurring_list_page.dart';
import 'package:poka_ce/theme/theme.dart';

class MockRecurringListNotifier extends RecurringListNotifier {
  final List<RecurringTransactionModel> _initialRecurrings;
  final bool _loading;

  MockRecurringListNotifier(this._initialRecurrings, [this._loading = false]);

  @override
  RecurringListState build() {
    return RecurringListState(
      recurrings: _initialRecurrings,
      isLoading: _loading,
      error: null,
    );
  }
}

void main() {
  Widget buildTestApp(ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: FTheme(
        data: lightTheme,
        child: const MaterialApp(
          home: Scaffold(body: RecurringListPage()),
        ),
      ),
    );
  }

  testWidgets('RecurringListPage shows loading indicator when loading', (tester) async {
    final container = ProviderContainer(
      overrides: [
        recurringListProvider.overrideWith(() => MockRecurringListNotifier([], true)),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pump();
    expect(find.byType(FCircularProgress), findsOneWidget);
  });

  testWidgets('RecurringListPage shows empty state', (tester) async {
    final container = ProviderContainer(
      overrides: [
        recurringListProvider.overrideWith(() => MockRecurringListNotifier([], false)),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pumpAndSettle();

    // Just find the empty state text
    expect(find.text('No recurring transactions'), findsWidgets);
  });

  testWidgets('RecurringListPage shows populated state in active and inactive tabs', (tester) async {
    final recurringActive = RecurringTransactionModel(
      id: 'r1',
      accountId: 'a1',
      categoryId: 'c1',
      type: TransactionType.expense,
      amount: 1000,
      period: RecurringPeriod.monthly,
      nextDate: DateTime.now(),
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final recurringInactive = RecurringTransactionModel(
      id: 'r2',
      accountId: 'a2',
      categoryId: 'c2',
      type: TransactionType.income,
      amount: 2000,
      period: RecurringPeriod.weekly,
      nextDate: DateTime.now(),
      isActive: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final container = ProviderContainer(
      overrides: [
        recurringListProvider.overrideWith(
          () => MockRecurringListNotifier([recurringActive, recurringInactive], false),
        ),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pumpAndSettle();

    expect(find.byType(CustomScrollView), findsWidgets);
  });
}
