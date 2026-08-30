import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('GoalModel', () {
    test('fromJson/toJson', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = GoalModel(
        id: 'g1',
        accountId: 'a1',
        name: 'Vacation',
        targetAmount: 5000,
        createdAt: now,
        updatedAt: now,
        targetDate: now,
        icon: 'i',
        color: 'c',
      );
      final json = m.toJson();
      final restored = GoalModel.fromJson(json);
      expect(restored, equals(m));
    });

    test('copyWith', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = GoalModel(
        id: 'g1',
        accountId: 'a1',
        name: 'Vacation',
        targetAmount: 5000,
        createdAt: now,
        updatedAt: now,
      );
      final c = m.copyWith(name: 'Car', targetAmount: 10000);
      expect(c.name, 'Car');
      expect(c.targetAmount, 10000);
    });

    test('equality', () {
      final now = DateTime.utc(2024, 1, 1);
      final a = GoalModel(
        id: 'g1',
        accountId: 'a1',
        name: 'Vacation',
        targetAmount: 5000,
        createdAt: now,
        updatedAt: now,
      );
      final b = GoalModel(
        id: 'g1',
        accountId: 'a1',
        name: 'Vacation',
        targetAmount: 5000,
        createdAt: now,
        updatedAt: now,
      );
      expect(a, equals(b));
    });
  });
}
