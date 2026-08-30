import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_model.freezed.dart';
part 'currency_model.g.dart';

@freezed
abstract class CurrencyModel with _$CurrencyModel {
  const factory CurrencyModel({
    required String id,
    required String name,
    required String code,
    required String symbol,
    required int precision,
  }) = _CurrencyModel;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => _$CurrencyModelFromJson(json);
}
