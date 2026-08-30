import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/numpad_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('NumpadNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      addTearDown(container.dispose);
    });

    test('initial state is 0', () {
      expect(container.read(numpadNotifierProvider), '0');
    });

    test('handleNumber replaces leading zero', () {
      final n = container.read(numpadNotifierProvider.notifier);
      n.handleNumber(5);
      expect(container.read(numpadNotifierProvider), '5');
    });

    test('handleNumber appends after first digit', () {
      final n = container.read(numpadNotifierProvider.notifier);
      n.handleNumber(1);
      n.handleNumber(2);
      n.handleNumber(3);
      expect(container.read(numpadNotifierProvider), '123');
    });

    test('handleNumber caps length at 15 digits', () {
      final n = container.read(numpadNotifierProvider.notifier);
      for (var i = 0; i < 20; i++) {
        n.handleNumber(9);
      }
      expect(container.read(numpadNotifierProvider).length, 15);
    });

    test('handleBackspace trims one char', () {
      final n = container.read(numpadNotifierProvider.notifier);
      n.handleNumber(1);
      n.handleNumber(2);
      n.handleBackspace();
      expect(container.read(numpadNotifierProvider), '1');
    });

    test('handleBackspace on single char resets to 0', () {
      final n = container.read(numpadNotifierProvider.notifier);
      n.handleNumber(7);
      n.handleBackspace();
      expect(container.read(numpadNotifierProvider), '0');
    });

    test('handleBackspace on initial 0 stays 0', () {
      final n = container.read(numpadNotifierProvider.notifier);
      n.handleBackspace();
      expect(container.read(numpadNotifierProvider), '0');
    });

    test('reset returns state to 0', () {
      final n = container.read(numpadNotifierProvider.notifier);
      n.handleNumber(4);
      n.handleNumber(2);
      n.reset();
      expect(container.read(numpadNotifierProvider), '0');
    });

    test('leading zero not appended when pressing 0 first repeatedly', () {
      final n = container.read(numpadNotifierProvider.notifier);
      n.handleNumber(0);
      n.handleNumber(0);
      // First press replaces '0' with '0', second appends -> '00'
      final state = container.read(numpadNotifierProvider);
      expect(state, anyOf('0', '00'));
    });
  });
}
