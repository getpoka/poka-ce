import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumpadNotifier extends Notifier<String> {
  @override
  String build() => '0';

  void handleNumber(int number) {
    if (state == '0') {
      state = number.toString();
    } else {
      if (state.length < 15) {
        state = state + number.toString();
      }
    }
  }

  void handleBackspace() {
    if (state.length > 1) {
      state = state.substring(0, state.length - 1);
    } else {
      state = '0';
    }
  }

  void reset() {
    state = '0';
  }
}

final NotifierProvider<NumpadNotifier, String> numpadNotifierProvider = NotifierProvider<NumpadNotifier, String>(() {
  return NumpadNotifier();
});
