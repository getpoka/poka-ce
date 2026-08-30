import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

/// Represents a financial account (e.g., Wallet, Bank) or Pocket.
@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required String id,
    required String name,
    required AccountType type,
    required int balance,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int initialBalance,
    String? icon,
    String? color,
    String? parentId,
    @Default(true) bool isActive,
    @Default(0) int sort,
    @Default([]) List<String> restrictedCategoryIds,
  }) = _AccountModel;
  const AccountModel._();

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  bool get isPocket => parentId != null;

  List<String> effectiveRestrictedCategoryIds(AccountModel? parent) {
    if (!isPocket) return restrictedCategoryIds;
    if (restrictedCategoryIds.isEmpty && parent != null) {
      return parent.restrictedCategoryIds;
    }
    return restrictedCategoryIds;
  }
}
