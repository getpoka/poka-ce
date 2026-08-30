import 'package:flutter/material.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goal_detail_notifier.g.dart';

@riverpod
Stream<List<TransactionModel>> goalTransactions(Ref ref, GoalModel goal) {
  return ref
      .read(transactionRepositoryProvider)
      .watchTransactions(
        accountIds: {goal.accountId},
      )
      .map((result) {
        return switch (result) {
          Success(value: final transactions) => transactions,
          ErrorResult(error: final failure) => throw Exception(failure.toString()),
        };
      });
}

@Riverpod(keepAlive: true)
class GoalDetailNotifier extends _$GoalDetailNotifier {
  @override
  void build() {
    // Intentionally left blank as this notifier primarily provides methods
  }

  Future<bool> deleteGoal(BuildContext context, GoalModel goal, {required int currentBalance}) async {
    if (currentBalance > 0) {
      if (context.mounted) {
        await showPokaConfirmDialog(
          context,
          title: t.goals.actionDenied,
          body: t.goals.kosongkanSaldoTransferKeluarSebelumMenghapusGoalIni,
          confirmText: t.goals.ok,
        );
      }
      return false;
    }

    if (!context.mounted) return false;

    final confirm = await showPokaConfirmDialog(
      context,
      title: t.goals.deleteGoal,
      body: t
          .goals
          .areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone,
      confirmText: t.goals.delete,
    );

    if (confirm == true) {
      await ref.read(goalProvider.notifier).deleteGoal(goal.id);
      return true;
    }
    return false;
  }

  Future<bool> fulfillGoal(BuildContext context, GoalModel goal) async {
    final saved = await TransactionFormSheet.show(
      context,
      initialType: TransactionType.expense,
      initialAccountId: goal.accountId,
      initialAmount: goal.targetAmount.toString(),
      initialNote: 'Fulfill Goal: ${goal.name}',
    );

    if (saved == true) {
      final updatedGoal = goal.copyWith(status: GoalStatus.completed);
      await ref.read(goalProvider.notifier).updateGoal(updatedGoal);
      return true;
    }
    return false;
  }
}
