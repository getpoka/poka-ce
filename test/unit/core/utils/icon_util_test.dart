import 'package:flutter_test/flutter_test.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/core/utils/icon_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('IconUtil', () {
    test('categories is not empty and contains expected groups', () {
      expect(IconUtil.categories, isNotEmpty);
      expect(IconUtil.categories.length, greaterThan(5));
      final names = IconUtil.categories.map((c) => c.name).toList();
      expect(names, contains('Finance & Banking'));
      expect(names, contains('Other'));
    });

    test('availableIcons builds merged map from categories', () {
      final icons = IconUtil.availableIcons;
      expect(icons, isNotEmpty);
      // Should contain wallet from Finance
      expect(icons.containsKey('wallet'), isTrue);
      expect(icons['wallet'], FPhosphorIcons.wallet);
      // Should contain pizza from Food
      expect(icons.containsKey('pizza'), isTrue);
      // Total should be at least sum minus duplicates (e.g., wrench appears twice)
      var expectedCount = 0;
      for (final cat in IconUtil.categories) {
        expectedCount += cat.icons.length;
      }
      // Duplicates like 'wrench' reduce unique count by at least 1
      expect(icons.length, greaterThanOrEqualTo(expectedCount - 1));
      expect(icons.length, lessThanOrEqualTo(expectedCount));
    });

    test('getIcon returns correct icon for known name', () {
      expect(IconUtil.getIcon('wallet'), FPhosphorIcons.wallet);
      expect(IconUtil.getIcon('pizza'), FPhosphorIcons.pizza);
    });

    test('getIcon returns wallet fallback for null', () {
      expect(IconUtil.getIcon(null), FPhosphorIcons.wallet);
    });

    test('getIcon returns wallet fallback for unknown name', () {
      expect(IconUtil.getIcon('unknown_icon_xyz'), FPhosphorIcons.wallet);
      expect(IconUtil.getIcon(''), FPhosphorIcons.wallet);
    });

    test('IconCategory holds name and icons', () {
      const cat = IconCategory(name: 'Test', icons: {'a': FPhosphorIcons.wallet});
      expect(cat.name, 'Test');
      expect(cat.icons.length, 1);
    });
  });
}
