import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_quick_actions_provider.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

class DashboardQuickActions extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.watch(dashboardQuickActionsProvider);
    final theme = context.theme;

    const itemWidth = 60.0;
    const gapWidth = 8.0;
    const visibleItems = 5;
    const viewportWidth = (itemWidth * visibleItems) + (gapWidth * (visibleItems - 1));

    final screenWidth = MediaQuery.sizeOf(context).width;
    final boxWidth = screenWidth < viewportWidth ? screenWidth : viewportWidth;
    final totalContentWidth = actions.isEmpty ? 0.0 : (itemWidth * actions.length) + (gapWidth * (actions.length - 1));
    final hasOverflow = totalContentWidth > boxWidth;

    final scrollController = useScrollController();
    final scrollOffset = useState<double>(0);

    final maxScrollExtent = (totalContentWidth - boxWidth).clamp(0.0, double.infinity);
    final pageCount = hasOverflow ? (totalContentWidth / boxWidth).ceil().clamp(2, 5) : 0;
    final progress = maxScrollExtent > 0 ? (scrollOffset.value / maxScrollExtent).clamp(0.0, 1.0) : 0.0;
    final activeDotIndex = pageCount > 1 ? (progress * (pageCount - 1)).round().clamp(0, pageCount - 1) : 0;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: boxWidth,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.axis == Axis.horizontal) {
                  scrollOffset.value = notification.metrics.pixels;
                }
                return false;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
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
          ),
          if (hasOverflow) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < pageCount; i++) ...[
                  if (i > 0) const SizedBox(width: 4),
                  _IndicatorDot(
                    isActive: i == activeDotIndex,
                    theme: theme,
                    onTap: () {
                      final target = (i / (pageCount - 1)) * maxScrollExtent;
                      scrollController.animateTo(target, duration: 250.ms, curve: Curves.easeOutCubic);
                    },
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  const new({required this.isActive, required this.theme, required this.onTap});

  final bool isActive;
  final FThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isActive ? 16 : 4,
          height: 4,
          decoration: BoxDecoration(
            color: isActive ? theme.colors.primary : theme.colors.mutedForeground.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const new({required this.icon, required this.label, required this.onTap});
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
