import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// A tab switcher widget allowing users to toggle between transaction types
/// ([TransactionType.income], [TransactionType.expense], [TransactionType.transfer]).
class TransactionTypeSwitcher extends StatelessWidget {
  /// Creates a [TransactionTypeSwitcher].
  const TransactionTypeSwitcher({
    required this.selectedType,
    required this.onChanged,
    this.disabled = false,
    super.key,
  });

  /// The currently selected transaction type.
  final TransactionType selectedType;

  /// Callback when a different transaction type is selected.
  final ValueChanged<TransactionType> onChanged;

  /// Whether the switcher is disabled from interaction.
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
            final label = switch (type) {
              TransactionType.income => context.t.transactions.income,
              TransactionType.expense => context.t.transactions.expense,
              TransactionType.transfer => context.t.transactions.transfer,
            };
            return FTabEntry(
              label: Text(label),
              child: const SizedBox.shrink(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
