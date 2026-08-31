import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_form_notifier.dart';
import 'package:poka_ce/features/categories/presentation/widgets/pickers/category_icon_picker_button.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/pickers/poka_color_picker.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

/// Bottom sheet for creating or editing a category.
class CategoryFormSheet extends HookConsumerWidget {
  const CategoryFormSheet({
    this.initialCategory,
    this.parentId,
    this.initialType,
    super.key,
  });

  final CategoryModel? initialCategory;
  final String? parentId;
  final CategoryType? initialType;

  static Future<void> show(
    BuildContext context, {
    CategoryModel? category,
    String? parentId,
    CategoryType? initialType,
  }) {
    return showPokaSheet(
      context: context,
      builder: (context) => CategoryFormSheet(
        initialCategory: category,
        parentId: parentId,
        initialType: initialType,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(categoryFormProvider.notifier);
    final state = ref.watch(categoryFormProvider);

    useEffect(() {
      Future.microtask(() {
        notifier.init(
          initialCategory,
          parentId: parentId,
          type: initialType,
        );
      });
      return null;
    }, [initialCategory, parentId, initialType]);

    final nameController = useTextEditingController(text: initialCategory?.name ?? state.name);

    useEffect(() {
      void listener() {
        if (state.name != nameController.text) {
          notifier.setName(nameController.text);
        }
      }

      nameController.addListener(listener);
      return () => nameController.removeListener(listener);
    }, [nameController]);

    ref.listen(
      categoryFormProvider,
      (prev, next) {
        if (next.isSuccess && (prev?.isSuccess != true)) {
          Navigator.of(context).pop();
        } else if (next.error != null && next.error != prev?.error) {
          showFToast(
            context: context,
            title: Text(next.error!),
            variant: FToastVariant.destructive,
          );
        }
      },
    );

    final isSubCategory = parentId != null || initialCategory?.parentId != null;

    final formContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FTextField(
          control: FTextFieldControl.managed(controller: nameController),
          label: Text(t.categories.categoryName),
          hint: t.categories.egFoodDining,
          error: state.nameError != null ? Text(state.nameError!) : null,
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FLabel(
              layout: FLabelLayout.vertical,
              label: Text(t.accounts.icon),
              child: CategoryIconPickerButton(
                selectedIcon: state.icon,
                selectedColor: state.color,
                onIconSelected: notifier.setIcon,
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
        const SizedBox(height: 20),
        FButton(
          mainAxisSize: MainAxisSize.min,
          onPress: state.isSaving ? null : notifier.save,
          prefix: state.isSaving ? const FCircularProgress() : null,
          child: Text(state.isSaving ? 'Please wait' : (isSubCategory ? 'Save Sub Category' : 'Save Category')),
        ),
      ],
    );

    final String title;
    if (initialCategory == null) {
      title = parentId != null ? 'New Sub Category' : 'New Category';
    } else {
      title = initialCategory!.parentId != null ? 'Edit Sub Category' : 'Edit Category';
    }

    return PokaSheet(
      title: title,
      child: isSubCategory
          ? formContent
          : FTabs(
              control: FTabControl.lifted(
                index: state.type == CategoryType.income ? 1 : 0,
                onChange: (index) {
                  notifier.setType(index == 1 ? CategoryType.income : CategoryType.expense);
                },
              ),
              children: [
                FTabEntry(
                  label: Text(t.accounts.expense),
                  child: formContent,
                ),
                FTabEntry(
                  label: Text(t.accounts.income),
                  child: formContent,
                ),
              ],
            ),
    );
  }
}
