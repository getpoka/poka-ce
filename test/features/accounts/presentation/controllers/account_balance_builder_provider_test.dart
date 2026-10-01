/// Tests for [accountBalanceBuilderProvider] extension point.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_balance_builder_provider.dart';

void main() {
  group('accountBalanceBuilderProvider', () {
    test('returns null by default', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final builder = container.read(accountBalanceBuilderProvider);

      expect(builder, isNull);
    });

    test('returns overridden builder when overridden via ProviderScope', () {
      Widget fakeBuilder(context, account) => const SizedBox();

      final container = ProviderContainer(overrides: [accountBalanceBuilderProvider.overrideWithValue(fakeBuilder)]);
      addTearDown(container.dispose);

      final builder = container.read(accountBalanceBuilderProvider);

      expect(builder, equals(fakeBuilder));
    });
  });
}
