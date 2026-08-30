import 'package:flutter/material.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debt_detail_notifier.g.dart';

@riverpod
Stream<List<TransactionModel>> debtTransactions(Ref ref, DebtModel debt) {
  return ref
      .read(transactionRepositoryProvider)
      .watchTransactions(
        debtIds: {debt.id},
      )
      .map((result) {
        return switch (result) {
          Success(value: final transactions) => transactions,
          ErrorResult(error: final failure) => throw Exception(failure.toString()),
        };
      });
}

@Riverpod(keepAlive: true)
class DebtDetailNotifier extends _$DebtDetailNotifier {
  @override
  void build() {
    // Intentionally left blank
  }

  Future<bool> deleteDebt(BuildContext context, DebtModel debt) async {
    final isPayable = debt.type == DebtType.debt;
    final confirm = await showPokaConfirmDialog(
      context,
      title: t.debts.deleteDebt,
      body:
          'Are you sure you want to delete this ${isPayable ? "debt" : "loan"}? Its record will be permanently deleted. This action cannot be undone.',
      confirmText: t.debts.delete,
    );

    if (confirm == true) {
      await ref.read(debtListProvider.notifier).deleteDebt(debt.id);
      return true;
    }
    return false;
  }

  Future<bool> writeOffDebt(BuildContext context, DebtModel debt) async {
    final confirm = await showPokaConfirmDialog(
      context,
      title: t.debts.writeoffDebt,
      body: t.debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances,
      confirmText: t.debts.writeoff,
    );

    if (confirm == true) {
      final updatedDebt = debt.copyWith(
        remainingAmount: 0,
        status: DebtStatus.paid,
      );
      await ref.read(debtRepositoryProvider).updateDebt(updatedDebt);
      return true;
    }
    return false;
  }
}
