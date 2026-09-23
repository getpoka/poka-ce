import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_create_meta_bar.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_pill.dart';

/// A group of selectable pills for filtering transactions by 50/30/20 allocation tag.
class TransactionFilterAllocationGroup extends StatelessWidget {
  /// Creates a [TransactionFilterAllocationGroup].
  const new({required this.selectedAllocations, required this.onChanged, super.key});

  /// The currently selected allocation tags.
  final Set<TransactionAllocation> selectedAllocations;

  /// Called when the selection changes.
  final ValueChanged<Set<TransactionAllocation>> onChanged;

  @override
  Widget build(BuildContext context) {
    return FLabel(
      layout: FLabelLayout.vertical,
      label: Text(t.transactions.allocation),
      child: PokaPillScrollRow(
        children: TransactionAllocation.values.map((alloc) {
          final isSelected = selectedAllocations.contains(alloc);
          final color = alloc.color(context);
          return PokaPill(
            icon: alloc.icon(),
            label: alloc.label(),
            color: color,
            isSelected: isSelected,
            onTap: () {
              final next = Set<TransactionAllocation>.from(selectedAllocations);
              isSelected ? next.remove(alloc) : next.add(alloc);
              onChanged(next);
            },
          );
        }).toList(),
      ),
    );
  }
}
