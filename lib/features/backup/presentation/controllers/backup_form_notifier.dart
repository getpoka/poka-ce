import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_form_notifier.freezed.dart';
part 'backup_form_notifier.g.dart';

@freezed
abstract class BackupFormState with _$BackupFormState {
  const factory BackupFormState({
    String? passwordError,
    String? confirmError,
    @Default(false) bool isSubmitting,
  }) = _BackupFormState;
}

@riverpod
class BackupFormNotifier extends _$BackupFormNotifier {
  @override
  BackupFormState build() => const BackupFormState();

  void reset() {
    state = const BackupFormState();
  }

  Future<bool> submit({
    required String password,
    required String confirmPassword,
    required bool isBackup,
    required String passwordRequiredText,
    required String passwordsDoNotMatchText,
    required String incorrectPasswordText,
    Future<bool> Function(String)? onValidateRestore,
  }) async {
    state = state.copyWith(passwordError: null, confirmError: null);

    if (password.isEmpty) {
      state = state.copyWith(passwordError: passwordRequiredText);
      return false;
    }

    if (isBackup) {
      if (password != confirmPassword) {
        state = state.copyWith(confirmError: passwordsDoNotMatchText);
        return false;
      }
    }

    if (onValidateRestore != null) {
      state = state.copyWith(isSubmitting: true);
      try {
        final success = await onValidateRestore(password);
        if (!success && !isBackup) {
          state = state.copyWith(passwordError: incorrectPasswordText);
        }
        return success;
      } on Object catch (_) {
        if (!isBackup) {
          state = state.copyWith(passwordError: incorrectPasswordText);
        }
        return false;
      } finally {
        state = state.copyWith(isSubmitting: false);
      }
    }

    return true;
  }
}
