import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

@freezed
abstract class BudgetModel with _$BudgetModel {
  const factory BudgetModel({
    required String id,
    required String name,
    required int amount,
    required BudgetPeriod period,
    required DateTime startDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? categoryId,
    String? accountId,
    int? resetDay,
    int? alertThreshold,
    DateTime? endDate,
  }) = _BudgetModel;

  factory BudgetModel.fromJson(Map<String, dynamic> json) => _$BudgetModelFromJson(json);
}

/// Represents a tracking record for a specific budget period.
@freezed
abstract class BudgetRecordModel with _$BudgetRecordModel {
  const factory BudgetRecordModel({
    required String id,
    required String budgetId,
    required int spentAmount,
    required DateTime periodStart,
    required DateTime periodEnd,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BudgetRecordModel;

  factory BudgetRecordModel.fromJson(Map<String, dynamic> json) => _$BudgetRecordModelFromJson(json);
}
