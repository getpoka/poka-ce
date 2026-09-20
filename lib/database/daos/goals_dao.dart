import 'package:drift/drift.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/tables/accounts_table.dart';
import 'package:poka_ce/database/tables/goals_table.dart';

part 'goals_dao.g.dart';

/// Data Access Object for [Goals] and their linked pocket [Accounts].
@DriftAccessor(tables: [Goals, Accounts])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  /// Creates a [GoalsDao] attached to [attachedDatabase].
  new(super.attachedDatabase);

  /// Retrieves all savings goals.
  Future<List<Goal>> getAllGoals() => select(goals).get();

  /// Observes all savings goals reactively.
  Stream<List<Goal>> watchAllGoals() => select(goals).watch();

  /// Retrieves all savings goals joined with their linked pocket accounts to determine parent account.
  Future<List<TypedResult>> getAllGoalsWithAccounts() {
    return select(goals).join([innerJoin(accounts, accounts.id.equalsExp(goals.accountId))]).get();
  }

  /// Observes all savings goals joined with their linked pocket accounts reactively.
  Stream<List<TypedResult>> watchAllGoalsWithAccounts() {
    return select(goals).join([innerJoin(accounts, accounts.id.equalsExp(goals.accountId))]).watch();
  }

  /// Retrieves a goal by its unique [id].
  Future<Goal?> getGoal(String id) => (select(goals)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Retrieves a single savings goal joined with its linked pocket account by its [id].
  Future<TypedResult?> getGoalWithAccount(String id) {
    return (select(goals).join([
      innerJoin(accounts, accounts.id.equalsExp(goals.accountId)),
    ])..where(goals.id.equals(id))).getSingleOrNull();
  }

  /// Inserts a raw goal record.
  Future<int> insertGoal(GoalsCompanion goal) => into(goals).insert(goal);

  /// Updates an existing goal record.
  Future<bool> updateGoal(GoalsCompanion goal) => update(goals).replace(goal);

  /// Atomically updates a goal and synchronizes name, icon, and color with its paired pocket account.
  Future<void> updateGoalWithAccount(GoalsCompanion goal) async {
    return await transaction(() async {
      await update(goals).replace(goal);
      if (goal.accountId.present) {
        await (update(accounts)..where((a) => a.id.equals(goal.accountId.value))).write(
          AccountsCompanion(name: goal.name, icon: goal.icon, color: goal.color, updatedAt: goal.updatedAt),
        );
      }
    });
  }

  /// Deletes a goal record.
  Future<int> deleteGoal(String id) => (delete(goals)..where((t) => t.id.equals(id))).go();

  /// Atomically inserts a goal and its dedicated pocket account in a single transaction.
  Future<void> insertGoalWithAccount(
    GoalsCompanion goal,
    AccountsCompanion account, {
    AccountsCompanion? parentAccount,
  }) async {
    return await transaction(() async {
      if (parentAccount != null) {
        await into(accounts).insertOnConflictUpdate(parentAccount);
      }
      await into(accounts).insert(account);
      await into(goals).insert(goal);
    });
  }

  /// Deletes a goal and its associated pocket account.
  Future<void> deleteGoalWithAccount(String goalId) async {
    return await transaction(() async {
      final goal = await getGoal(goalId);
      if (goal != null) {
        await (delete(goals)..where((g) => g.id.equals(goalId))).go();
        await (delete(accounts)..where((a) => a.id.equals(goal.accountId))).go();
      }
    });
  }
}
