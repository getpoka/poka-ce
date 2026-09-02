// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalModel _$GoalModelFromJson(Map<String, dynamic> json) => _GoalModel(
  id: json['id'] as String,
  accountId: json['accountId'] as String,
  name: json['name'] as String,
  targetAmount: (json['targetAmount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  status:
      $enumDecodeNullable(_$GoalStatusEnumMap, json['status']) ??
      GoalStatus.active,
  targetDate: json['targetDate'] == null
      ? null
      : DateTime.parse(json['targetDate'] as String),
  icon: json['icon'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$GoalModelToJson(_GoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'name': instance.name,
      'targetAmount': instance.targetAmount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'status': _$GoalStatusEnumMap[instance.status]!,
      'targetDate': instance.targetDate?.toIso8601String(),
      'icon': instance.icon,
      'color': instance.color,
    };

const _$GoalStatusEnumMap = {
  GoalStatus.active: 'active',
  GoalStatus.completed: 'completed',
};
