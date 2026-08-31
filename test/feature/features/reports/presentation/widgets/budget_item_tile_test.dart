import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_progress_provider.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budget_item_tile.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  BudgetModel budget(int amount) => BudgetModel(
    id: 'b1',
    name: 'Food',
    amount: amount,
    period: BudgetPeriod.monthly,
    startDate: DateTime(2026, 1, 1),
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );

  Widget wrap({required int spent, required int limit}) {
    return ProviderScope(
      overrides: [
        budgetProgressProvider.overrideWith((ref, arg) async => spent),
        balanceVisibilityProvider.overrideWithValue(true),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: BudgetItemTile(budget: budget(limit)),
            ),
          ),
        ),
      ),
    );
  }

  group('BudgetItemTile', () {
    testWidgets('shows progress percentage when under budget', (tester) async {
      await tester.pumpWidget(wrap(spent: 500, limit: 1000));
      await tester.pumpAndSettle();

      expect(find.text('Food'), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
      expect(find.text('Over budget'), findsNothing);
    });

    testWidgets('shows warning style when at 80%', (tester) async {
      await tester.pumpWidget(wrap(spent: 800, limit: 1000));
      await tester.pumpAndSettle();

      expect(find.text('80%'), findsOneWidget);
    });

    testWidgets('shows over budget chip when spending exceeds limit', (tester) async {
      await tester.pumpWidget(wrap(spent: 1500, limit: 1000));
      await tester.pumpAndSettle();

      expect(find.text('Over budget'), findsOneWidget);
    });
  });
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();
}
