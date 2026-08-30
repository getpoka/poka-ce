import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'recurring_form_notifier.freezed.dart';
part 'recurring_form_notifier.g.dart';

@freezed
abstract class RecurringFormState with _$RecurringFormState {
  const factory RecurringFormState({
    RecurringTransactionModel? initialRecurring,
    @Default(TransactionType.expense) TransactionType type,
    @Default(0) int amount,
    @Default(RecurringPeriod.monthly) RecurringPeriod period,
    @Default('') String accountId,
    String? destinationAccountId,
    String? categoryId,
    TransactionAllocation? allocation,
    String? note,
    @Default(true) bool isActive,
    DateTime? nextDate,
    @Default(false) bool isSaving,
    @Default(false) bool isSuccess,
    String? error,
  }) = _RecurringFormState;
}

@riverpod
class RecurringFormNotifier extends _$RecurringFormNotifier {
  @override
  RecurringFormState build() {
    return const RecurringFormState();
  }

  void init(RecurringTransactionModel? recurring) {
    if (recurring != null) {
      state = RecurringFormState(
        initialRecurring: recurring,
        type: recurring.type,
        amount: recurring.amount,
        period: recurring.period,
        accountId: recurring.accountId,
        destinationAccountId: recurring.destinationAccountId,
        categoryId: recurring.categoryId,
        allocation: recurring.allocation,
        note: recurring.note,
        isActive: recurring.isActive,
        nextDate: recurring.nextDate,
      );
    } else {
      state = const RecurringFormState();
    }
  }

  void setType(TransactionType type) {
    // Clear category when switching to/from transfer (transfers have no category).
    final clearCategory = type == TransactionType.transfer || state.type == TransactionType.transfer;
    state = state.copyWith(
      type: type,
      categoryId: clearCategory ? null : state.categoryId,
      allocation: type == TransactionType.expense ? state.allocation : null,
      destinationAccountId: type != TransactionType.transfer ? null : state.destinationAccountId,
    );
  }

  void setAmount(int amount) => state = state.copyWith(amount: amount);
  void setPeriod(RecurringPeriod period) => state = state.copyWith(period: period);
  void setAccountId(String id) => state = state.copyWith(accountId: id);
  void setDestinationAccountId(String? id) => state = state.copyWith(destinationAccountId: id);
  void setCategoryId(String? id) => state = state.copyWith(categoryId: id);
  void setAllocation(TransactionAllocation? allocation) => state = state.copyWith(allocation: allocation);
  void setNote(String? note) => state = state.copyWith(note: note);
  void setIsActive({required bool isActive}) => state = state.copyWith(isActive: isActive);
  void setNextDate(DateTime nextDate) => state = state.copyWith(nextDate: nextDate);

  Future<void> save() async {
    if (state.amount <= 0) {
      state = state.copyWith(error: 'Amount must be greater than 0');
      return;
    }
    if (state.accountId.isEmpty) {
      state = state.copyWith(error: 'Must select an account');
      return;
    }
    if (state.nextDate == null) {
      state = state.copyWith(error: 'Must select a start date');
      return;
    }

    state = state.copyWith(isSaving: true);
    final repo = ref.read(recurringRepositoryProvider);

    final now = DateTimeUtils.nowUtc();
    final tomorrow = DateTime.utc(now.year, now.month, now.day + 1);
    final model =
        state.initialRecurring?.copyWith(
          type: state.type,
          amount: state.amount,
          period: state.period,
          accountId: state.accountId,
          destinationAccountId: state.destinationAccountId,
          categoryId: state.categoryId,
          allocation: state.allocation,
          note: state.note,
          isActive: state.isActive,
          nextDate: state.nextDate!,
          updatedAt: now,
        ) ??
        RecurringTransactionModel(
          id: const Uuid().v7(),
          type: state.type,
          amount: state.amount,
          period: state.period,
          accountId: state.accountId,
          destinationAccountId: state.destinationAccountId,
          categoryId: state.categoryId,
          allocation: state.allocation,
          note: state.note,
          isActive: state.isActive,
          nextDate: state.nextDate ?? tomorrow,
          createdAt: now,
          updatedAt: now,
        );

    final result = state.initialRecurring == null
        ? await repo.createRecurring(model)
        : await repo.updateRecurring(model);

    switch (result) {
      case Success():
        await ref.read(recurringListProvider.notifier).refresh();
        state = state.copyWith(isSaving: false, isSuccess: true);
      case ErrorResult(error: final failure):
        state = state.copyWith(
          error: failure.message,
          isSaving: false,
        );
    }
  }
}
