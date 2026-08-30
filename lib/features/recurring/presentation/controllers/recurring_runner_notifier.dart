/// Notifier that runs the recurring-transaction processor on app startup.
///
/// Watch [recurringRunnerProvider] once from the shell to trigger processing.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/features/recurring/domain/recurring_processor_service.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';

/// Sealed result type for the runner's outcome.
sealed class RecurringRunnerState {
  const RecurringRunnerState();
}

/// Runner hasn't started yet or is in progress.
class RecurringRunnerIdle extends RecurringRunnerState {
  const RecurringRunnerIdle();
}

/// Runner completed successfully with [processed] transactions created.
class RecurringRunnerDone extends RecurringRunnerState {
  const RecurringRunnerDone(this.processed);
  final int processed;
}

/// Runner encountered an error.
class RecurringRunnerError extends RecurringRunnerState {
  const RecurringRunnerError(this.message);
  final String message;
}

/// Processes all overdue recurring transactions when the app starts.
class RecurringRunnerNotifier extends Notifier<RecurringRunnerState> {
  @override
  RecurringRunnerState build() {
    Future.microtask(_run);
    return const RecurringRunnerIdle();
  }

  Future<void> _run() async {
    final recurringRepo = ref.read(recurringRepositoryProvider);
    final transactionRepo = ref.read(transactionRepositoryProvider);

    final service = RecurringProcessorService(
      recurringRepository: recurringRepo,
      transactionRepository: transactionRepo,
    );

    final today = DateTime.now();
    final result = await service.run(today);

    switch (result) {
      case Success(:final value) when value > 0:
        talker.info('RecurringRunner: processed $value recurring transaction(s).');
        // Refresh list so UI reflects newly created entries.
        await ref.read(recurringListProvider.notifier).refresh();
        state = RecurringRunnerDone(value);
      case Success():
        state = const RecurringRunnerDone(0);
      case ErrorResult(:final error):
        talker.warning('RecurringRunner: ${error.message}');
        state = RecurringRunnerError(error.message);
    }
  }
}

/// Provider that automatically runs recurring processing on first watch.
final recurringRunnerProvider = NotifierProvider<RecurringRunnerNotifier, RecurringRunnerState>(
  RecurringRunnerNotifier.new,
);
