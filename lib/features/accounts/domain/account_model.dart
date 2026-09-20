import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

/// Represents a financial account (e.g., Wallet, Bank) or Pocket.
@freezed
abstract class AccountModel with _$AccountModel {
  const factory({
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
    @Default(false) bool isDefault,
    @Default(0) int sort,
    @Default([]) List<String> restrictedCategoryIds,
  }) = _AccountModel;
  const new _();

  factory fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  bool get isPocket => parentId != null;

  /// Whether this pocket is the immutable default main pocket of its parent account.
  bool get isMainPocket => isPocket && isDefault;

  /// Whether this account or pocket can be deleted by the user.
  ///
  /// The primary main pocket is non-deletable to guarantee a permanent default destination.
  bool get canDelete => !isDefault;

  List<String> effectiveRestrictedCategoryIds(AccountModel? parent) {
    if (!isPocket) return restrictedCategoryIds;
    if (restrictedCategoryIds.isEmpty && parent != null) {
      return parent.restrictedCategoryIds;
    }
    return restrictedCategoryIds;
  }
}
