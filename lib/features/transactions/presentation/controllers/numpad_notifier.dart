import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple string accumulator for calculator numpad inputs.
class NumpadNotifier extends Notifier<String> {
  @override
  String build() => '0';

  /// Appends a digit to the current numpad buffer, respecting max character limit.
  void handleNumber(int number) {
    if (state == '0') {
      state = number.toString();
    } else {
      if (state.length < 15) {
        state = state + number.toString();
      }
    }
  }

  /// Removes the trailing character from the buffer or reverts to '0'.
  void handleBackspace() {
    if (state.length > 1) {
      state = state.substring(0, state.length - 1);
    } else {
      state = '0';
    }
  }

  /// Resets the numpad buffer back to '0'.
  void reset() {
    state = '0';
  }
}

/// Provider exposing the active [NumpadNotifier] text input buffer.
final NotifierProvider<NumpadNotifier, String> numpadNotifierProvider = NotifierProvider<NumpadNotifier, String>(() {
  return NumpadNotifier();
});
