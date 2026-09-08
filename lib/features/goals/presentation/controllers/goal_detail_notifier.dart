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

/// Watches transactions associated with the goal's linked pocket account (deposits and withdrawals).
@riverpod
Stream<List<TransactionModel>> goalTransactions(Ref ref, GoalModel goal) {
  return ref
      .read(transactionRepositoryProvider)
      .watchTransactions(
        accountIds: {goal.accountId},
      )
      .asyncMap((result) {
        return switch (result) {
          Success(value: final transactions) => transactions,
          ErrorResult(error: final failure) => Future.error(failure, StackTrace.current),
        };
      });
}

/// Notifier coordinating goal detail actions such as deletion and goal fulfillment.
@Riverpod(keepAlive: true)
class GoalDetailNotifier extends _$GoalDetailNotifier {
  @override
  void build() {
    // Intentionally left blank as this notifier primarily provides methods
  }

  /// Verifies the pocket has zero balance before prompting deletion confirmation.
  Future<bool> deleteGoal(BuildContext context, GoalModel goal, {required int currentBalance}) async {
    // Protect funds: forbid deleting a goal pocket if it still contains positive balance
    if (currentBalance > 0) {
      if (context.mounted) {
        await showPokaConfirmDialog(
          context,
          title: t.goals.actionDenied,
          body: t.goals.emptyBalanceBeforeDelete,
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

  /// Opens the expense transaction form to spend the saved goal amount and marks the goal as completed.
  Future<bool> fulfillGoal(BuildContext context, GoalModel goal) async {
    // Fulfill savings goal by spending the target balance as an expense from the goal pocket and marking goal completed
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
