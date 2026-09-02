// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebtModel _$DebtModelFromJson(Map<String, dynamic> json) => _DebtModel(
  id: json['id'] as String,
  personName: json['personName'] as String,
  type: $enumDecode(_$DebtTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  remainingAmount: (json['remainingAmount'] as num).toInt(),
  status: $enumDecode(_$DebtStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  note: json['note'] as String?,
);

Map<String, dynamic> _$DebtModelToJson(_DebtModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'personName': instance.personName,
      'type': _$DebtTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'remainingAmount': instance.remainingAmount,
      'status': _$DebtStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'note': instance.note,
    };

const _$DebtTypeEnumMap = {DebtType.debt: 'debt', DebtType.loan: 'loan'};

const _$DebtStatusEnumMap = {
  DebtStatus.active: 'active',
  DebtStatus.paid: 'paid',
};
