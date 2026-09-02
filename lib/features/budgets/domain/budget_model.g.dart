// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => _BudgetModel(
  id: json['id'] as String,
  name: json['name'] as String,
  amount: (json['amount'] as num).toInt(),
  period: $enumDecode(_$BudgetPeriodEnumMap, json['period']),
  startDate: DateTime.parse(json['startDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  categoryId: json['categoryId'] as String?,
  accountId: json['accountId'] as String?,
  resetDay: (json['resetDay'] as num?)?.toInt(),
  alertThreshold: (json['alertThreshold'] as num?)?.toInt(),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
);

Map<String, dynamic> _$BudgetModelToJson(_BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'period': _$BudgetPeriodEnumMap[instance.period]!,
      'startDate': instance.startDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'categoryId': instance.categoryId,
      'accountId': instance.accountId,
      'resetDay': instance.resetDay,
      'alertThreshold': instance.alertThreshold,
      'endDate': instance.endDate?.toIso8601String(),
    };

const _$BudgetPeriodEnumMap = {
  BudgetPeriod.monthly: 'monthly',
  BudgetPeriod.weekly: 'weekly',
  BudgetPeriod.yearly: 'yearly',
  BudgetPeriod.custom: 'custom',
};

_BudgetRecordModel _$BudgetRecordModelFromJson(Map<String, dynamic> json) =>
    _BudgetRecordModel(
      id: json['id'] as String,
      budgetId: json['budgetId'] as String,
      spentAmount: (json['spentAmount'] as num).toInt(),
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BudgetRecordModelToJson(_BudgetRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'budgetId': instance.budgetId,
      'spentAmount': instance.spentAmount,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
