import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';

class TransactionTypeSwitcher extends StatelessWidget {
  const TransactionTypeSwitcher({
    required this.selectedType,
    required this.onChanged,
    this.disabled = false,
    super.key,
  });

  final TransactionType selectedType;
  final ValueChanged<TransactionType> onChanged;
  final bool disabled;

  static const List<TransactionType> _types = [
    TransactionType.income,
    TransactionType.expense,
    TransactionType.transfer,
  ];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Opacity(
        opacity: disabled ? 0.6 : 1.0,
        child: FTabs(
          control: FTabControl.lifted(
            index: _types.indexOf(selectedType),
            onChange: (idx) => onChanged(_types[idx]),
          ),
          children: _types.map((type) {
            return FTabEntry(
              label: Text(type.name.substring(0, 1).toUpperCase() + type.name.substring(1)),
              child: const SizedBox.shrink(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
