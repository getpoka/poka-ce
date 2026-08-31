import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';

class MockCategoryRepository extends Mock implements ICategoryRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockCategoryRepository mockRepo;

  setUp(() => mockRepo = MockCategoryRepository());

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [categoryRepositoryProvider.overrideWithValue(mockRepo)],
    );
    container.listen(categoryListProvider, (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  Future<void> wait() async => Future.delayed(const Duration(milliseconds: 50));

  group('CategoryListNotifier', () {
    test('initial loading true', () async {
      when(() => mockRepo.getCategories()).thenAnswer((_) async => const Success([]));
      final container = createContainer();
      expect(container.read(categoryListProvider).isLoading, true);
      await wait();
    });

    test('load success', () async {
      final cats = [
        CategoryModel(
          id: '1',
          name: 'Food',
          type: CategoryType.expense,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.getCategories()).thenAnswer((_) async => Success(cats));
      final container = createContainer();
      await wait();
      final s = container.read(categoryListProvider).value;
      expect(s, isNotNull);
      expect(s!.first.name, 'Food');
      expect(container.read(categoryListProvider).isLoading, false);
    });

    test('load error', () async {
      when(() => mockRepo.getCategories()).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      expect(container.read(categoryListProvider).hasError, true);
    });

    test('refresh reloads', () async {
      when(() => mockRepo.getCategories()).thenAnswer((_) async => const Success([]));
      final container = createContainer();
      await wait();
      final cats = [
        CategoryModel(
          id: '2',
          name: 'Salary',
          type: CategoryType.income,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.getCategories()).thenAnswer((_) async => Success(cats));
      await container.read(categoryListProvider.notifier).refresh();
      await wait();
      expect(container.read(categoryListProvider).value!.first.name, 'Salary');
    });

    test('toggleActive success', () async {
      when(() => mockRepo.getCategories()).thenAnswer((_) async => const Success([]));
      when(() => mockRepo.toggleCategoryActiveStatus(any(), isActive: any(named: 'isActive')))
          .thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      final category = CategoryModel(
        id: '1',
        name: 'Test',
        type: CategoryType.expense,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await container.read(categoryListProvider.notifier).toggleActive(category, isActive: false);
      await wait();
      verify(() => mockRepo.toggleCategoryActiveStatus('1', isActive: false)).called(1);
    });

    test('toggleActive failure does not refresh', () async {
      when(() => mockRepo.getCategories()).thenAnswer((_) async => const Success([]));
      when(
        () => mockRepo.toggleCategoryActiveStatus(any(), isActive: any(named: 'isActive')),
      ).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);
      final category = CategoryModel(
        id: '1',
        name: 'Test',
        type: CategoryType.expense,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await container.read(categoryListProvider.notifier).toggleActive(category, isActive: false);
      await wait();
      verify(() => mockRepo.toggleCategoryActiveStatus(any(), isActive: any(named: 'isActive'))).called(1);
      verifyNever(() => mockRepo.getCategories());
    });

    test('deleteCategory success', () async {
      when(() => mockRepo.getCategories()).thenAnswer((_) async => const Success([]));
      when(() => mockRepo.deleteCategory(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(categoryListProvider.notifier).deleteCategory('1');
      await wait();
      verify(() => mockRepo.deleteCategory('1')).called(1);
    });

    test('reorderCategories success', () async {
      final cats = [
        CategoryModel(
          id: '1',
          name: 'C1',
          type: CategoryType.expense,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
        CategoryModel(
          id: '2',
          name: 'C2',
          type: CategoryType.expense,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.getCategories()).thenAnswer((_) async => Success(cats));
      when(() => mockRepo.reorderCategories(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(categoryListProvider.notifier).reorderCategories(0, 1, CategoryType.expense);
      await wait();
      verify(() => mockRepo.reorderCategories(any())).called(1);
      final s = container.read(categoryListProvider).value;
      expect(s!.last.id, '1');
    });

    test('categoryMap provider', () async {
      final container = createContainer();
      final cats = [
        CategoryModel(
          id: '1',
          name: 'C1',
          type: CategoryType.expense,
          createdAt: DateTime.utc(2024, 1, 1),
          updatedAt: DateTime.utc(2024, 1, 1),
        ),
      ];
      when(() => mockRepo.watchCategories()).thenAnswer((_) => Stream.value(Success(cats)));
      container.listen(categoriesStreamProvider, (_, __) {});
      await wait();
      final map = container.read(categoryMapProvider);
      // It might be empty if the stream hasn't yielded yet, wait a bit
      await wait();
      final mapAfter = container.read(categoryMapProvider);
      expect(mapAfter.length, 1);
      expect(mapAfter['1']?.name, 'C1');
    });
  });
}
