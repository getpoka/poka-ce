import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Indicates whether the app supports multi-currency features.
/// In CE, this is false. PE overrides this in ProviderScope.
final isMultiCurrencyProvider = Provider<bool>((ref) => false);
