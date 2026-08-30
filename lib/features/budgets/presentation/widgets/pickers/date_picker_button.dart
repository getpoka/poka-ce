import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class DatePickerButton extends HookWidget {
  const DatePickerButton({required this.date, required this.onChanged, super.key});

  final DateTime? date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final text = date != null ? DateFormat.yMMMd().format(date!) : '';
    final controller = useTextEditingController(text: text);

    useEffect(() {
      controller.text = text;
      return null;
    }, [text]);

    return FPopover(
      builder: (context, popoverController, child) {
        return FTextField(
          control: FTextFieldControl.managed(controller: controller),
          label: Text(t.budgets.endDate),
          hint: t.budgets.selectEndDate,
          readOnly: true,
          onTap: () {
            FocusScope.of(context).unfocus();
            popoverController.toggle();
          },
          prefixBuilder: (context, style, variants) => FTextField.prefixIconBuilder(
            context,
            style,
            variants,
            const Icon(FPhosphorIcons.calendarBlank, size: 18),
          ),
          suffixBuilder: (context, style, variants) => Padding(
            padding: const EdgeInsetsDirectional.only(end: 12, start: 4),
            child: IconTheme(
              data: style.iconStyle.resolve(variants),
              child: const Icon(FPhosphorIcons.caretDown, size: 16),
            ),
          ),
        );
      },
      popoverBuilder: (context, popoverController) {
        return FCalendar.grid(
          selectionControl: FDateSelectionControl.managedSingle(
            initial: date,
            onChange: (newDate) {
              if (newDate != null) onChanged(newDate);
              popoverController.hide();
            },
          ),
        );
      },
    );
  }
}
