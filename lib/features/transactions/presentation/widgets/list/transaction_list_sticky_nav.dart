import 'package:flutter/material.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Pinned sliver header containing view-mode chips and the date navigator.
///
/// Pins itself below the header so the user can always navigate dates
/// while scrolling through the transaction list.
class TransactionListStickyNav extends SliverPersistentHeaderDelegate {
  TransactionListStickyNav({
    required this.state,
    required this.onModeChanged,
    required this.onPrev,
    required this.onNext,
    required this.onJump,
    required this.onToday,
  });

  final TransactionListState state;
  final ValueChanged<TransactionViewMode> onModeChanged;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final ValueChanged<DateTime> onJump;
  final VoidCallback onToday;

  /// Fixed height for the sticky area (chip row + date navigator + padding).
  static const double _height = 96;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  bool shouldRebuild(TransactionListStickyNav old) =>
      old.state.viewMode != state.viewMode ||
      old.state.focusedDate != state.focusedDate ||
      old.state.isCurrentPeriod != state.isCurrentPeriod;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = context.theme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.background,
        // Show a subtle border when content scrolls beneath this header.
        border: overlapsContent
            ? Border(
                bottom: BorderSide(
                  color: theme.colors.border,
                  width: theme.style.borderWidth,
                ),
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── View mode chips (Day / Week / Month) ─────────────────
            Row(
              children: TransactionViewMode.values.map((mode) {
                final isSelected = state.viewMode == mode;
                final label = switch (mode) {
                  TransactionViewMode.day => 'Day',
                  TransactionViewMode.week => 'Week',
                  TransactionViewMode.month => 'Month',
                };
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onModeChanged(mode),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.colors.primary : theme.colors.muted,
                        borderRadius: theme.style.borderRadius.sm,
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: theme.typography.bodyPrimary.copyWith(
                            color: isSelected ? theme.colors.primaryForeground : theme.colors.mutedForeground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // ── Date navigator ────────────────────────────────────────
            Row(
              children: [
                // Previous period
                GestureDetector(
                  onTap: onPrev,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Icon(
                      FPhosphorIcons.caretLeft,
                      size: 18,
                      color: theme.colors.foreground,
                    ),
                  ),
                ),

                // Period label — tappable to show a calendar popover
                Expanded(
                  child: FPopover(
                    builder: (context, popoverController, child) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: popoverController.toggle,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.periodLabel,
                              textAlign: TextAlign.center,
                              style: theme.typography.bodyPrimary.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                            ),
                            // "Back to today" is only shown for week/month — in day
                            // mode the label itself ("Today" / "Yesterday") is enough.
                            if (!state.isCurrentPeriod && state.viewMode != TransactionViewMode.day) ...[
                              const SizedBox(height: 1),
                              GestureDetector(
                                onTap: onToday,
                                child: Text(
                                  t.transactions.backToToday,
                                  style: theme.typography.bodySecondary.copyWith(color: theme.colors.primary),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                    popoverBuilder: (context, popoverController) {
                      return FCalendar.grid(
                        selectionControl: FDateSelectionControl.managedSingle(
                          initial: state.focusedDate,
                          onChange: (newDate) {
                            if (newDate != null) onJump(newDate);
                            popoverController.hide();
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Next period (disabled at current period).
                GestureDetector(
                  onTap: state.isCurrentPeriod ? null : onNext,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Icon(
                      FPhosphorIcons.caretRight,
                      size: 18,
                      color: state.isCurrentPeriod
                          ? theme.colors.mutedForeground.withValues(alpha: 0.35)
                          : theme.colors.foreground,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
