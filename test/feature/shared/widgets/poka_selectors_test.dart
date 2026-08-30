import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/shared/widgets/pickers/poka_icon_picker.dart';
import 'package:poka_ce/shared/widgets/poka_category_selector.dart';
import 'package:poka_ce/shared/widgets/poka_pocket_selector.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: child!,
        ),
        home: Scaffold(body: child),
      ),
    );
  }

  group('PokaIconPicker', () {
    testWidgets('renders categories and icons, and triggers onIconSelected', (tester) async {
      String? selectedIcon;
      await tester.pumpWidget(
        buildTestableWidget(
          PokaIconPicker(
            selectedIcon: 'ph_wallet',
            onIconSelected: (icon) => selectedIcon = icon,
          ),
        ),
      );

      // Should render the first category "General" by default (or similar)
      expect(find.byType(PokaIconPicker), findsOneWidget);

      // Tap an icon in the list (Assuming there's an icon for 'ph_money')
      // Note: testing specific icon keys requires knowing icon mapping.
      // We will tap the first available icon that is not the selected one.
      final icons = find.byType(Icon);
      await tester.tap(icons.last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(selectedIcon, isNotNull);
    });

    testWidgets('can switch categories', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          PokaIconPicker(
            selectedIcon: null,
            onIconSelected: (_) {},
          ),
        ),
      );

      // Find another category, e.g., 'Food' or 'Transport'
      // By tapping the text 'Food' if it exists.
      final categoryTexts = find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.byType(Text),
      );

      if (tester.widgetList(categoryTexts).length > 1) {
        await tester.tap(categoryTexts.last);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        // Just verify it doesn't crash and switches state.
      }
    });
  });

  group('PokaCategorySelector', () {
    testWidgets('shows empty state', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          PokaCategorySelector(categories: const []),
        ),
      );

      expect(find.text('No categories available.'), findsOneWidget);
    });

    testWidgets('shows categories and pops on select', (tester) async {
      final now = DateTimeUtils.nowUtc();
      final cat = CategoryModel(
        id: '1',
        name: 'Food',
        type: CategoryType.expense,
        createdAt: now,
        updatedAt: now,
      );

      CategoryModel? result;

      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                result = await PokaCategorySelector.show(context, categories: [cat]);
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Food'), findsOneWidget);

      await tester.tap(find.text('Food'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(result, cat);
    });
  });

  group('PokaPocketSelector', () {
    testWidgets('shows empty state', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          PokaPocketSelector(accounts: const []),
        ),
      );

      expect(find.textContaining('No wallets found'), findsOneWidget);
    });

    testWidgets('shows accounts and pops on select', (tester) async {
      final now = DateTimeUtils.nowUtc();
      final account = AccountModel(
        id: '1',
        name: 'Vacation',
        type: AccountType.assets,
        balance: 100,
        createdAt: now,
        updatedAt: now,
      );

      AccountModel? result;

      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FButton(
              onPress: () async {
                result = await PokaPocketSelector.show(context, accounts: [account]);
              },
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Vacation'), findsOneWidget);

      await tester.tap(find.text('Vacation'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(result, account);
    });
  });
}
