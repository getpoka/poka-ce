import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart';

/// Floating action button for adding a new transaction.
///
/// Features an outer ring in card color that creates a visual halo separating
/// the FAB from same-colored chart elements behind it.
class PokaAddTransactionFab extends StatelessWidget {
  /// Creates a [PokaAddTransactionFab].
  const PokaAddTransactionFab({
    this.onTap,
    super.key,
  });

  /// Optional tap callback. Defaults to opening [TransactionFormSheet].
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      key: const Key('transaction-add-button'),
      onTap: () {
        HapticFeedback.lightImpact();
        if (onTap != null) {
          onTap!();
        } else {
          TransactionFormSheet.show(context);
        }
      },
      // Outer ring in card color creates a visual halo that separates
      // the FAB from same-colored chart elements behind it.
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: theme.colors.card,
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: theme.colors.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            FPhosphorIcons.plus,
            size: 20,
            color: theme.colors.primaryForeground,
          ),
        ),
      ),
    );
  }
}
