import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/shared/utils/math_evaluator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debt_repayment_notifier.g.dart';

/// UI state capturing repayment form values, calculator expression, and execution status.
class DebtRepaymentState {
  /// Creates a [DebtRepaymentState].
  const DebtRepaymentState({
    required this.date,
    this.accountId,
    this.amountExpression = '',
    this.historyExpression,
    this.note = '',
    this.isSaving = false,
  });

  /// Selected wallet account used to pay or receive the installment.
  final String? accountId;

  /// Active keypad expression or parsed number string.
  final String amountExpression;

  /// Evaluated preview of incomplete arithmetic expressions.
  final String? historyExpression;

  /// Optional memo or transaction description.
  final String note;

  /// Effective date of the repayment.
  final DateTime date;

  /// Whether the repayment transaction is currently being processed.
  final bool isSaving;

  /// Creates a copy of this state with specified parameters updated.
  DebtRepaymentState copyWith({
    String? accountId,
    String? amountExpression,
    String? historyExpression,
    bool clearHistoryExpression = false,
    String? note,
    DateTime? date,
    bool? isSaving,
  }) {
    return DebtRepaymentState(
      accountId: accountId ?? this.accountId,
      amountExpression: amountExpression ?? this.amountExpression,
      historyExpression: clearHistoryExpression ? null : (historyExpression ?? this.historyExpression),
      note: note ?? this.note,
      date: date ?? this.date,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

/// Notifier driving the debt/loan repayment sheet and keypad calculator.
@riverpod
class DebtRepaymentNotifier extends _$DebtRepaymentNotifier {
  @override
  DebtRepaymentState build() {
    return DebtRepaymentState(date: DateTime.now());
  }

  /// Sets the account paying or receiving the repayment.
  void setAccountId(String id) => state = state.copyWith(accountId: id);

  /// Sets the raw numeric amount expression string.
  void setAmountExpression(String expr) => state = state.copyWith(amountExpression: expr);

  /// Sets or clears the calculated preview formula expression.
  void setHistoryExpression(String? expr) {
    if (expr == null) {
      state = state.copyWith(clearHistoryExpression: true);
    } else {
      state = state.copyWith(historyExpression: expr);
    }
  }

  /// Sets the custom note for the repayment transaction.
  void setNote(String note) => state = state.copyWith(note: note);

  /// Sets the payment transaction timestamp.
  void setDate(DateTime value) => state = state.copyWith(date: value);

  /// Processes calculator keypad key presses (digits, operators, evaluate).
  void onKeyPressed(String key) {
    if (key == 'OK') {
      // Evaluation is handled by evaluate() on "=" before OK usually,
      // but if the user just hits OK, we don't evaluate here, the UI triggers saveRepayment.
      return;
    }

    // Evaluate if user presses '='
    if (key == '=') {
      final snapshot = state.amountExpression;
      final result = MathEvaluator.evaluate(snapshot);
      if (result != null && result != snapshot) {
        state = state.copyWith(
          amountExpression: result,
          clearHistoryExpression: true, // clear history since we just evaluated
        );
      }
      return;
    }

    final newExpression = MathEvaluator.handleKeyPress(state.amountExpression, key);

    // Auto-calculate history preview
    String? history;
    if (newExpression != state.amountExpression && MathEvaluator.hasUnresolvedOperator(newExpression)) {
      history = MathEvaluator.evaluate(newExpression);
    }

    state = state.copyWith(
      amountExpression: newExpression,
      historyExpression: history,
    );
  }

  /// Records the repayment transaction and reduces the debt's outstanding balance.
  Future<bool> saveRepayment({required DebtModel debt}) async {
    if (state.accountId == null) return false;
    final amount = int.tryParse(state.amountExpression) ?? 0;
    if (amount <= 0) return false;

    state = state.copyWith(isSaving: true);
    // Repaying a debt subtracts cash from wallet (expense), receiving loan payment adds cash (income)
    final isPayable = debt.type == DebtType.debt;
    final transactionType = isPayable ? TransactionType.expense : TransactionType.income;

    try {
      final result = await ref
          .read(createTransactionUseCaseProvider)
          .execute(
            type: transactionType,
            accountId: state.accountId!,
            amount: amount,
            debtId: debt.id,
            note: state.note.isNotEmpty ? state.note : 'Repayment for ${debt.personName}',
            transactionDate: state.date,
          );

      return await result.fold(
        (success) async {
          await ref.read(dashboardProvider.notifier).refresh();
          state = state.copyWith(isSaving: false);
          return true;
        },
        (failure) async {
          state = state.copyWith(isSaving: false);
          return false;
        },
      );
    } on Exception catch (_) {
      state = state.copyWith(isSaving: false);
      return false;
    }
  }
}
