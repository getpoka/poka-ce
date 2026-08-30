// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionItemModel _$TransactionItemModelFromJson(
  Map<String, dynamic> json,
) => _TransactionItemModel(
  id: json['id'] as String,
  transactionId: json['transactionId'] as String,
  amount: (json['amount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  categoryId: json['categoryId'] as String?,
  allocation: $enumDecodeNullable(
    _$TransactionAllocationEnumMap,
    json['allocation'],
  ),
  note: json['note'] as String?,
);

Map<String, dynamic> _$TransactionItemModelToJson(
  _TransactionItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'transactionId': instance.transactionId,
  'amount': instance.amount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'categoryId': instance.categoryId,
  'allocation': _$TransactionAllocationEnumMap[instance.allocation],
  'note': instance.note,
};

const _$TransactionAllocationEnumMap = {
  TransactionAllocation.need: 'need',
  TransactionAllocation.want: 'want',
  TransactionAllocation.saving: 'saving',
};

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) => _TransactionModel(
  id: json['id'] as String,
  accountId: json['accountId'] as String,
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  transactionDate: DateTime.parse(json['transactionDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  destinationAccountId: json['destinationAccountId'] as String?,
  note: json['note'] as String?,
  recurringTransactionId: json['recurringTransactionId'] as String?,
  debtId: json['debtId'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => TransactionItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) => <String, dynamic>{
  'id': instance.id,
  'accountId': instance.accountId,
  'type': _$TransactionTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'transactionDate': instance.transactionDate.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'destinationAccountId': instance.destinationAccountId,
  'note': instance.note,
  'recurringTransactionId': instance.recurringTransactionId,
  'debtId': instance.debtId,
  'items': instance.items,
};

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
  TransactionType.transfer: 'transfer',
};
