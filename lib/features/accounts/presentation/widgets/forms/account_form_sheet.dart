import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_form_notifier.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/pickers/poka_color_picker.dart';
import 'package:poka_ce/shared/widgets/pickers/poka_icon_picker.dart';
import 'package:poka_ce/shared/widgets/poka_switch.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

class AccountFormSheet extends HookConsumerWidget {
  const AccountFormSheet({
    super.key,
    this.initialAccount,
    this.parentAccountId,
  });

  final AccountModel? initialAccount;
  final String? parentAccountId;

  static Future<void> show(
    BuildContext context, {
    AccountModel? initialAccount,
    String? parentAccountId,
  }) {
    return showPokaSheet(
      context: context,
      builder: (context) => AccountFormSheet(
        initialAccount: initialAccount,
        parentAccountId: parentAccountId,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(accountFormNotifierProvider.notifier);
    final state = ref.watch(accountFormNotifierProvider);

    useEffect(() {
      Future.microtask(() {
        notifier.init(initialAccount, parentAccountId: parentAccountId);
      });
      return null;
    }, [initialAccount, parentAccountId]);

    final nameController = useTextEditingController(text: initialAccount?.name ?? state.name);
    final balanceController = useTextEditingController(
      text: initialAccount != null && initialAccount!.balance != 0
          ? initialAccount!.balance.toString()
          : (state.balance != 0 ? state.balance.toString() : ''),
    );

    useEffect(() {
      void nameListener() {
        if (state.name != nameController.text) {
          notifier.setName(nameController.text);
        }
      }

      void balanceListener() {
        final val = int.tryParse(balanceController.text) ?? 0;
        if (state.balance != val) {
          notifier.setBalance(val);
        }
      }

      nameController.addListener(nameListener);
      balanceController.addListener(balanceListener);
      return () {
        nameController.removeListener(nameListener);
        balanceController.removeListener(balanceListener);
      };
    }, [nameController, balanceController]);

    ref.listen(
      accountFormNotifierProvider,
      (prev, next) {
        if (next.isSuccess && (prev?.isSuccess != true)) {
          Navigator.of(context).pop();
        }
        if (next.error != null && next.error != prev?.error) {
          showFToast(
            context: context,
            title: Text(next.error!),
            variant: FToastVariant.destructive,
          );
        }
      },
    );

    final formContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FTextField(
          control: FTextFieldControl.managed(controller: nameController),
          label: Text(t.accounts.accountName),
          hint: t.accounts.egMainWallet,
          error: state.nameError != null ? Text(state.nameError!) : null,
        ),
        const SizedBox(height: 12),
        FTextField(
          control: FTextFieldControl.managed(controller: balanceController),
          label: Text(t.accounts.initialBalance),
          hint: '0',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FLabel(
              layout: FLabelLayout.vertical,
              label: Text(t.accounts.icon),
              child: GestureDetector(
                onTap: () {
                  showPokaSheet<void>(
                    context: context,
                    builder: (context) => PokaSheet(
                      title: t.accounts.selectIcon,
                      child: PokaIconPicker(
                        selectedIcon: state.icon,
                        onIconSelected: (icon) {
                          notifier.setIcon(icon);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: (state.color?.toColor() ?? context.theme.colors.primary).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16), // Large rounded corners
                    border: Border.all(
                      color: (state.color?.toColor() ?? context.theme.colors.primary).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                        child: Icon(
                          IconUtil.getIcon(state.icon),
                          size: 40,
                          color: state.color?.toColor() ?? context.theme.colors.primary,
                        ),
                      ),
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: context.theme.colors.background,
                            shape: BoxShape.circle,
                            border: Border.all(color: context.theme.colors.border),
                          ),
                          child: Icon(
                            FPhosphorIcons.pencilSimple,
                            size: 16,
                            color: context.theme.colors.foreground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FLabel(
                layout: FLabelLayout.vertical,
                label: Text(t.accounts.color),
                child: PokaColorPicker(
                  selectedColor: state.color,
                  onColorSelected: notifier.setColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: context.theme.colors.muted.withValues(alpha: 0.4),
            borderRadius: context.theme.style.borderRadius.md,
            border: Border.all(color: context.theme.colors.border),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: state.isActive
                      ? context.theme.colors.primary.withValues(alpha: 0.12)
                      : context.theme.colors.muted.withValues(alpha: 0.6),
                  borderRadius: context.theme.style.borderRadius.sm,
                ),
                child: Icon(
                  state.isActive ? FPhosphorIcons.checkCircle : FPhosphorIcons.pause,
                  size: 18,
                  color: state.isActive ? context.theme.colors.primary : context.theme.colors.mutedForeground,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.accounts.activeAccount,
                      style: context.theme.typography.titleCard,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      t.accounts.inactiveAccountsWillBeHidden,
                      style: context.theme.typography.bodySecondary.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              PokaSwitch(
                value: state.isActive,
                onChange: (val) => notifier.setIsActive(isActive: val),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (state.parentAccountId == null) ...[
          GestureDetector(
            onTap: () {
              showPokaSheet<void>(
                context: context,
                builder: (context) => _CategorySelectionSheet(
                  notifier: notifier,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: context.theme.style.borderRadius.md,
                border: Border.all(
                  color: state.restrictedCategoryIds.isNotEmpty
                      ? context.theme.colors.primary.withValues(alpha: 0.5)
                      : context.theme.colors.border,
                ),
                color: state.restrictedCategoryIds.isNotEmpty
                    ? context.theme.colors.primary.withValues(alpha: 0.04)
                    : context.theme.colors.muted.withValues(alpha: 0.4),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: state.restrictedCategoryIds.isNotEmpty
                          ? context.theme.colors.primary.withValues(alpha: 0.12)
                          : context.theme.colors.muted.withValues(alpha: 0.6),
                      borderRadius: context.theme.style.borderRadius.sm,
                    ),
                    child: Icon(
                      FPhosphorIcons.tag,
                      size: 18,
                      color: state.restrictedCategoryIds.isNotEmpty
                          ? context.theme.colors.primary
                          : context.theme.colors.mutedForeground,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.accounts.allowedCategories,
                          style: context.theme.typography.bodyPrimary.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.theme.colors.foreground,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          state.restrictedCategoryIds.isEmpty
                              ? 'All categories allowed'
                              : '${state.restrictedCategoryIds.length} categories selected',
                          style: context.theme.typography.bodySecondary.copyWith(
                            color: state.restrictedCategoryIds.isNotEmpty
                                ? context.theme.colors.primary
                                : context.theme.colors.mutedForeground,
                            fontWeight: state.restrictedCategoryIds.isNotEmpty ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    FPhosphorIcons.caretRight,
                    size: 16,
                    color: context.theme.colors.mutedForeground,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
        FButton(
          mainAxisSize: MainAxisSize.min,
          onPress: state.isSaving ? null : notifier.save,
          prefix: state.isSaving ? const FCircularProgress() : null,
          child: Text(state.isSaving ? 'Please wait' : 'Save'),
        ),
      ],
    );

    return PokaSheet(
      title: initialAccount == null ? 'Add Account' : 'Edit Account',
      child: FTabs(
        control: FTabControl.lifted(
          index: state.type == AccountType.liability ? 1 : 0,
          onChange: (index) {
            notifier.setType(index == 1 ? AccountType.liability : AccountType.assets);
          },
        ),
        children: [
          FTabEntry(
            label: Text(t.accounts.assets),
            child: formContent,
          ),
          FTabEntry(
            label: Text(t.accounts.liability),
            child: formContent,
          ),
        ],
      ),
    );
  }
}

class _CategorySelectionSheet extends ConsumerWidget {
  const _CategorySelectionSheet({required this.notifier});

  final AccountFormNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(categoryListProvider);
    // Watch live form state — rebuilds on every selection change
    final formState = ref.watch(accountFormNotifierProvider);
    final selected = formState.restrictedCategoryIds.toSet();

    if (categoryState.isLoading) {
      return PokaSheet(
        title: t.accounts.allowedCategories,
        child: const Center(child: FCircularProgress()),
      );
    }

    final allCategories = categoryState.value ?? <CategoryModel>[];

    // Group: parentId → children
    final childrenMap = <String, List<CategoryModel>>{};
    final rootCategories = <CategoryModel>[];
    for (final cat in allCategories) {
      if (cat.parentId == null) {
        rootCategories.add(cat);
      } else {
        childrenMap.putIfAbsent(cat.parentId!, () => []).add(cat);
      }
    }

    // Split by type
    final incomeRoots = rootCategories.where((c) => c.type == CategoryType.income).toList();
    final expenseRoots = rootCategories.where((c) => c.type == CategoryType.expense).toList();

    Widget buildTab(List<CategoryModel> roots) {
      if (roots.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Center(
            child: Text(
              t.accounts.noCategoriesAvailable,
              style: context.theme.typography.body.md.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            ),
          ),
        );
      }

      final groups = <Widget>[];

      for (final parent in roots) {
        final children = childrenMap[parent.id] ?? [];
        final childIds = children.map((c) => c.id).toList();
        // IDs relevant to this group: parent + all children
        final groupIds = {parent.id, ...childIds};
        // Subset of selected that belongs to this group
        final groupSelected = selected.intersection(groupIds);

        final color = parent.color?.toColor() ?? context.theme.colors.primary;

        // Build all tiles for this group: parent tile first, then children
        final tiles = <FSelectTile<String>>[
          FSelectTile.suffix(
            prefix: Icon(IconUtil.getIcon(parent.icon), size: 18, color: color),
            title: Text(
              parent.name,
              style: context.theme.typography.titleCard,
            ),
            subtitle: children.isNotEmpty
                ? Text(
                    '${children.length} subcategor${children.length == 1 ? 'y' : 'ies'}',
                    style: context.theme.typography.bodySecondary.copyWith(
                      color: context.theme.colors.mutedForeground,
                    ),
                  )
                : null,
            value: parent.id,
          ),
          ...children.map((child) {
            final childColor = child.color?.toColor() ?? context.theme.colors.primary;
            return FSelectTile.suffix(
              prefix: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(
                  IconUtil.getIcon(child.icon),
                  size: 16,
                  color: childColor,
                ),
              ),
              title: Text(child.name),
              value: child.id,
            );
          }),
        ];

        groups
          ..add(
            FSelectTileGroup<String>(
              control: FMultiValueControl.lifted(
                value: groupSelected,
                onChange: (next) {
                  // Diff to detect which tile was toggled
                  final added = next.difference(groupSelected);
                  final removed = groupSelected.difference(next);
                  final toggled = added.isNotEmpty ? added.first : removed.first;

                  if (toggled == parent.id) {
                    // Parent tile tapped → toggle all children
                    notifier.toggleParentCategory(parent.id, childIds);
                  } else {
                    // Child tile tapped → toggle single child + sync parent
                    notifier.toggleChildCategory(
                      categoryId: toggled,
                      parentId: parent.id,
                      allSiblingIds: childIds,
                    );
                  }
                },
              ),
              children: tiles,
            ),
          )
          ..add(const SizedBox(height: 8));
      }

      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16),
        physics: const NeverScrollableScrollPhysics(),
        children: groups,
      );
    }

    return PokaSheet(
      title: t.accounts.allowedCategories,
      child: FTabs(
        children: [
          FTabEntry(
            label: Text(t.accounts.income),
            child: buildTab(incomeRoots),
          ),
          FTabEntry(
            label: Text(t.accounts.expense),
            child: buildTab(expenseRoots),
          ),
        ],
      ),
    );
  }
}
