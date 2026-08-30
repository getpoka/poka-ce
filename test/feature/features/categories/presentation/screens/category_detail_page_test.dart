import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/screens/category_detail_page.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: child!,
        ),
        home: child,
      ),
    );
  }

  testWidgets('CategoryDetailPage renders correctly', (tester) async {
    final category = CategoryModel(
      id: 'c1',
      name: 'Groceries',
      type: CategoryType.expense,
      color: '#FF0000',
      icon: 'basket',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await tester.pumpWidget(
      buildTestApp(
        CategoryDetailPage(
          category: category,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(CategoryDetailPage), findsOneWidget);
    expect(find.text('Groceries'), findsWidgets);
  });
}
