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
/// By default (in CE), this returns null, falling back to standard formatted time text.
/// Poka PE overrides this to inject custom layouts (e.g., sync indicators) without coupling CE to sync logic.
@riverpod
TransactionTimeBuilder? transactionTimeBuilder(Ref ref) {
  return null;
}
