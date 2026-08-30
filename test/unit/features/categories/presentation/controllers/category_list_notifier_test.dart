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
      when(() => mockRepo.getActiveCategories()).thenAnswer((_) async => const Success([]));
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
      when(() => mockRepo.getActiveCategories()).thenAnswer((_) async => Success(cats));
      final container = createContainer();
      await wait();
      final s = container.read(categoryListProvider).value;
      expect(s, isNotNull);
      expect(s!.first.name, 'Food');
      expect(container.read(categoryListProvider).isLoading, false);
    });

    test('load error', () async {
      when(() => mockRepo.getActiveCategories()).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      expect(container.read(categoryListProvider).hasError, true);
    });

    test('refresh reloads', () async {
      when(() => mockRepo.getActiveCategories()).thenAnswer((_) async => const Success([]));
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
      when(() => mockRepo.getActiveCategories()).thenAnswer((_) async => Success(cats));
      await container.read(categoryListProvider.notifier).refresh();
      await wait();
      expect(container.read(categoryListProvider).value!.first.name, 'Salary');
    });

    test('deactivateCategory success', () async {
      when(() => mockRepo.getActiveCategories()).thenAnswer((_) async => const Success([]));
      when(() => mockRepo.deactivateCategory(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      await wait();
      await container.read(categoryListProvider.notifier).deactivateCategory('1');
      await wait();
      verify(() => mockRepo.deactivateCategory('1')).called(1);
    });

    test('deactivate failure does not refresh', () async {
      when(() => mockRepo.getActiveCategories()).thenAnswer((_) async => const Success([]));
      when(
        () => mockRepo.deactivateCategory(any()),
      ).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      await wait();
      clearInteractions(mockRepo);
      await container.read(categoryListProvider.notifier).deactivateCategory('1');
      await wait();
      verify(() => mockRepo.deactivateCategory(any())).called(1);
      verifyNever(() => mockRepo.getActiveCategories());
    });
  });
}
