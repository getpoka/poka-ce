import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/theme/theme.dart';

extension TransactionAllocationExt on TransactionAllocation {
  IconData icon() {
    switch (this) {
      case TransactionAllocation.need:
        return FPhosphorIcons.heart;
      case TransactionAllocation.want:
        return FPhosphorIcons.star;
      case TransactionAllocation.saving:
        return FPhosphorIcons.piggyBank;
    }
  }

  String label() {
    switch (this) {
      case TransactionAllocation.need:
        return 'Need';
      case TransactionAllocation.want:
        return 'Want';
      case TransactionAllocation.saving:
        return 'Saving';
    }
  }

  Color color(BuildContext context) {
    final theme = context.theme;
    switch (this) {
      case TransactionAllocation.need:
        return theme.colors.primary;
      case TransactionAllocation.want:
        return theme.colors.app.warning;
      case TransactionAllocation.saving:
        return theme.colors.app.success;
    }
  }
}

class TransactionCreateMetaBar extends StatelessWidget {
  const TransactionCreateMetaBar({
    required this.note,
    required this.type,
    required this.typeColor,
    required this.onPickNote,
    this.allocation,
    this.onAllocationChanged,
    this.showAllocation = true,
    super.key,
  });

  final String note;
  final TransactionType type;
  final Color typeColor;
  final VoidCallback onPickNote;
  final TransactionAllocation? allocation;
  final ValueChanged<TransactionAllocation?>? onAllocationChanged;
  final bool showAllocation;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Fixed height ensures the row doesn't shift the divider above regardless
    // of whether the allocation pill row is visible (expense only).
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 6),
      child: SizedBox(
        height: 32,
        child: Row(
          children: [
            // Note Section
            Expanded(
              child: GestureDetector(
                onTap: onPickNote,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Icon(
                      FPhosphorIcons.notePencil,
                      size: 18,
                      color: note.isEmpty ? theme.colors.mutedForeground : theme.colors.foreground,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        note.isEmpty ? 'Add note...' : note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.typography.bodyPrimary.copyWith(
                          color: note.isEmpty ? theme.colors.mutedForeground : theme.colors.foreground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (showAllocation && type == TransactionType.expense) ...[
              const SizedBox(width: 8),
              Flexible(
                child: TransactionAllocationSelector(
                  allocation: allocation,
                  onChanged: onAllocationChanged,
                ),
              ),
            ] else ...[
              const SizedBox.shrink(),
            ],
          ],
        ),
      ),
    );
  }
}

class TransactionAllocationSelector extends StatelessWidget {
  const TransactionAllocationSelector({
    super.key,
    this.allocation,
    this.onChanged,
  });

  final TransactionAllocation? allocation;
  final ValueChanged<TransactionAllocation?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: TransactionAllocation.values.map((alloc) {
          final isSel = allocation == alloc;
          final color = alloc.color(context);

          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: GestureDetector(
              onTap: () {
                if (onChanged == null) return;
                HapticFeedback.selectionClick();
                onChanged!(isSel ? null : alloc);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isSel ? color.withValues(alpha: 0.15) : theme.colors.background,
                  borderRadius: theme.style.borderRadius.lg,
                  border: Border.all(
                    color: isSel ? color.withValues(alpha: 0.5) : theme.colors.border,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      alloc.icon(),
                      size: 16,
                      color: isSel ? color : theme.colors.mutedForeground,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      alloc.label(),
                      style: theme.typography.bodySecondary.copyWith(
                        color: isSel ? color : theme.colors.mutedForeground,
                        fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
