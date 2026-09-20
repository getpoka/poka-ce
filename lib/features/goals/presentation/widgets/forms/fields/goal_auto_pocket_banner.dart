import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Informational banner explaining that creating a goal automatically provisions a dedicated pocket account.
class GoalAutoPocketBanner extends StatelessWidget {
  /// Creates a [GoalAutoPocketBanner].
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: context.theme.colors.muted, borderRadius: context.theme.style.borderRadius.sm),
      child: Row(
        children: [
          Icon(FPhosphorIcons.info, size: 16, color: context.theme.colors.mutedForeground),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t.goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal,
              style: context.theme.typography.bodySecondary.copyWith(color: context.theme.colors.mutedForeground),
            ),
          ),
        ],
      ),
    );
  }
}
