import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurring_list_notifier.freezed.dart';
part 'recurring_list_notifier.g.dart';

@freezed
abstract class RecurringListState with _$RecurringListState {
  const factory RecurringListState({
    @Default([]) List<RecurringTransactionModel> recurrings,
    @Default(false) bool isLoading,
    String? error,
  }) = _RecurringListState;
}

@riverpod
class RecurringListNotifier extends _$RecurringListNotifier {
  @override
  RecurringListState build() {
    Future.microtask(refresh);
    return const RecurringListState(isLoading: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);

    final repo = ref.read(recurringRepositoryProvider);
    final result = await repo.getRecurringTransactions();

    result.fold(
      (recurrings) {
        state = state.copyWith(
          recurrings: recurrings,
          isLoading: false,
        );
      },
      (failure) {
        state = state.copyWith(
          error: failure.message,
          isLoading: false,
        );
      },
    );
  }

  Future<void> deleteRecurring(String id) async {
    final repo = ref.read(recurringRepositoryProvider);
    final result = await repo.deleteRecurring(id);
    if (result is Success) {
      await refresh();
    }
  }

  Future<void> toggleActive(String id) async {
    final index = state.recurrings.indexWhere((r) => r.id == id);
    if (index == -1) return;

    final recurring = state.recurrings[index];
    final updated = recurring.copyWith(isActive: !recurring.isActive);

    // Optimistic update so the UI responds immediately.
    final newList = List<RecurringTransactionModel>.from(state.recurrings)..[index] = updated;
    state = state.copyWith(recurrings: newList);

    final repo = ref.read(recurringRepositoryProvider);
    final result = await repo.updateRecurring(updated);
    if (result is ErrorResult) {
      // Roll back to server state on persistence failure.
      await refresh();
    }
  }
}
