import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

/// Represents a transaction category in the domain layer.
/// Used for budgeting and categorizing transactions (income/expense).
@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory({
    required String id,
    required String name,
    required CategoryType type,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? icon,
    String? color,
    String? parentId,
    @Default(0) int sort,
    @Default(true) bool isActive,
  }) = _CategoryModel;

  factory fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
}
