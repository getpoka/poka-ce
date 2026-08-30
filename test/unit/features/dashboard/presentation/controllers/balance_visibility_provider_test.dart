import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BalanceVisibilityNotifier', () {
    test('initial state is true (visible)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(container.read(balanceVisibilityProvider), isTrue);
    });

    test('toggle switches true -> false -> true', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(balanceVisibilityProvider.notifier);
      expect(container.read(balanceVisibilityProvider), isTrue);
      notifier.toggle();
      expect(container.read(balanceVisibilityProvider), isFalse);
      notifier.toggle();
      expect(container.read(balanceVisibilityProvider), isTrue);
    });

    test('toggle multiple times', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(balanceVisibilityProvider.notifier);
      for (var i = 0; i < 5; i++) {
        notifier.toggle();
      }
      // odd number of toggles -> false
      expect(container.read(balanceVisibilityProvider), isFalse);
    });
  });
}
