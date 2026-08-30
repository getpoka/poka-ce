import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/create_account_use_case.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/update_account_use_case.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/transfer_funds_use_case.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/update_transaction_use_case.dart';

final createAccountUseCaseProvider = Provider<CreateAccountUseCase>((ref) {
  return CreateAccountUseCase(
    ref.watch(unitOfWorkProvider),
    ref.watch(accountRepositoryProvider),
  );
});

final updateAccountUseCaseProvider = Provider<UpdateAccountUseCase>((ref) {
  return UpdateAccountUseCase(
    ref.watch(accountRepositoryProvider),
  );
});

final createTransactionUseCaseProvider = Provider<CreateTransactionUseCase>((ref) {
  return CreateTransactionUseCase(
    ref.watch(transactionRepositoryProvider),
  );
});

final transferFundsUseCaseProvider = Provider<TransferFundsUseCase>((ref) {
  return TransferFundsUseCase(
    ref.watch(unitOfWorkProvider),
    ref.watch(transactionRepositoryProvider),
  );
});

final updateTransactionUseCaseProvider = Provider<UpdateTransactionUseCase>((ref) {
  return UpdateTransactionUseCase(
    ref.watch(transactionRepositoryProvider),
  );
});
