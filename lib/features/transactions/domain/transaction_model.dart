import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

/// Represents a single item within a transaction (for split transactions).
@freezed
abstract class TransactionItemModel with _$TransactionItemModel {
  const factory TransactionItemModel({
    required String id,
    required String transactionId,
    required int amount,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? categoryId,
    TransactionAllocation? allocation,
    String? note,
  }) = _TransactionItemModel;

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) => _$TransactionItemModelFromJson(json);
}

/// Represents a complete transaction (header) including its items.
@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String accountId,
    required TransactionType type,
    required int amount,
    required DateTime transactionDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? destinationAccountId,
    String? note,
    String? recurringTransactionId,
    String? debtId,
    @Default([]) List<TransactionItemModel> items,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
}
