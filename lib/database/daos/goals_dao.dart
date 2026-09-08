import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/goals_table.dart';

part 'goals_dao.g.dart';

/// Data Access Object for [Goals] and their linked pocket [Accounts].
@DriftAccessor(tables: [Goals, Accounts])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  /// Creates a [GoalsDao] attached to [attachedDatabase].
  GoalsDao(super.attachedDatabase);

  /// Retrieves all savings goals.
  Future<List<Goal>> getAllGoals() => select(goals).get();

  /// Observes all savings goals reactively.
  Stream<List<Goal>> watchAllGoals() => select(goals).watch();

  /// Retrieves a goal by its unique [id].
  Future<Goal?> getGoal(String id) => (select(goals)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserts a raw goal record.
  Future<int> insertGoal(GoalsCompanion goal) => into(goals).insert(goal);

  /// Updates an existing goal record.
  Future<bool> updateGoal(GoalsCompanion goal) => update(goals).replace(goal);

  /// Deletes a goal record.
  Future<int> deleteGoal(String id) => (delete(goals)..where((t) => t.id.equals(id))).go();

  /// Atomically inserts a goal and its dedicated pocket account in a single transaction.
  Future<void> insertGoalWithAccount(GoalsCompanion goal, AccountsCompanion account) async {
    return transaction(() async {
      await into(accounts).insert(account);
      await into(goals).insert(goal);
    });
  }

  /// Deletes a goal and its associated pocket account, allowing cascade deletion to clean up.
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
