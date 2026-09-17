import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_item_extra_builder_provider.dart';

void main() {
  group('transactionTimeBuilderProvider', () {
    test('defaults to null', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final builder = container.read(transactionTimeBuilderProvider);
      expect(builder, isNull);
    });

    test('can be overridden with a custom builder receiving formattedTime', () {
      final container = ProviderContainer(
        overrides: [
          transactionTimeBuilderProvider.overrideWithValue(
            (context, transaction, formattedTime) =>
                Text('$formattedTime (custom)', key: const ValueKey('test_time_slot')),
          ),
        ],
      );
      addTearDown(container.dispose);

      final builder = container.read(transactionTimeBuilderProvider);
      expect(builder, isNotNull);

      final dummyTx = TransactionModel(
        id: 'tx_1',
        accountId: 'acc_1',
        type: TransactionType.expense,
        amount: 1000,
        transactionDate: DateTime(2026, 1, 1),
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      final widget = builder!(_FakeBuildContext(), dummyTx, '10:30');
      expect(widget, isA<Text>());
      expect((widget as Text).key, equals(const ValueKey('test_time_slot')));
      expect(widget.data, equals('10:30 (custom)'));
    });
  });

  group('transactionAmountBuilderProvider', () {
    test('defaults to null', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final builder = container.read(transactionAmountBuilderProvider);
      expect(builder, isNull);
    });

    test('can be overridden with a custom builder receiving transaction and visibility', () {
      final container = ProviderContainer(
        overrides: [
          transactionAmountBuilderProvider.overrideWithValue(
            (context, transaction, {required isBalanceVisible}) =>
                Text('\$ ${transaction.amount}', key: const ValueKey('test_amount_slot')),
          ),
        ],
      );
      addTearDown(container.dispose);

      final builder = container.read(transactionAmountBuilderProvider);
      expect(builder, isNotNull);

      final dummyTx = TransactionModel(
        id: 'tx_1',
        accountId: 'acc_1',
        type: TransactionType.expense,
        amount: 1000,
        transactionDate: DateTime(2026, 1, 1),
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      final widget = builder!(_FakeBuildContext(), dummyTx, isBalanceVisible: true);
      expect(widget, isA<Text>());
      expect((widget as Text).key, equals(const ValueKey('test_amount_slot')));
      expect(widget.data, equals('\$ 1000'));
    });
  });
}

class _FakeBuildContext extends Fake implements BuildContext {}
