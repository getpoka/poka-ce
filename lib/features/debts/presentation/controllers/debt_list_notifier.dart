import 'package:flutter/material.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debt_list_notifier.g.dart';

@riverpod
class DebtList extends _$DebtList {
  @override
  Stream<List<DebtModel>> build() {
    final repo = ref.read(debtRepositoryProvider);
    return repo.watchDebts();
  }

  Future<void> deleteDebt(String id) async {
    final repo = ref.read(debtRepositoryProvider);
    await repo.deleteDebt(id);
  }

  Future<void> deleteDebtWithConfirmation(BuildContext context, DebtModel debt) async {
    final isPayable = debt.type == DebtType.debt;
    final confirm = await showPokaConfirmDialog(
      context,
      title: t.debts.deleteDebt,
      body:
          'Are you sure you want to delete this ${isPayable ? "debt" : "loan"}? Its record will be permanently deleted. This action cannot be undone.',
      confirmText: t.debts.delete,
    );
    if (confirm == true) {
      await deleteDebt(debt.id);
    }
  }
}
