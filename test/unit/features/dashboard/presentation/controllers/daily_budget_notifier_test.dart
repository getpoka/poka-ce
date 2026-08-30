import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/daily_budget_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DailyBudgetNotifier', () {
    Future<ProviderContainer> createContainer() async {
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      addTearDown(container.dispose);
      return container;
    }

    test('build returns 0.0 when no saved budget', () async {
      SharedPreferences.setMockInitialValues({});
      final container = await createContainer();
      final value = await container.read(dailyBudgetProvider);
      expect(value, 0.0);
    });

    test('build returns saved budget from prefs', () async {
      SharedPreferences.setMockInitialValues({'daily_budget': 50000.0});
      final container = await createContainer();
      final value = await container.read(dailyBudgetProvider);
      expect(value, 50000.0);
    });

    test('setBudget persists and updates state (mutation: setDouble)', () async {
      SharedPreferences.setMockInitialValues({});
      final container = await createContainer();
      // init
      await container.read(dailyBudgetProvider);
      await container.read(dailyBudgetProvider.notifier).setBudget(25000);
      // Verify via prefs directly (mutation kills if not persisted)
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getDouble('daily_budget'), 25000);
      expect(container.read(dailyBudgetProvider), 25000);
    });

    test('setBudget handles zero and overwrites', () async {
      SharedPreferences.setMockInitialValues({'daily_budget': 100.0});
      final container = await createContainer();
      await container.read(dailyBudgetProvider);
      await container.read(dailyBudgetProvider.notifier).setBudget(0);
      expect(container.read(dailyBudgetProvider), 0.0);
    });
  });
}
