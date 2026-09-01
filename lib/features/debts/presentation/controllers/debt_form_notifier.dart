import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'debt_form_notifier.freezed.dart';
part 'debt_form_notifier.g.dart';

@freezed
abstract class DebtFormState with _$DebtFormState {
  const factory DebtFormState({
    DebtModel? initialDebt,
    @Default('') String accountId,
    @Default('') String categoryId,
    @Default('') String personName,
    @Default(DebtType.debt) DebtType type,
    @Default(0) int amount,
    @Default(DebtStatus.active) DebtStatus status,
    DateTime? dueDate,
    String? note,
    @Default(false) bool isSaving,
    @Default(false) bool isSuccess,
    String? error,
  }) = _DebtFormState;
}

@riverpod
class DebtForm extends _$DebtForm {
  @override
  DebtFormState build() {
    return const DebtFormState();
  }

  void init(DebtModel? debt) {
    if (debt != null) {
      state = DebtFormState(
        initialDebt: debt,
        personName: debt.personName,
        type: debt.type,
        amount: debt.amount,
        status: debt.status,
        dueDate: debt.dueDate,
        note: debt.note,
      );
    } else {
      state = const DebtFormState();
    }
  }

  void setAccountId(String id) => state = state.copyWith(accountId: id);
  void setCategoryId(String id) => state = state.copyWith(categoryId: id);
  void setPersonName(String name) => state = state.copyWith(personName: name);
  void setType(DebtType type) => state = state.copyWith(type: type);
  void setAmount(int amount) => state = state.copyWith(amount: amount);
  void setStatus(DebtStatus status) => state = state.copyWith(status: status);
  void setDueDate(DateTime? dueDate) => state = state.copyWith(dueDate: dueDate);
  void setNote(String? note) => state = state.copyWith(note: note);

  Future<void> save() async {
    if (state.personName.trim().isEmpty) {
      state = state.copyWith(error: 'Person name cannot be empty', isSaving: false);
      return;
    }
    if (state.amount <= 0) {
      state = state.copyWith(error: 'Amount must be greater than 0', isSaving: false);
      return;
    }
    state = state.copyWith(
      isSaving: true,
      error: null,
    );
    final repo = ref.read(debtRepositoryProvider);

    final now = DateTimeUtils.nowUtc();
    final model =
        state.initialDebt?.copyWith(
          personName: state.personName.trim(),
          type: state.type,
          amount: state.amount,
          status: state.status,
          dueDate: state.dueDate,
          note: state.note,
          updatedAt: now,
        ) ??
        DebtModel(
          id: const Uuid().v7(),
          personName: state.personName.trim(),
          type: state.type,
          amount: state.amount,
          remainingAmount: state.amount,
          status: state.status,
          dueDate: state.dueDate,
          note: state.note,
          createdAt: now,
          updatedAt: now,
        );

    final result = state.initialDebt == null
        ? await repo.createDebt(model, state.accountId, state.categoryId)
        : await repo.updateDebt(model);

    switch (result) {
      case Success():
        state = state.copyWith(isSaving: false, isSuccess: true);
      case ErrorResult(error: final failure):
        state = state.copyWith(
          error: failure.message,
          isSaving: false,
        );
    }
  }
}
