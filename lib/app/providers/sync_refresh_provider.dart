/// Provides an optional pull-to-refresh sync callback for screens.
///
/// CE registers a no-op `null` by default, preserving CE blindness from
/// any cloud or sync logic. External consumers (e.g. Poka PE) can override
/// this provider via [ProviderScope] to inject a real sync action.
///
/// Usage in a screen:
/// ```dart
/// final onSyncRefresh = ref.watch(onSyncRefreshProvider);
/// ```
///
/// Usage in a PE ProviderScope override:
/// ```dart
/// onSyncRefreshProvider.overrideWithValue(
///   () => ref.read(syncNotifierProvider.notifier).syncNow(),
/// ),
/// ```
library;

import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A nullable async callback that, when non-null, is invoked on pull-to-refresh.
///
/// CE always provides `null`. PE overrides this with a cloud sync action.
final onSyncRefreshProvider = Provider<Future<void> Function()?>((ref) => null);
