import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class AccountFormState {
  const AccountFormState({
    this.initialAccount,
    this.name = '',
    this.type = AccountType.assets,
    this.balance = 0,
    this.icon,
    this.color,
    this.parentAccountId,
    this.isActive = true,
    this.restrictedCategoryIds = const [],
    this.isSaving = false,
    this.isSuccess = false,
    this.error,
    this.nameError,
  });

  final AccountModel? initialAccount;
  final String name;
  final AccountType type;
  final int balance;
  final String? icon;
  final String? color;
  final String? parentAccountId;
  final bool isActive;
  final List<String> restrictedCategoryIds;
  final bool isSaving;
  final bool isSuccess;
  final String? error;
  final String? nameError;

  AccountFormState copyWith({
    AccountModel? initialAccount,
    String? name,
    AccountType? type,
    int? balance,
    String? icon,
    String? color,
    String? parentAccountId,
    bool? isActive,
    List<String>? restrictedCategoryIds,
    bool? isSaving,
    bool? isSuccess,
    String? error,
    String? nameError,
    bool clearNameError = false,
  }) {
    return AccountFormState(
      initialAccount: initialAccount ?? this.initialAccount,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      parentAccountId: parentAccountId ?? this.parentAccountId,
      isActive: isActive ?? this.isActive,
      restrictedCategoryIds: restrictedCategoryIds ?? this.restrictedCategoryIds,
      isSaving: isSaving ?? this.isSaving,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      nameError: clearNameError ? null : (nameError ?? this.nameError),
    );
  }
}

class AccountFormNotifier extends Notifier<AccountFormState> {
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

  void setName(String name) => state = state.copyWith(name: name, clearNameError: true);
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
    if (state.name.isEmpty) {
      state = state.copyWith(nameError: t.accounts.nameCannotBeEmpty);
      return;
    }

    state = state.copyWith(isSaving: true, clearNameError: true);
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

final accountFormNotifierProvider = NotifierProvider<AccountFormNotifier, AccountFormState>(() {
  return AccountFormNotifier();
});
