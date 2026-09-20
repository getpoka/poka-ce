import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Use case responsible for reconciling an account's balance with real-world funds.
///
/// Instead of mutating historical initial balances, this creates an atomic income or expense
/// reconciliation transaction to balance the account without corrupting historical audit trails.
class ReconcileAccountBalanceUseCase {
  /// Creates a [ReconcileAccountBalanceUseCase] with required repository and transaction creation dependencies.
  const new(this._accountRepository, this._createTransactionUseCase);

  final IAccountRepository _accountRepository;
  final CreateTransactionUseCase _createTransactionUseCase;

  /// Executes reconciliation for the given [account] against [targetBalance].
  ///
  /// [currentBalance] represents the current balance at the time of reconciliation.
  /// If [account] is a Root Account, the adjustment transaction is directed to its default Main Pocket.
  ///
  /// Returns a [Success] containing the updated [AccountModel], or an [ErrorResult] on failure.
  Future<Result<AccountModel, Failure>> execute({
    required AccountModel account,
    required int currentBalance,
    required int targetBalance,
    String? note,
  }) async {
    final delta = targetBalance - currentBalance;

    // No reconciliation needed if balances already match
    if (delta == 0) {
      return Success(account);
    }

    // Determine target pocket ID: Root accounts allocate adjustment to their Main Pocket
    var targetAccountId = account.id;
    if (!account.isPocket) {
      final accountsRes = await _accountRepository.getAccounts();
      final allAccounts = accountsRes.fold((s) => s, (f) => <AccountModel>[]);
      final mainPocket = allAccounts.where((a) => a.parentId == account.id && a.isDefault).firstOrNull;
      if (mainPocket != null) {
        targetAccountId = mainPocket.id;
      }
    }

    final resolvedNote = (note != null && note.trim().isNotEmpty) ? note.trim() : t.accounts.balanceAdjustment;

    final TransactionType txType;
    final int txAmount;
    if (delta < 0) {
      txType = TransactionType.expense;
      txAmount = -delta;
    } else {
      txType = TransactionType.income;
      txAmount = delta;
    }

    final txResult = await _createTransactionUseCase.execute(
      type: txType,
      accountId: targetAccountId,
      amount: txAmount,
      note: resolvedNote,
    );

    return switch (txResult) {
      Success() => Success(account.copyWith(balance: targetBalance)),
      ErrorResult(:final error) => ErrorResult(error),
    };
  }
}
