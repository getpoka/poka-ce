import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Indicates whether the app supports multi-currency features.
/// Defaults to `false` for single-currency mode. Can be overridden in `ProviderScope`.
final isMultiCurrencyProvider = Provider<bool>((ref) => false);

/// Callback signature for handling user taps on locked currency preferences.
typedef LockedCurrencyTapHandler = FutureOr<void> Function(BuildContext context);

/// Optional handler invoked when the locked base currency option is tapped in preferences.
///
/// When `null`, the default locked toast notification is shown. Downstream packages
/// (such as Poka PE) can override this to display a custom upgrade CTA or dialog.
final lockedCurrencyTapHandlerProvider = Provider<LockedCurrencyTapHandler?>((ref) => null);
