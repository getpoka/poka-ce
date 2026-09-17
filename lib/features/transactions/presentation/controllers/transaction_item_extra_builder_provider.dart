import 'package:flutter/widgets.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_item_extra_builder_provider.g.dart';

/// Defines a custom builder for rendering the time / metadata slot in a transaction tile.
///
/// Receives [context], the current [transaction], and the default [formattedTime] string.
typedef TransactionTimeBuilder = Widget Function(
  BuildContext context,
  TransactionModel transaction,
  String formattedTime,
);

/// Provides a custom builder for customizing the transaction tile's time slot.
///
/// By default, this returns null, falling back to standard formatted time text.
/// Downstream consumers can override this to inject custom time or metadata presentation.
@riverpod
TransactionTimeBuilder? transactionTimeBuilder(Ref ref) {
  return null;
}

/// Defines a custom builder for rendering the amount slot in a transaction tile.
///
/// Receives [context], the current [transaction], and named [isBalanceVisible].
typedef TransactionAmountBuilder = Widget Function(
  BuildContext context,
  TransactionModel transaction, {
  required bool isBalanceVisible,
});

/// Provides a custom builder for customizing the transaction tile's amount presentation.
///
/// By default, this returns null, falling back to standard PokaAmountText.
/// Downstream consumers can override this to inject custom amount presentation.
@riverpod
TransactionAmountBuilder? transactionAmountBuilder(Ref ref) {
  return null;
}
