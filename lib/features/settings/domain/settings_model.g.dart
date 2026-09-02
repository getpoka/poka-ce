// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    _SettingsModel(
      themeMode: json['themeMode'] as String,
      language: json['language'] as String? ?? 'system',
      numberFormat: json['numberFormat'] as String? ?? 'system',
      baseCurrency: json['baseCurrency'] == null
          ? null
          : CurrencyModel.fromJson(
              json['baseCurrency'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SettingsModelToJson(_SettingsModel instance) =>
    <String, dynamic>{
      'themeMode': instance.themeMode,
      'language': instance.language,
      'numberFormat': instance.numberFormat,
      'baseCurrency': instance.baseCurrency,
    };
