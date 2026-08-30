import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/domain/i_debt_repository.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class DebtAlertService {
  const DebtAlertService({
    required IDebtRepository debtRepository,
  }) : _debtRepo = debtRepository;

  final IDebtRepository _debtRepo;

  /// Checks for debts that are due within the next 3 days or already overdue,
  /// and triggers a local notification.
  Future<void> checkAlerts() async {
    try {
      final debtsResult = await _debtRepo.getDebts();
      if (debtsResult is! Success<List<DebtModel>, Failure>) return;

      final debts = debtsResult.value;
      final now = DateTime.now();
      // Normalize to start of day for comparison
      final today = DateTime(now.year, now.month, now.day);

      for (final debt in debts) {
        if (debt.status == DebtStatus.paid || debt.dueDate == null) continue;

        final dueDate = debt.dueDate;
        if (dueDate == null) continue; // Safety check
        final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);

        final difference = dueDay.difference(today).inDays;

        if (difference <= 3 && difference >= 0) {
          final typeString = debt.type == DebtType.loan ? 'Piutang' : 'Hutang';
          final actionString = debt.type == DebtType.loan ? 'ditagih' : 'dibayar';
          final whenString = difference == 0 ? 'hari ini' : 'dalam $difference hari';

          await notificationService.showNotification(
            id: debt.id.hashCode,
            title: t.debts.reminder(type: typeString, name: debt.personName),
            body: '$typeString sejumlah ${debt.remainingAmount} harus $actionString $whenString.',
          );
        } else if (difference < 0) {
          final typeString = debt.type == DebtType.loan ? 'Piutang' : 'Hutang';
          final actionString = debt.type == DebtType.loan ? 'ditagih' : 'dibayar';

          await notificationService.showNotification(
            id: debt.id.hashCode,
            title: t.debts.due(type: typeString, name: debt.personName),
            body:
                '$typeString sejumlah ${debt.remainingAmount} telah lewat jatuh tempo dan harus segera $actionString.',
          );
        }
      }
    } on Object catch (e, st) {
      talker.handle(e, st, 'DebtAlertService.checkAlerts');
    }
  }
}
