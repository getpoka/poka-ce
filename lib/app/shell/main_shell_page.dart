import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_runner_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Main shell page hosting the bottom navigation bar.
/// Also triggers the recurring automation runner on every app startup.
class MainShellPage extends HookConsumerWidget {
  /// Creates the shell page with [navigationShell] from go_router.
  const MainShellPage({
    required this.navigationShell,
    super.key,
  });

  /// The navigation shell provided by go_router.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger recurring processor on every app startup (fire-and-forget).
    ref.watch(recurringRunnerProvider);

    final isFabVisible = useState(true);
    final accumulatedScroll = useState<double>(0);

    // Reset FAB visibility when changing tabs
    useEffect(() {
      isFabVisible.value = true;
      accumulatedScroll.value = 0.0;
      return null;
    }, [navigationShell.currentIndex]);

    return FScaffold(
      childPad: false,
      footer: FBottomNavigationBar(
        index: navigationShell.currentIndex,
        onChange: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        children: [
          FBottomNavigationBarItem(
            icon: const Icon(FPhosphorIcons.house, key: Key('nav_home')),
            label: Text(t.app.nav.home),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FPhosphorIcons.shoppingCart, key: Key('nav_transactions')),
            label: Text(t.app.nav.transactions),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FPhosphorIcons.chartPieSlice, key: Key('nav_reports')),
            label: Text(t.app.nav.reports),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FPhosphorIcons.wallet, key: Key('nav_accounts')),
            label: Text(t.app.nav.accounts),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FPhosphorIcons.gear, key: Key('nav_settings')),
            label: Text(t.app.nav.settings),
          ),
        ],
      ),
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis == Axis.vertical) {
            // Always show the FAB if the user is at or very near the top of the screen
            if (notification.metrics.pixels <= 50) {
              if (!isFabVisible.value) isFabVisible.value = true;
              accumulatedScroll.value = 0.0;
              return false;
            }

            final dy = notification.scrollDelta ?? 0.0;
            if ((dy > 0 && accumulatedScroll.value < 0) || (dy < 0 && accumulatedScroll.value > 0)) {
              accumulatedScroll.value = 0.0;
            }

            accumulatedScroll.value += dy;

            const threshold = 50.0;

            if (accumulatedScroll.value > threshold) {
              if (isFabVisible.value) isFabVisible.value = false;
              accumulatedScroll.value = 0.0;
            } else if (accumulatedScroll.value < -threshold) {
              if (!isFabVisible.value) isFabVisible.value = true;
              accumulatedScroll.value = 0.0;
            }
          }
          return false;
        },
        child: Stack(
          children: [
            navigationShell,
            if (navigationShell.currentIndex == 0 || navigationShell.currentIndex == 1)
              Positioned(
                right: 20,
                bottom: 20,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  offset: isFabVisible.value ? Offset.zero : const Offset(0, 2),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    opacity: isFabVisible.value ? 1.0 : 0.0,
                    child: _AddTransactionFab(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Circular FAB for adding a new transaction, using the theme primary color.
class _AddTransactionFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      key: const Key('transaction-add-button'),
      onTap: () {
        HapticFeedback.lightImpact();
        TransactionFormSheet.show(context);
      },
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
    );
  }
}
