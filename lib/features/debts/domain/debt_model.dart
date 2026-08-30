import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'debt_model.freezed.dart';
part 'debt_model.g.dart';

@freezed
abstract class DebtModel with _$DebtModel {
  const factory DebtModel({
    required String id,
    required String personName,
    required DebtType type,
    required int amount,
    required int remainingAmount,
    required DebtStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? dueDate,
    String? note,
  }) = _DebtModel;

  factory DebtModel.fromJson(Map<String, dynamic> json) => _$DebtModelFromJson(json);
}
