import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/features/budgets/domain/budget_alert_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_alert_service_provider.g.dart';

@riverpod
BudgetAlertService budgetAlertService(Ref ref) {
  final repo = ref.watch(budgetRepositoryProvider);
  return BudgetAlertService(budgetRepository: repo);
}
