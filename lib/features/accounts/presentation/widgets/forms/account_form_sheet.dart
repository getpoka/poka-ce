import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/icon_util.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_form_notifier.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/fields/active_account_toggle.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/fields/category_selection_field.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/pickers/poka_color_picker.dart';
import 'package:poka_ce/shared/widgets/pickers/poka_icon_picker.dart';
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
    final notifier = ref.read(accountFormProvider.notifier);
    final state = ref.watch(accountFormProvider);

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
      accountFormProvider,
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
                    borderRadius: BorderRadius.circular(16),
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
        ActiveAccountToggle(
          isActive: state.isActive,
          onChanged: (val) => notifier.setIsActive(isActive: val),
        ),
        const SizedBox(height: 12),
        if (state.parentAccountId == null) ...[
          CategorySelectionField(
            notifier: notifier,
            restrictedCategoryIds: state.restrictedCategoryIds.toSet(),
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
