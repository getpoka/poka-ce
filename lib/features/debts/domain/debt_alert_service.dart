import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/domain/i_debt_repository.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Domain service that monitors unsettled debts/loans approaching due dates and schedules reminders.
class DebtAlertService {
  /// Creates a [DebtAlertService] with the provided [IDebtRepository].
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

        final isLoan = debt.type == DebtType.loan;
        final typeString = isLoan ? t.debts.debtTypeLoan : t.debts.debtTypeDebt;
        final actionString = isLoan ? t.debts.actionCollect : t.debts.actionPay;

        if (difference <= 3 && difference >= 0) {
          final whenString = difference == 0 ? t.debts.today : t.debts.inDays(days: difference);

          await notificationService.showNotification(
            id: debt.id.hashCode,
            title: t.debts.reminder(type: typeString, name: debt.personName),
            body: t.debts.reminderAlert(
              type: typeString,
              amount: debt.remainingAmount.toString(),
              action: actionString,
              when: whenString,
            ),
          );
        } else if (difference < 0) {
          await notificationService.showNotification(
            id: debt.id.hashCode,
            title: t.debts.due(type: typeString, name: debt.personName),
            body: t.debts.overdueAlert(
              type: typeString,
              amount: debt.remainingAmount.toString(),
              action: actionString,
            ),
          );
        }
      }
    } on Object catch (e, st) {
      talker.handle(e, st, 'DebtAlertService.checkAlerts');
    }
  }
}
