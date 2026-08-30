import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'goal_model.freezed.dart';
part 'goal_model.g.dart';

@freezed
abstract class GoalModel with _$GoalModel {
  const factory GoalModel({
    required String id,
    required String accountId,
    required String name,
    required int targetAmount,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(GoalStatus.active) GoalStatus status,
    DateTime? targetDate,
    String? icon,
    String? color,
  }) = _GoalModel;

  factory GoalModel.fromJson(Map<String, dynamic> json) => _$GoalModelFromJson(json);
}
