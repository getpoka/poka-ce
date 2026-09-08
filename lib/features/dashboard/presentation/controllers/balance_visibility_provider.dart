import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance_visibility_provider.g.dart';

/// Notifier tracking the UI visibility toggle for sensitive financial figures.
@riverpod
class BalanceVisibility extends _$BalanceVisibility {
  @override
  bool build() => true;

  /// Toggles visibility of financial numbers (e.g. net worth, balances).
  void toggle() {
    state = !state;
  }
}
