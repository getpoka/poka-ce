import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/goals_table.dart';

part 'goals_dao.g.dart';

@DriftAccessor(tables: [Goals, Accounts])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  GoalsDao(super.attachedDatabase);

  Future<List<Goal>> getAllGoals() => select(goals).get();

  Stream<List<Goal>> watchAllGoals() => select(goals).watch();

  Future<Goal?> getGoal(String id) => (select(goals)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertGoal(GoalsCompanion goal) => into(goals).insert(goal);

  Future<bool> updateGoal(GoalsCompanion goal) => update(goals).replace(goal);

  Future<int> deleteGoal(String id) => (delete(goals)..where((t) => t.id.equals(id))).go();

  Future<void> insertGoalWithAccount(GoalsCompanion goal, AccountsCompanion account) async {
    return transaction(() async {
      await into(accounts).insert(account);
      await into(goals).insert(goal);
    });
  }

  Future<void> deleteGoalWithAccount(String goalId) async {
    return transaction(() async {
      final goal = await getGoal(goalId);
      if (goal != null) {
        // Since Goals references Accounts with cascade delete,
        // deleting the account will automatically delete the Goal.
        await (delete(accounts)..where((a) => a.id.equals(goal.accountId))).go();
      }
    });
  }
}
