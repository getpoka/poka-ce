import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';

abstract class IBudgetRepository {
  Future<Result<List<BudgetModel>, Failure>> getBudgets();
  Future<Result<BudgetModel, Failure>> getBudgetById(String id);
  Future<Result<void, Failure>> createBudget(BudgetModel model);
  Future<Result<void, Failure>> updateBudget(BudgetModel model);
  Future<Result<void, Failure>> deleteBudget(String id);
  Future<Result<int, Failure>> getSpentAmountForBudget({
    required DateTime startDate,
    required DateTime endDate,
    String? categoryId,
    String? accountId,
  });
}
