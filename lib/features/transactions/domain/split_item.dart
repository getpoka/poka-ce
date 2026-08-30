import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart' show TransactionItemModel;

part 'split_item.freezed.dart';

/// In-memory representation of a single split item during form editing.
///
/// Not persisted directly — converted to [TransactionItemModel] on save.
@freezed
abstract class SplitItem with _$SplitItem {
  const factory SplitItem({
    /// Amount in smallest integer currency unit (e.g. cents/rupiah).
    required int amount,

    /// Optional ID for editing an existing saved item.
    String? id,

    /// Category ID (nullable — user may not have selected one yet).
    String? categoryId,

    /// Category display name, resolved at creation time for fast rendering.
    String? categoryName,

    /// Optional per-item note.
    String? note,

    /// Optional 50/30/20 budget rule allocation tag.
    TransactionAllocation? allocation,
  }) = _SplitItem;
}
