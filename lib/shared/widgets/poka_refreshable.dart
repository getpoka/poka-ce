/// Shared widget that conditionally wraps a scrollable child with a
/// [RefreshIndicator] when an external sync callback is registered.
///
/// Screens use [PokaRefreshable] instead of bare [RefreshIndicator] or
/// [CustomScrollView] to remain CE-blind from any cloud or sync logic.
/// The [onSyncRefreshProvider] defaults to `null` in CE; PE overrides it
/// to trigger a real cloud sync on pull.
///
/// ### Usage
///
/// Wrap any [CustomScrollView] or [SingleChildScrollView] inside this widget:
///
/// ```dart
/// PokaRefreshable(
///   onLocalRefresh: notifier.refresh,
///   child: CustomScrollView(...),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/providers/sync_refresh_provider.dart';

/// A widget that wraps a scrollable [child] with a [RefreshIndicator].
///
/// When [onSyncRefreshProvider] supplies a non-null callback (e.g. injected
/// by PE), the pull gesture runs both [onLocalRefresh] and the sync callback.
/// Otherwise, only [onLocalRefresh] is called — preserving CE offline-first
/// behaviour without any knowledge of cloud sync.
class PokaRefreshable extends ConsumerWidget {
  /// Creates a [PokaRefreshable].
  ///
  /// [child] must be a scrollable widget (e.g. [CustomScrollView],
  /// [SingleChildScrollView], or [ListView]).
  ///
  /// [onLocalRefresh] is called on every pull gesture. The sync callback from
  /// [onSyncRefreshProvider] is additionally awaited when present.
  const new({required this.child, required this.onLocalRefresh, super.key});

  /// The scrollable content to display.
  final Widget child;

  /// Local refresh callback — always called on pull.
  ///
  /// Typically delegates to a Riverpod Notifier refresh method, e.g.
  /// `() => ref.read(myNotifier.notifier).refresh()`.
  final Future<void> Function() onLocalRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onSyncRefresh = ref.watch(onSyncRefreshProvider);

    return RefreshIndicator(
      onRefresh: () async {
        // Always run local provider refresh first.
        await onLocalRefresh();
        // Additionally run the sync callback when PE (or another consumer)
        // has registered one via ProviderScope override.
        if (onSyncRefresh != null) {
          await onSyncRefresh();
        }
      },
      child: child,
    );
  }
}
