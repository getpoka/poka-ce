import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'daily_budget_notifier.g.dart';

@riverpod
class DailyBudget extends _$DailyBudget {
  static const _budgetKey = 'daily_budget';

  @override
  double build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getDouble(_budgetKey) ?? 0.0;
  }

  Future<void> setBudget(double amount) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setDouble(_budgetKey, amount);
    state = amount;
  }
}
