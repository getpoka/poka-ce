import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

@freezed
abstract class BudgetModel with _$BudgetModel {
  const factory({
    required String id,
    required String name,
    required int amount,
    required BudgetPeriod period,
    required String startDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? categoryId,
    String? accountId,
    int? resetDay,
    int? alertThreshold,
    String? endDate,
  }) = _BudgetModel;

  factory fromJson(Map<String, dynamic> json) => _$BudgetModelFromJson(json);
}

/// Represents a tracking record for a specific budget period.
@freezed
abstract class BudgetRecordModel with _$BudgetRecordModel {
  const factory({
    required String id,
    required String budgetId,
    required int spentAmount,
    required String periodStart,
    required String periodEnd,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BudgetRecordModel;

  factory fromJson(Map<String, dynamic> json) => _$BudgetRecordModelFromJson(json);
}
