import 'package:flutter/foundation.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_alert_service_provider.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/shared/utils/math_evaluator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_form_notifier.g.dart';

@immutable
class TransactionFormArgs {
  const TransactionFormArgs({
    this.initialType,
    this.initialTransaction,
    this.initialAmount,
    this.initialNote,
    this.initialAccountId,
  });

  final TransactionType? initialType;
  final TransactionModel? initialTransaction;
  final String? initialAmount;
  final String? initialNote;
  final String? initialAccountId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionFormArgs &&
          runtimeType == other.runtimeType &&
          initialType == other.initialType &&
          initialTransaction == other.initialTransaction &&
          initialAmount == other.initialAmount &&
          initialNote == other.initialNote &&
          initialAccountId == other.initialAccountId;

  @override
  int get hashCode =>
      initialType.hashCode ^
      initialTransaction.hashCode ^
      initialAmount.hashCode ^
      initialNote.hashCode ^
      initialAccountId.hashCode;
}

@immutable
class TransactionFormState {
  const TransactionFormState({
    required this.type,
    required this.amountExpression,
    required this.note,
    required this.date,
    this.accountId,
    this.destinationAccountId,
    this.categoryId,
    this.allocation,
    this.splitItems,
    this.historyExpression,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  final TransactionType type;
  final String? accountId;
  final String? destinationAccountId;
  final String? categoryId;
  final String amountExpression;
  final String? historyExpression;
  final String note;
  final DateTime date;
  final TransactionAllocation? allocation;
  final List<SplitItem>? splitItems;

  final bool isLoading;
  final String? error;
  final bool isSuccess;

  TransactionFormState copyWith({
    TransactionType? type,
    String? Function()? accountId,
    String? Function()? destinationAccountId,
    String? Function()? categoryId,
    String? amountExpression,
    String? Function()? historyExpression,
    String? note,
    DateTime? date,
    TransactionAllocation? Function()? allocation,
    List<SplitItem>? Function()? splitItems,
    bool? isLoading,
    String? Function()? error,
    bool? isSuccess,
  }) {
    return TransactionFormState(
      type: type ?? this.type,
      accountId: accountId != null ? accountId() : this.accountId,
      destinationAccountId: destinationAccountId != null ? destinationAccountId() : this.destinationAccountId,
      categoryId: categoryId != null ? categoryId() : this.categoryId,
      amountExpression: amountExpression ?? this.amountExpression,
      historyExpression: historyExpression != null ? historyExpression() : this.historyExpression,
      note: note ?? this.note,
      date: date ?? this.date,
      allocation: allocation != null ? allocation() : this.allocation,
      splitItems: splitItems != null ? splitItems() : this.splitItems,
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

@riverpod
class TransactionFormNotifier extends _$TransactionFormNotifier {
  @override
  TransactionFormState build(TransactionFormArgs args) {
    final initialTransaction = args.initialTransaction;
    final isInitialSplit = initialTransaction != null && initialTransaction.items.length > 1;
    final initialSplits = isInitialSplit
        ? initialTransaction.items
              .map(
                (i) => SplitItem(
                  categoryId: i.categoryId,
                  amount: i.amount,
                  note: i.note,
                  allocation: i.allocation,
                ),
              )
              .toList()
        : null;

    final initialAllocation = initialTransaction != null && initialTransaction.items.isNotEmpty
        ? initialTransaction.items.first.allocation
        : null;

    final initialDate = initialTransaction?.transactionDate.toLocal() ?? DateTime.now();

    return TransactionFormState(
      type: initialTransaction?.type ?? args.initialType ?? TransactionType.expense,
      amountExpression: initialTransaction?.amount.toString() ?? args.initialAmount ?? '',
      note: initialTransaction?.note ?? args.initialNote ?? '',
      date: initialDate,
      accountId: initialTransaction?.accountId ?? args.initialAccountId,
      destinationAccountId: initialTransaction?.destinationAccountId,
      categoryId: initialTransaction?.items.isNotEmpty == true ? initialTransaction?.items.first.categoryId : null,
      allocation: initialAllocation,
      splitItems: initialSplits,
    );
  }

  // ─── Mutations ─────────────────────────────────────────────────────────────

  void setType(TransactionType type) {
    state = state.copyWith(
      type: type,
      splitItems: type != TransactionType.expense ? () => null : null,
    );
  }

  void setAccount(String id) => state = state.copyWith(accountId: () => id);
  void setDestinationAccount(String id) => state = state.copyWith(destinationAccountId: () => id);
  void setCategory(String? id) => state = state.copyWith(categoryId: () => id);
  void setNote(String note) => state = state.copyWith(note: note);
  void setDate(DateTime date) => state = state.copyWith(date: date);
  void setAllocation(TransactionAllocation? allocation) => state = state.copyWith(allocation: () => allocation);

  void setSplitItems(List<SplitItem>? items) {
    if (items == null) {
      state = state.copyWith(
        splitItems: () => null,
        amountExpression: '',
        historyExpression: () => null,
      );
      return;
    }

    final total = items.fold<int>(0, (sum, item) => sum + item.amount);
    state = state.copyWith(
      splitItems: () => items,
      amountExpression: total.toString(),
      historyExpression: () => null,
    );
  }

  void swapAccounts() {
    final temp = state.accountId;
    state = state.copyWith(
      accountId: () => state.destinationAccountId,
      destinationAccountId: () => temp,
    );
  }

  // ─── Numpad Logic ──────────────────────────────────────────────────────────

  void onKeyPressed(String key) {
    if (key == 'OK') return;

    if (key == '=') {
      final snapshot = state.amountExpression;
      final result = MathEvaluator.evaluate(snapshot);
      if (result != null && result != snapshot) {
        state = state.copyWith(
          amountExpression: result,
          historyExpression: () => null,
        );
      }
      return;
    }

    final newExpression = MathEvaluator.handleKeyPress(state.amountExpression, key);

    String? history;
    if (newExpression != state.amountExpression && MathEvaluator.hasUnresolvedOperator(newExpression)) {
      history = MathEvaluator.evaluate(newExpression);
    }

    state = state.copyWith(
      amountExpression: newExpression,
      historyExpression: () => history,
    );
  }

  // ─── Save ──────────────────────────────────────────────────────────────────

  Future<void> save() async {
    final isSplit = state.splitItems != null;

    if (isSplit) {
      await _handleSplitSave();
    } else {
      await _handleSimpleSave();
    }
  }

  Future<void> _handleSimpleSave() async {
    final amount = int.tryParse(state.amountExpression) ?? 0;
    if (amount <= 0) return;
    final catId = state.type == TransactionType.transfer ? state.destinationAccountId : state.categoryId;
    if (state.type == TransactionType.transfer && catId == null) return;
    if (state.accountId == null) return;

    state = state.copyWith(isLoading: true, isSuccess: false);

    try {
      final Result<TransactionModel, Failure> result;

      if (state.type == TransactionType.transfer) {
        if (args.initialTransaction != null) {
          result = await ref
              .read(updateTransactionUseCaseProvider)
              .execute(
                args.initialTransaction!,
                type: state.type,
                accountId: state.accountId!,
                destinationAccountId: catId,
                amount: amount,
                note: state.note.isNotEmpty ? state.note : null,
                transactionDate: state.date,
              );
        } else {
          result = await ref
              .read(transferFundsUseCaseProvider)
              .execute(
                amount: amount,
                sourceAccountId: state.accountId!,
                destinationAccountId: catId!, // Reusing categoryId as destination for transfer
                note: state.note.isNotEmpty ? state.note : null,
              );
        }
      } else {
        if (args.initialTransaction != null) {
          result = await ref
              .read(updateTransactionUseCaseProvider)
              .execute(
                args.initialTransaction!,
                amount: amount,
                type: state.type,
                accountId: state.accountId!,
                categoryId: catId,
                note: state.note.isNotEmpty ? state.note : null,
                transactionDate: state.date,
                allocation: state.allocation,
              );
        } else {
          result = await ref
              .read(createTransactionUseCaseProvider)
              .execute(
                amount: amount,
                type: state.type,
                accountId: state.accountId!,
                categoryId: catId,
                note: state.note.isNotEmpty ? state.note : null,
                transactionDate: state.date,
                allocation: state.allocation,
              );
        }
      }

      result.fold(
        (success) {
          state = state.copyWith(isLoading: false, isSuccess: true);
          if (state.type == TransactionType.expense) {
            ref.read(budgetAlertServiceProvider).checkAlerts();
          }
        },
        (failure) {
          state = state.copyWith(isLoading: false, error: () => failure.message);
        },
      );
    } on Exception catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString);
    }
  }

  Future<void> _handleSplitSave() async {
    final items = state.splitItems;
    if (items == null || items.length < 2) return;
    if (items.any((e) => e.amount <= 0)) return;
    if (state.accountId == null) return;

    state = state.copyWith(isLoading: true, isSuccess: false);

    try {
      final splitData = items
          .map((e) => (categoryId: e.categoryId, amount: e.amount, note: e.note, allocation: e.allocation))
          .toList();

      final Result<TransactionModel, Failure> result;

      if (args.initialTransaction != null) {
        result = await ref
            .read(updateTransactionUseCaseProvider)
            .execute(
              args.initialTransaction!,
              type: state.type,
              accountId: state.accountId!,
              transactionDate: state.date,
              splitItems: splitData,
            );
      } else {
        result = await ref
            .read(createTransactionUseCaseProvider)
            .execute(
              amount: 0, // amount is ignored when splitItems is provided
              type: state.type,
              accountId: state.accountId!,
              transactionDate: state.date,
              splitItems: splitData,
            );
      }

      result.fold(
        (success) {
          state = state.copyWith(isLoading: false, isSuccess: true);
          if (state.type == TransactionType.expense) {
            ref.read(budgetAlertServiceProvider).checkAlerts();
          }
        },
        (failure) {
          state = state.copyWith(isLoading: false, error: () => failure.message);
        },
      );
    } on Exception catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString);
    }
  }
}
