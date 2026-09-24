import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Indicates whether the app supports multi-currency features.
/// Defaults to `false` for single-currency mode. Can be overridden in `ProviderScope`.
final isMultiCurrencyProvider = Provider<bool>((ref) => false);
