import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/categories/presentation/widgets/tiles/category_tile.dart';
import 'package:poka_ce/features/categories/presentation/widgets/views/category_list_tab.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class _FakeCategoryListNotifier extends CategoryListNotifier {
  @override
  Future<List<CategoryModel>> build() => Future.value(const []);

  @override
  Future<void> reorderCategories(int oldIndex, int newIndex, CategoryType type, {String? parentId}) async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  CategoryModel cat(String id, String name, {String? parentId, CategoryType type = CategoryType.expense}) =>
      CategoryModel(
        id: id,
        name: name,
        type: type,
        parentId: parentId,
        color: '#EF4444',
        icon: 'tag',
        createdAt: DateTime.utc(2024, 1, 1),
        updatedAt: DateTime.utc(2024, 1, 1),
      );

  Widget buildApp(List<CategoryModel> categories, {List<CategoryModel> all = const []}) {
    final container = ProviderContainer(
      overrides: [categoryListProvider.overrideWith(() => _FakeCategoryListNotifier())],
    );
    return UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: CategoryListTab(
              categories: categories,
              allCategories: all.isEmpty ? categories : all,
              type: CategoryType.expense,
            ),
          ),
        ),
      ),
    );
  }

  group('CategoryListTab', () {
    testWidgets('empty categories shows empty view with action', (tester) async {
      await tester.pumpWidget(buildApp(const []));
      await tester.pumpAndSettle();

      expect(find.byType(PokaEmptyViewCentered), findsOneWidget);
      expect(find.text('No categories found.'), findsOneWidget);
    });

    testWidgets('renders category tiles for non-empty list', (tester) async {
      final categories = [cat('c1', 'Food'), cat('c2', 'Transport'), cat('c3', 'Bills')];
      await tester.pumpWidget(buildApp(categories));
      await tester.pumpAndSettle();

      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Transport'), findsOneWidget);
      expect(find.text('Bills'), findsOneWidget);
      expect(find.byType(CategoryTile), findsNWidgets(3));
    });

    testWidgets('child count reflects sub categories', (tester) async {
      final categories = [cat('parent', 'Food & Drink')];
      final all = [
        categories.first,
        cat('child1', 'Coffee', parentId: 'parent'),
        cat('child2', 'Snacks', parentId: 'parent'),
      ];
      await tester.pumpWidget(buildApp(categories, all: all));
      await tester.pumpAndSettle();

      expect(find.text('Food & Drink'), findsOneWidget);
      expect(find.textContaining('2 subcategories'), findsOneWidget);
    });
  });
}
