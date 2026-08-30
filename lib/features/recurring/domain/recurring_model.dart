import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'recurring_model.freezed.dart';
part 'recurring_model.g.dart';

@freezed
abstract class RecurringTransactionModel with _$RecurringTransactionModel {
  const factory RecurringTransactionModel({
    required String id,
    required String accountId,
    required TransactionType type,
    required int amount,
    required RecurringPeriod period,
    required DateTime nextDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? destinationAccountId,
    String? categoryId,
    TransactionAllocation? allocation,
    String? note,
    @Default(true) bool isActive,
  }) = _RecurringTransactionModel;

  factory RecurringTransactionModel.fromJson(Map<String, dynamic> json) => _$RecurringTransactionModelFromJson(json);
}
