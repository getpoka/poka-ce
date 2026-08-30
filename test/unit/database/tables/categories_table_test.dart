import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(connection: NativeDatabase.memory());
    await db.delete(db.categories).go();
  });
  tearDown(() async => db.close());

  group('Categories table', () {
    test('insert with defaults and nullable metadata', () async {
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('c1'), name: 'Salary', type: CategoryType.income));
      final row = await db.select(db.categories).getSingle();

      expect(row.isActive, isTrue);
      expect(row.parentId, isNull);
      expect(row.icon, isNull);
      expect(row.color, isNull);
      expect(row.type, CategoryType.income);
    });

    test('copyWith, equality and json round trip for both types', () async {
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('c2'), name: 'Food', type: CategoryType.expense));
      final row = await db.select(db.categories).getSingle();

      final changed = row.copyWith(name: 'Meals', isActive: false);
      expect(changed.name, 'Meals');
      expect(changed.isActive, isFalse);
      expect(changed == row, isFalse);
      expect(row.copyWith(), row);
      expect(row.hashCode, row.copyWith().hashCode);
      expect(row.toString(), contains('Category'));

      final restored = Category.fromJson(row.toJson());
      expect(restored, row);
      expect(restored.type, CategoryType.expense);

      await (db.update(
        db.categories,
      )..where((c) => c.id.equals('c2'))).write(const CategoriesCompanion(color: Value('#00FF00')));
      final updated = await db.select(db.categories).getSingle();
      expect(updated.color, '#00FF00');
    });

    test('sub category references parent category', () async {
      await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(id: const Value('p1'), name: 'Transport', type: CategoryType.expense));
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              id: const Value('child'),
              name: 'Fuel',
              type: CategoryType.expense,
              parentId: const Value('p1'),
              icon: const Value('car'),
            ),
          );

      final child = await (db.select(db.categories)..where((c) => c.id.equals('child'))).getSingle();
      expect(child.parentId, 'p1');

      await (db.delete(db.categories)..where((c) => c.id.equals('p1'))).go();
      expect(await db.select(db.categories).get(), isEmpty);
    });
  });
}
