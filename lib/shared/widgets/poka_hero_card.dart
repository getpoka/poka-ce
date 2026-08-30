import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

/// Standardized hero summary card used across the app (Budgets, Goals, Debts, Accounts, Transactions).
/// Ensures consistent height, padding, and layout structure.
class PokaHeroCard extends StatelessWidget {
  const PokaHeroCard({
    required this.pills,
    required this.title,
    required this.amount,
    required this.leftSubAmount,
    required this.rightSubAmount,
    this.trailing,
    this.progress,
    this.cardColor,
    super.key,
  });

  /// The pills to display at the top left (e.g., number of items, status).
  final List<Widget> pills;

  /// Optional trailing widget at the top right (e.g., eye icon for balance visibility).
  final Widget? trailing;

  /// The main title of the card (e.g., 'Remaining', 'Net Balance').
  final String title;

  /// The main large amount widget.
  final Widget amount;

  /// The progress value between 0.0 and 1.0. If null, a blank space of the same height is used to maintain consistent card height.
  final double? progress;

  /// The left sub-amount widget.
  final Widget leftSubAmount;

  /// The right sub-amount widget.
  final Widget rightSubAmount;

  /// The primary color of the card gradient. Defaults to theme primary color.
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final primaryColor = cardColor ?? theme.colors.primary;

    return FCard(
      style: FCardStyle(
        padding: theme.cardStyle.padding,
        decoration: ShapeDecoration(
          shape: ((theme.cardStyle.decoration as ShapeDecoration).shape as OutlinedBorder).copyWith(
            side: BorderSide.none,
          ),
          gradient: LinearGradient(
            colors: [
              primaryColor,
              Color.lerp(primaryColor, Colors.black, 0.35) ?? primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        titleTextStyle: theme.cardStyle.titleTextStyle,
        subtitleTextStyle: theme.cardStyle.subtitleTextStyle,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Top Row (Pills & Trailing) ───────────────────────────────
            Row(
              children: [
                ...pills,
                const Spacer(),
                ?trailing,
              ],
            ),
            const SizedBox(height: 16),

            // ── Middle Section (Label & Amount) ──────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.bodySecondary.copyWith(
                    color: theme.colors.primaryForeground.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 6),
                amount,
              ],
            ),

            // ── Progress & Spacing ───────────────────────────────────────
            if (progress != null) ...[
              const SizedBox(height: 12),
              _HeroCardProgressBar(progress: progress!),
              const SizedBox(height: 12),
            ] else ...[
              // Maintain the exact height of (12 + 6 + 12 = 30) for cards without progress
              const SizedBox(height: 30),
            ],

            // ── Bottom Row (Sub Amounts) ─────────────────────────────────
            Row(
              children: [
                Expanded(child: leftSubAmount),
                const SizedBox(width: 24),
                Expanded(child: rightSubAmount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A standard pill used in the top row of the hero card.
class PokaHeroCardPill extends StatelessWidget {
  const PokaHeroCardPill({required this.icon, required this.label, super.key});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      margin: const EdgeInsets.only(right: 8), // Gap between pills
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colors.primaryForeground.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: theme.colors.primaryForeground),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.typography.bodySecondary.copyWith(
              color: theme.colors.primaryForeground,
            ),
          ),
        ],
      ),
    );
  }
}

/// A standard sub-amount used in the bottom row of the hero card.
class PokaHeroCardSubAmount extends StatelessWidget {
  const PokaHeroCardSubAmount({
    required this.label,
    required this.icon,
    this.amount,
    this.type,
    this.customAmountWidget,
    this.isObscured = false,
    super.key,
  }) : assert(amount != null || customAmountWidget != null, 'Provide amount or customAmountWidget');

  final String label;
  final int? amount;
  final TransactionType? type;
  final IconData icon;
  final Widget? customAmountWidget;
  final bool isObscured;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: theme.colors.primaryForeground.withValues(alpha: 0.7)),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                label,
                style: theme.typography.bodySecondary.copyWith(
                  color: theme.colors.primaryForeground.withValues(alpha: 0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        if (customAmountWidget != null)
          customAmountWidget!
        else
          PokaAmountText(
            amount: amount!,
            type: type ?? TransactionType.income,
            isObscured: isObscured,
            style: theme.typography.bodyPrimary.copyWith(
              color: theme.colors.primaryForeground,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class _HeroCardProgressBar extends StatelessWidget {
  const _HeroCardProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: 6,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          color: theme.colors.primaryForeground.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colors.primaryForeground,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
