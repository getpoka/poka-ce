import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/app/providers/multi_currency_provider.dart';

void main() {
  group('multi_currency_provider', () {
    test('isMultiCurrencyProvider defaults to false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(isMultiCurrencyProvider), isFalse);
    });

    test('isMultiCurrencyProvider can be overridden', () {
      final container = ProviderContainer(overrides: [isMultiCurrencyProvider.overrideWithValue(true)]);
      addTearDown(container.dispose);

      expect(container.read(isMultiCurrencyProvider), isTrue);
    });

    test('lockedCurrencyTapHandlerProvider defaults to null', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(lockedCurrencyTapHandlerProvider), isNull);
    });

    test('lockedCurrencyTapHandlerProvider can be overridden', () {
      bool called = false;
      final container = ProviderContainer(
        overrides: [
          lockedCurrencyTapHandlerProvider.overrideWithValue((context) {
            called = true;
          }),
        ],
      );
      addTearDown(container.dispose);

      final handler = container.read(lockedCurrencyTapHandlerProvider);
      expect(handler, isNotNull);
    });
  });
}
