import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/split_item.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/split/transaction_split_item_list.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

class FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState(isLoading: false);
}

class FakeCategoryListNotifier extends CategoryListNotifier {
  @override
  Future<List<CategoryModel>> build() async => [];
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget(Widget child) {
    return ProviderScope(
      overrides: [
        settingsProvider.overrideWith(FakeSettingsNotifier.new),
        categoryListProvider.overrideWith(FakeCategoryListNotifier.new),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: Scaffold(body: child),
        ),
      ),
    );
  }

  group('TransactionSplitItemList', () {
    testWidgets('renders category name, amount, and note', (tester) async {
      final splits = [
        const SplitItem(
          id: '1',
          amount: 50000,
          categoryId: 'c1',
          categoryName: 'Food',
          note: 'Lunch with team',
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          TransactionSplitItemList(
            splits: splits,
            transactionType: TransactionType.expense,
            onRemove: (_) {},
            onEdit: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Lunch with team'), findsOneWidget);
      expect(find.byType(PokaAmountText), findsOneWidget);
      expect(find.textContaining('50'), findsOneWidget);
      // No allocation badge when null
      expect(find.byIcon(FPhosphorIcons.chartPieSlice), findsNothing);
    });

    testWidgets('renders allocation badge when allocation is present', (tester) async {
      final splits = [
        const SplitItem(
          id: '1',
          amount: 30000,
          categoryId: 'c1',
          categoryName: 'Groceries',
          allocation: TransactionAllocation.need,
        ),
        const SplitItem(
          id: '2',
          amount: 20000,
          categoryId: 'c2',
          categoryName: 'Entertainment',
          allocation: TransactionAllocation.want,
        ),
        const SplitItem(
          id: '3',
          amount: 15000,
          categoryId: 'c3',
          categoryName: 'Emergency Fund',
          allocation: TransactionAllocation.saving,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          TransactionSplitItemList(
            splits: splits,
            transactionType: TransactionType.expense,
            onRemove: (_) {},
            onEdit: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Allocation pie chart icons should be present for all 3 items
      expect(find.byIcon(FPhosphorIcons.chartPieSlice), findsNWidgets(3));

      // Labels should be present
      expect(find.text(t.transactions.need), findsOneWidget);
      expect(find.text(t.transactions.want), findsOneWidget);
      expect(find.text(t.transactions.saving), findsOneWidget);
    });

    testWidgets('triggers onEdit when item card is tapped', (tester) async {
      int? editedIndex;
      final splits = [
        const SplitItem(
          id: '1',
          amount: 10000,
          categoryId: 'c1',
          categoryName: 'Snacks',
          allocation: TransactionAllocation.want,
        ),
      ];

      await tester.pumpWidget(
        buildTestableWidget(
          TransactionSplitItemList(
            splits: splits,
            transactionType: TransactionType.expense,
            onRemove: (_) {},
            onEdit: (index) => editedIndex = index,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Snacks'));
      await tester.pumpAndSettle();

      expect(editedIndex, 0);
    });
  });
}
