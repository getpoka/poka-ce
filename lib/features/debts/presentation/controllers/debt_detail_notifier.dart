import 'package:flutter/widgets.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debt_detail_notifier.g.dart';

/// Watches transactions linked to the specified [debt] (disbursements and repayments).
@riverpod
Stream<List<TransactionModel>> debtTransactions(Ref ref, DebtModel debt) {
  return ref
      .read(transactionRepositoryProvider)
      .watchTransactions(
        debtIds: {debt.id},
      )
      .asyncMap((result) {
        return switch (result) {
          Success(value: final transactions) => transactions,
          ErrorResult(error: final failure) => Future.error(failure, StackTrace.current),
        };
      });
}

/// Notifier handling detail-level actions on debts including deletion and forgiveness write-offs.
@Riverpod(keepAlive: true)
class DebtDetailNotifier extends _$DebtDetailNotifier {
  @override
  void build() {
    // Intentionally left blank
  }

  /// Prompts confirmation to delete the debt and cascades transaction reversal.
  Future<bool> deleteDebt(BuildContext context, DebtModel debt) async {
    final isPayable = debt.type == DebtType.debt;
    final confirm = await showPokaConfirmDialog(
      context,
      title: t.debts.deleteDebt,
      body: t.debts.deleteConfirm(
        type: isPayable ? t.debts.debtTypeDebt.toLowerCase() : t.debts.debtTypeLoan.toLowerCase(),
      ),
      confirmText: t.debts.delete,
    );

    if (confirm == true) {
      await ref.read(debtListProvider.notifier).deleteDebt(debt.id);
      return true;
    }
    return false;
  }

  /// Writes off an unsettled debt/loan, marking it paid without recording wallet mutations.
  Future<bool> writeOffDebt(BuildContext context, DebtModel debt) async {
    final confirm = await showPokaConfirmDialog(
      context,
      title: t.debts.writeoffDebt,
      body: t.debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances,
      confirmText: t.debts.writeoff,
    );

    if (confirm == true) {
      // Forgive or write off remaining amount without affecting wallet balance or creating phantom cash flow
      final updatedDebt = debt.copyWith(
        remainingAmount: 0,
        status: DebtStatus.paid,
      );
      await ref.read(debtRepositoryProvider).updateDebt(updatedDebt);
      return true;
    }
    return false;
  }

  /// Deletes a repayment transaction by its [transactionId] linked to this debt, reversing the balance mutation.
  Future<Result<void, Failure>> deleteRepayment(String transactionId) async {
    final result = await ref.read(transactionRepositoryProvider).deleteTransaction(transactionId);
    if (result case Success()) {
      ref
        ..invalidate(debtListProvider)
        ..invalidate(dashboardProvider)
        ..invalidate(accountListProvider)
        ..invalidate(transactionListNotifierProvider);
    }
    return result;
  }
}
