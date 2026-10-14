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
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/i18n/strings.g.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(body: child),
      ),
    );
  }

  group('PokaIconPicker', () {
    testWidgets('renders categories and icons, and triggers onIconSelected', (tester) async {
      String? selectedIcon;
      await tester.pumpWidget(
        buildTestableWidget(PokaIconPicker(selectedIcon: 'wallet', onIconSelected: (icon) => selectedIcon = icon)),
      );

      expect(find.byType(PokaIconPicker), findsOneWidget);
      expect(find.byType(FTextField), findsOneWidget);

      final icons = find.byType(Icon);
      await tester.tap(icons.at(1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(selectedIcon, isNotNull);
    });

    testWidgets('has at least 150 available icons in catalogue', (tester) async {
      expect(IconUtil.availableIcons.length, greaterThanOrEqualTo(150));
    });

    testWidgets('filters icons when search query is entered', (tester) async {
      String? selectedIcon;
      await tester.pumpWidget(
        buildTestableWidget(PokaIconPicker(selectedIcon: null, onIconSelected: (icon) => selectedIcon = icon)),
      );

      await tester.enterText(find.byType(FTextField), 'coffee');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      final coffeeFinder = find.byIcon(FPhosphorIcons.coffee);
      expect(coffeeFinder, findsWidgets);

      await tester.tap(coffeeFinder.first);
      await tester.pump();
      expect(selectedIcon, 'coffee');
    });

    testWidgets('shows empty state when search finds no match', (tester) async {
      await tester.pumpWidget(buildTestableWidget(PokaIconPicker(selectedIcon: null, onIconSelected: (_) {})));

      await tester.enterText(find.byType(FTextField), 'xyznonexistent12345');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text(t.categories.noIconsFound), findsOneWidget);
    });

    testWidgets('supports multilingual search aliases across supported locales', (tester) async {
      await tester.pumpWidget(buildTestableWidget(PokaIconPicker(selectedIcon: null, onIconSelected: (_) {})));

      // Searching Indonesian alias "kopi" for coffee
      await tester.enterText(find.byType(FTextField), 'kopi');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byIcon(FPhosphorIcons.coffee), findsWidgets);
    });
  });

  group('PokaCategorySelector', () {
    testWidgets('shows empty state', (tester) async {
      await tester.pumpWidget(buildTestableWidget(PokaCategorySelector(categories: const [])));

      expect(find.text('No categories available.'), findsOneWidget);
    });

    testWidgets('shows categories and pops on select', (tester) async {
      final now = DateTimeUtils.nowUtc();
      final cat = CategoryModel(id: '1', name: 'Food', type: CategoryType.expense, createdAt: now, updatedAt: now);

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

    testWidgets('renders caretDown with size 16 when category has children and toggles to caretUp', (tester) async {
      final now = DateTimeUtils.nowUtc();
      final parent = CategoryModel(id: 'p1', name: 'Food', type: CategoryType.expense, createdAt: now, updatedAt: now);
      final child = CategoryModel(
        id: 'c1',
        parentId: 'p1',
        name: 'Groceries',
        type: CategoryType.expense,
        createdAt: now,
        updatedAt: now,
      );

      await tester.pumpWidget(buildTestableWidget(PokaCategorySelector(categories: [parent, child])));

      final caretDownFinder = find.byIcon(FPhosphorIcons.caretDown);
      expect(caretDownFinder, findsOneWidget);
      final caretDown = tester.widget<Icon>(caretDownFinder);
      expect(caretDown.size, 16);

      // Tap chevron to expand
      await tester.tap(caretDownFinder);
      await tester.pumpAndSettle();

      expect(find.text('Groceries'), findsOneWidget);
      final caretUpFinder = find.byIcon(FPhosphorIcons.caretUp);
      expect(caretUpFinder, findsOneWidget);
      final caretUp = tester.widget<Icon>(caretUpFinder);
      expect(caretUp.size, 16);
    });
  });

  group('PokaPocketSelector', () {
    testWidgets('shows empty state', (tester) async {
      await tester.pumpWidget(buildTestableWidget(PokaPocketSelector(accounts: const [])));

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

    testWidgets('renders caretDown with size 16 when parent has non-default pocket and toggles to caretUp', (
      tester,
    ) async {
      final now = DateTimeUtils.nowUtc();
      final parent = AccountModel(
        id: 'p1',
        name: 'Bank BCA',
        type: AccountType.assets,
        balance: 1000,
        createdAt: now,
        updatedAt: now,
      );
      final pocket = AccountModel(
        id: 'c1',
        parentId: 'p1',
        isDefault: false,
        name: 'Savings Pocket',
        type: AccountType.assets,
        balance: 500,
        createdAt: now,
        updatedAt: now,
      );

      await tester.pumpWidget(buildTestableWidget(PokaPocketSelector(accounts: [parent, pocket])));

      final caretDownFinder = find.byIcon(FPhosphorIcons.caretDown);
      expect(caretDownFinder, findsOneWidget);
      final caretDown = tester.widget<Icon>(caretDownFinder);
      expect(caretDown.size, 16);

      // Tap chevron to expand
      await tester.tap(caretDownFinder);
      await tester.pumpAndSettle();

      expect(find.text('Savings Pocket'), findsOneWidget);
      final caretUpFinder = find.byIcon(FPhosphorIcons.caretUp);
      expect(caretUpFinder, findsOneWidget);
      final caretUp = tester.widget<Icon>(caretUpFinder);
      expect(caretUp.size, 16);
    });
  });
}
