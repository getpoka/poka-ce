import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/features/debts/domain/debt_alert_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debt_alert_service_provider.g.dart';

/// Provides a singleton instance of [DebtAlertService] injected with the debt repository.
@riverpod
DebtAlertService debtAlertService(Ref ref) {
  final repo = ref.watch(debtRepositoryProvider);
  return DebtAlertService(debtRepository: repo);
}
