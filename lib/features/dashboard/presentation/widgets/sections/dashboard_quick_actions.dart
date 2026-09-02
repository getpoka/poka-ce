import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_quick_actions_provider.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

class DashboardQuickActions extends ConsumerWidget {
  const DashboardQuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.watch(dashboardQuickActionsProvider);

    const itemWidth = 60.0;
    const gapWidth = 8.0;
    const visibleItems = 5;
    const viewportWidth = (itemWidth * visibleItems) + (gapWidth * (visibleItems - 1));

    final screenWidth = MediaQuery.sizeOf(context).width;
    final boxWidth = screenWidth < viewportWidth ? screenWidth : viewportWidth;

    return Center(
      child: SizedBox(
        width: boxWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < actions.length; i++) ...[
                if (i > 0) const SizedBox(width: gapWidth),
                SizedBox(
                  width: itemWidth,
                  child: _QuickActionItem(
                    icon: actions[i].icon,
                    label: actions[i].labelBuilder(context),
                    onTap: () => actions[i].onTap(context),
                  ).animate().fade(duration: 300.ms, delay: (i * 60).ms).slideX(begin: 0.15, end: 0),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokaIcon(
            icon: icon,
            shape: PokaIconShape.circle,
            size: PokaIconSize.large,
            useThemeBorderColor: true, // As requested by user
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.typography.caption.copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
