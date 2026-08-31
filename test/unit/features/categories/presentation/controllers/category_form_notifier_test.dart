import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_form_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class MockCategoryRepository extends Mock implements ICategoryRepository {}

class FakeCategoryModel extends Fake implements CategoryModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockCategoryRepository mockRepo;

  setUpAll(() => registerFallbackValue(FakeCategoryModel()));

  setUp(() {
    mockRepo = MockCategoryRepository();
    when(() => mockRepo.getActiveCategories()).thenAnswer((_) async => const Success([]));
    when(() => mockRepo.createCategory(any())).thenAnswer((_) async => const Success(null));
    when(() => mockRepo.updateCategory(any())).thenAnswer((_) async => const Success(null));
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [categoryRepositoryProvider.overrideWithValue(mockRepo)],
    );
    container.listen(categoryFormProvider, (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  CategoryModel sample() => CategoryModel(
    id: 'c1',
    name: 'Food',
    type: CategoryType.expense,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  group('CategoryFormNotifier', () {
    test('init null', () {
      final container = createContainer();
      final n = container.read(categoryFormProvider.notifier);
      n.setName('tmp');
      n.init(null);
      expect(container.read(categoryFormProvider).name, '');
    });

    test('init with model', () {
      final container = createContainer();
      final n = container.read(categoryFormProvider.notifier);
      n.init(sample());
      expect(container.read(categoryFormProvider).name, 'Food');
    });

    test('setters', () {
      final container = createContainer();
      final n = container.read(categoryFormProvider.notifier);
      n.setName('Salary');
      n.setType(CategoryType.income);
      n.setIcon('icon');
      n.setColor('red');
      n.setParentId('p1');
      final s = container.read(categoryFormProvider);
      expect(s.name, 'Salary');
      expect(s.type, CategoryType.income);
      expect(s.icon, 'icon');
      expect(s.color, 'red');
      expect(s.parentId, 'p1');
    });

    test('validation empty name', () async {
      final container = createContainer();
      final n = container.read(categoryFormProvider.notifier);
      n.setName('   ');
      await n.save();
      expect(container.read(categoryFormProvider).nameError, t.accounts.nameCannotBeEmpty);
    });

    test('save create success', () async {
      when(() => mockRepo.createCategory(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      final n = container.read(categoryFormProvider.notifier);
      n.setName('NewCat');
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(categoryFormProvider).isSuccess, true);
      verify(() => mockRepo.createCategory(any())).called(1);
    });

    test('save create failure', () async {
      when(() => mockRepo.createCategory(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      final n = container.read(categoryFormProvider.notifier);
      n.setName('NewCat');
      await n.save();
      expect(container.read(categoryFormProvider).error, 'fail');
    });

    test('save update success', () async {
      when(() => mockRepo.updateCategory(any())).thenAnswer((_) async => const Success(null));
      final container = createContainer();
      final n = container.read(categoryFormProvider.notifier);
      n.init(sample());
      n.setName('Updated');
      await n.save();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(categoryFormProvider).isSuccess, true);
      verify(() => mockRepo.updateCategory(any())).called(1);
    });

    test('save update failure', () async {
      when(() => mockRepo.updateCategory(any())).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = createContainer();
      final n = container.read(categoryFormProvider.notifier);
      n.init(sample());
      n.setName('Updated');
      await n.save();
      expect(container.read(categoryFormProvider).error, 'fail');
    });

    test('copyWith', () {
      const s = CategoryFormState(name: 'a');
      final c = s.copyWith(name: 'b');
      expect(c.name, 'b');
    });
  });
}
