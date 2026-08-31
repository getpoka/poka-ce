import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_progress_provider.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_budget_utilization.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  BudgetModel budget(String id, String name, int amount) => BudgetModel(
    id: id,
    name: name,
    amount: amount,
    period: BudgetPeriod.monthly,
    startDate: DateTime(2026, 1, 1),
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );

  Widget wrap({
    required List<BudgetModel> budgets,
    int spent = 0,
  }) {
    return ProviderScope(
      overrides: [
        reportProvider.overrideWithValue(
          ReportState(isLoading: false, budgets: budgets),
        ),
        budgetProgressProvider.overrideWith((ref, arg) async => spent),
        balanceVisibilityProvider.overrideWithValue(true),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ReportBudgetUtilization(),
            ),
          ),
        ),
      ),
    );
  }

  group('ReportBudgetUtilization', () {
    testWidgets('shows empty state when no budgets configured', (tester) async {
      await tester.pumpWidget(wrap(budgets: []));
      await tester.pumpAndSettle();

      expect(find.text('No budgets configured'), findsOneWidget);
      expect(find.text('Add budgets to track your spending limits'), findsOneWidget);
    });

    testWidgets('renders overall utilization and individual budget tiles', (tester) async {
      await tester.pumpWidget(
        wrap(budgets: [budget('b1', 'Groceries', 1000)], spent: 500),
      );
      await tester.pumpAndSettle();

      expect(find.text('Groceries'), findsOneWidget);
      expect(find.textContaining('50.0% Spent'), findsOneWidget);
      expect(find.text('Remaining'), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
    });

    testWidgets('marks overall progress as danger when over budget', (tester) async {
      await tester.pumpWidget(
        wrap(budgets: [budget('b1', 'Groceries', 1000)], spent: 1500),
      );
      await tester.pumpAndSettle();

      expect(find.text('Over budget'), findsOneWidget);
    });
  });
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();
}
