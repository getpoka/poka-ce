// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$AccountTypeEnumMap, json['type']),
      balance: (json['balance'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      initialBalance: (json['initialBalance'] as num?)?.toInt() ?? 0,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      parentId: json['parentId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      sort: (json['sort'] as num?)?.toInt() ?? 0,
      restrictedCategoryIds:
          (json['restrictedCategoryIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AccountTypeEnumMap[instance.type]!,
      'balance': instance.balance,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'initialBalance': instance.initialBalance,
      'icon': instance.icon,
      'color': instance.color,
      'parentId': instance.parentId,
      'isActive': instance.isActive,
      'sort': instance.sort,
      'restrictedCategoryIds': instance.restrictedCategoryIds,
    };

const _$AccountTypeEnumMap = {
  AccountType.assets: 'assets',
  AccountType.liability: 'liability',
  AccountType.goal: 'goal',
};
