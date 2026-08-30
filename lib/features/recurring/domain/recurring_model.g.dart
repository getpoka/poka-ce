// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecurringTransactionModel _$RecurringTransactionModelFromJson(
  Map<String, dynamic> json,
) => _RecurringTransactionModel(
  id: json['id'] as String,
  accountId: json['accountId'] as String,
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  period: $enumDecode(_$RecurringPeriodEnumMap, json['period']),
  nextDate: DateTime.parse(json['nextDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  destinationAccountId: json['destinationAccountId'] as String?,
  categoryId: json['categoryId'] as String?,
  allocation: $enumDecodeNullable(
    _$TransactionAllocationEnumMap,
    json['allocation'],
  ),
  note: json['note'] as String?,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$RecurringTransactionModelToJson(
  _RecurringTransactionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'accountId': instance.accountId,
  'type': _$TransactionTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'period': _$RecurringPeriodEnumMap[instance.period]!,
  'nextDate': instance.nextDate.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'destinationAccountId': instance.destinationAccountId,
  'categoryId': instance.categoryId,
  'allocation': _$TransactionAllocationEnumMap[instance.allocation],
  'note': instance.note,
  'isActive': instance.isActive,
};

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
  TransactionType.transfer: 'transfer',
};

const _$RecurringPeriodEnumMap = {
  RecurringPeriod.daily: 'daily',
  RecurringPeriod.weekly: 'weekly',
  RecurringPeriod.monthly: 'monthly',
  RecurringPeriod.yearly: 'yearly',
};

const _$TransactionAllocationEnumMap = {
  TransactionAllocation.need: 'need',
  TransactionAllocation.want: 'want',
  TransactionAllocation.saving: 'saving',
};
