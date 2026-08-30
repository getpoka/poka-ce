import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('CategoryModel', () {
    test('fromJson/toJson', () {
      final now = DateTime.utc(2024, 1, 1);
      final model = CategoryModel(
        id: 'c1',
        name: 'Food',
        type: CategoryType.expense,
        createdAt: now,
        updatedAt: now,
        icon: 'i',
        color: 'c',
        parentId: 'p1',
      );
      final json = model.toJson();
      final restored = CategoryModel.fromJson(json);
      expect(restored, equals(model));
    });

    test('copyWith', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = CategoryModel(id: 'c1', name: 'Food', type: CategoryType.expense, createdAt: now, updatedAt: now);
      final c = m.copyWith(name: 'Salary', type: CategoryType.income);
      expect(c.name, 'Salary');
      expect(c.type, CategoryType.income);
    });

    test('equality', () {
      final now = DateTime.utc(2024, 1, 1);
      final a = CategoryModel(id: 'c1', name: 'Food', type: CategoryType.expense, createdAt: now, updatedAt: now);
      final b = CategoryModel(id: 'c1', name: 'Food', type: CategoryType.expense, createdAt: now, updatedAt: now);
      expect(a, equals(b));
    });

    test('defaults', () {
      final now = DateTime.utc(2024, 1, 1);
      final m = CategoryModel(id: 'c1', name: 'Food', type: CategoryType.expense, createdAt: now, updatedAt: now);
      expect(m.isActive, true);
    });
  });
}
