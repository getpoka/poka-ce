import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_form_notifier.freezed.dart';
part 'account_form_notifier.g.dart';

@freezed
abstract class AccountFormState with _$AccountFormState {
  const factory AccountFormState({
    AccountModel? initialAccount,
    @Default('') String name,
    @Default(AccountType.assets) AccountType type,
    @Default(0) int balance,
    String? icon,
    String? color,
    String? parentAccountId,
    @Default(true) bool isActive,
    @Default([]) List<String> restrictedCategoryIds,
    @Default(false) bool isSaving,
    @Default(false) bool isSuccess,
    String? error,
  }) = _AccountFormState;
}

@riverpod
class AccountFormNotifier extends _$AccountFormNotifier {
  @override
  AccountFormState build() {
    return const AccountFormState();
  }

  void init(AccountModel? account, {String? parentAccountId}) {
    if (account != null) {
      state = AccountFormState(
        initialAccount: account,
        name: account.name,
        type: account.type,
        balance: account.balance,
        icon: account.icon,
        color: account.color,
        parentAccountId: account.parentId,
        isActive: account.isActive,
        restrictedCategoryIds: account.restrictedCategoryIds,
      );
    } else {
      state = AccountFormState(parentAccountId: parentAccountId);
    }
  }

  void setName(String name) => state = state.copyWith(name: name);
  void setType(AccountType type) => state = state.copyWith(type: type);
  void setBalance(int balance) => state = state.copyWith(balance: balance);
  void setIcon(String icon) => state = state.copyWith(icon: icon);
  void setColor(String color) => state = state.copyWith(color: color);
  void setIsActive({required bool isActive}) => state = state.copyWith(isActive: isActive);

  void toggleRestrictedCategory(String categoryId) {
    final current = List<String>.from(state.restrictedCategoryIds);
    if (current.contains(categoryId)) {
      current.remove(categoryId);
    } else {
      current.add(categoryId);
    }
    state = state.copyWith(restrictedCategoryIds: current);
  }

  /// Toggles a parent category together with all of its [childIds].
  ///
  /// If the parent is not yet selected, adds the parent and all children.
  /// If the parent is already selected, removes the parent and all children.
  void toggleParentCategory(String parentId, List<String> childIds) {
    final current = List<String>.from(state.restrictedCategoryIds);
    if (current.contains(parentId)) {
      // Deselect parent and all children
      current
        ..remove(parentId)
        ..removeWhere(childIds.contains);
    } else {
      // Select parent and all children (avoid duplicates)
      if (!current.contains(parentId)) current.add(parentId);
      for (final id in childIds) {
        if (!current.contains(id)) current.add(id);
      }
    }
    state = state.copyWith(restrictedCategoryIds: current);
  }

  /// Toggles a single child category.
  ///
  /// After toggling, if all [allSiblingIds] (all children of the same parent)
  /// are selected, also selects [parentId]. If any sibling is deselected,
  /// removes [parentId] from the selection.
  void toggleChildCategory({
    required String categoryId,
    required String parentId,
    required List<String> allSiblingIds,
  }) {
    final current = List<String>.from(state.restrictedCategoryIds);
    if (current.contains(categoryId)) {
      current.remove(categoryId);
    } else {
      current.add(categoryId);
    }

    // Sync parent state: checked iff all siblings are checked
    final allChecked = allSiblingIds.every(current.contains);
    if (allChecked) {
      if (!current.contains(parentId)) current.add(parentId);
    } else {
      current.remove(parentId);
    }

    state = state.copyWith(restrictedCategoryIds: current);
  }

  Future<void> save() async {
    state = state.copyWith(isSaving: true);
    final result = state.initialAccount == null
        ? await ref
              .read(createAccountUseCaseProvider)
              .execute(
                name: state.name,
                type: state.type,
                balance: state.balance,
                icon: state.icon,
                color: state.color,
                parentId: state.parentAccountId,
                isActive: state.isActive,
                restrictedCategoryIds: state.restrictedCategoryIds,
              )
        : await ref
              .read(updateAccountUseCaseProvider)
              .execute(
                account: state.initialAccount!,
                name: state.name,
                icon: state.icon,
                color: state.color,
                isActive: state.isActive,
                restrictedCategoryIds: state.restrictedCategoryIds,
              );

    switch (result) {
      case Success():
        state = state.copyWith(isSaving: false, isSuccess: true);
      case ErrorResult(error: final failure):
        state = state.copyWith(
          error: failure.message,
          isSaving: false,
        );
    }
  }
}
