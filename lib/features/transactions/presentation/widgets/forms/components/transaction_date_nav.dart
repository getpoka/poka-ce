/// Date and time navigation widget for the transaction form.
/// Allows stepping forward/backward or selecting a specific date.
library;

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

class TransactionDateNav extends StatelessWidget {
  const TransactionDateNav({
    required this.selectedDate,
    required this.onStepDate,
    required this.onDateChanged,
    required this.onTimeChanged,
    super.key,
  });

  final DateTime selectedDate;
  final void Function(int) onStepDate;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<DateTime> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TransactionNavArrow(
          icon: FPhosphorIcons.caretLeft,
          theme: theme,
          onTap: () => onStepDate(-1),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: FDateField.calendar(
            selectionControl: FDateSelectionControl.liftedSingle(
              value: selectedDate,
              onChange: (date) {
                if (date == null) return;
                onDateChanged(
                  DateTime(
                    date.year,
                    date.month,
                    date.day,
                    selectedDate.hour,
                    selectedDate.minute,
                  ),
                );
              },
              toggleable: false,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FTimeField.picker(
            control: FTimeFieldControl.lifted(
              time: FTime.fromDateTime(selectedDate),
              onChange: (time) {
                if (time != null) {
                  onTimeChanged(
                    DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      time.hour,
                      time.minute,
                    ),
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 4),
        TransactionNavArrow(
          icon: FPhosphorIcons.caretRight,
          theme: theme,
          onTap: () => onStepDate(1),
        ),
      ],
    );
  }
}

class TransactionNavArrow extends StatelessWidget {
  const TransactionNavArrow({
    required this.icon,
    required this.theme,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final FThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      child: Icon(icon, size: 16, color: theme.colors.mutedForeground),
    ),
  );
}
