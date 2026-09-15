import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_model.freezed.dart';
part 'currency_model.g.dart';

@freezed
abstract class CurrencyModel with _$CurrencyModel {
  const factory({
    required String id,
    required String name,
    required String code,
    required String symbol,
    required int precision,
  }) = _CurrencyModel;

  factory fromJson(Map<String, dynamic> json) => _$CurrencyModelFromJson(json);
}
