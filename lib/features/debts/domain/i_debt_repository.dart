import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';

abstract class IDebtRepository {
  Future<Result<List<DebtModel>, Failure>> getDebts();
  Stream<List<DebtModel>> watchDebts();
  Future<Result<List<DebtModel>, Failure>> getActiveDebts();
  Future<Result<DebtModel, Failure>> getDebtById(String id);
  Future<Result<void, Failure>> createDebt(DebtModel model, String accountId, String categoryId);
  Future<Result<void, Failure>> updateDebt(DebtModel model);
  Future<Result<void, Failure>> deleteDebt(String id);
}
