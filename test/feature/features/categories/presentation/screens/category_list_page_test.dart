import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/categories/presentation/screens/category_list_page.dart';
import 'package:poka_ce/theme/theme.dart';

class MockCategoryListNotifier extends CategoryListNotifier {
  final List<CategoryModel> initialCategories;
  final bool initialLoading;

  MockCategoryListNotifier([this.initialCategories = const [], this.initialLoading = false]);

  @override
  Future<List<CategoryModel>> build() =>
      initialLoading ? Completer<List<CategoryModel>>().future : Future.value(initialCategories);

  @override
  Future<void> refresh() async {}

  @override
  Future<void> deactivateCategory(String id) async {}

  @override
  Future<void> reorderCategories(int oldIndex, int newIndex, CategoryType type, {String? parentId}) async {}
}

void main() {
  Widget buildTestApp(ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US')],
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: Material(child: child!),
        ),
        home: const CategoryListPage(),
      ),
    );
  }

  testWidgets('CategoryListPage shows loading state', (tester) async {
    final container = ProviderContainer(
      overrides: [
        categoryListProvider.overrideWith(() => MockCategoryListNotifier([], true)),
      ],
    );
    await tester.pumpWidget(buildTestApp(container));
    await tester.pump();
    expect(find.byType(FCircularProgress), findsOneWidget);
  });

  // testWidgets('CategoryListPage shows categories in tabs', (tester) async {
  //   final expenseCat = CategoryModel(
  //     id: 'c1',
  //     name: 'Expense Cat',
  //     type: CategoryType.expense,
  //     icon: 'food',
  //     color: '#000000',
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //   );
  //   final incomeCat = CategoryModel(
  //     id: 'c2',
  //     name: 'Income Cat',
  //     type: CategoryType.income,
  //     icon: 'salary',
  //     color: '#000000',
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //   );
  //   final container = ProviderContainer(
  //     overrides: [
  //       categoryListProvider.overrideWith(() => MockCategoryListNotifier([expenseCat, incomeCat], false)),
  //     ],
  //   );
  //   await tester.pumpWidget(buildTestApp(container));
  //   await tester.pumpAndSettle();
  //
  //   expect(find.byType(FTabs), findsWidgets);
  // });
}
