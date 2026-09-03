import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/features/backup/presentation/controllers/backup_form_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ProviderContainer createContainer() {
    final c = ProviderContainer();
    c.listen(backupFormProvider, (_, __) {});
    addTearDown(c.dispose);
    return c;
  }

  group('BackupFormNotifier', () {
    test('initial state', () {
      final container = createContainer();
      final s = container.read(backupFormProvider);
      expect(s.passwordError, isNull);
      expect(s.confirmError, isNull);
      expect(s.isSubmitting, false);
    });

    test('reset clears errors', () {
      final container = createContainer();
      final notifier = container.read(backupFormProvider.notifier);
      notifier.submit(
        password: '',
        confirmPassword: '',
        isBackup: true,
        passwordRequiredText: 'required',
        passwordsDoNotMatchText: 'mismatch',
        incorrectPasswordText: 'incorrect',
      );
      expect(container.read(backupFormProvider).passwordError, 'required');
      notifier.reset();
      final s = container.read(backupFormProvider);
      expect(s.passwordError, isNull);
      expect(s.confirmError, isNull);
    });

    test('submit backup with empty password fails', () async {
      final container = createContainer();
      final notifier = container.read(backupFormProvider.notifier);
      final ok = await notifier.submit(
        password: '',
        confirmPassword: '',
        isBackup: true,
        passwordRequiredText: 'required',
        passwordsDoNotMatchText: 'mismatch',
        incorrectPasswordText: 'incorrect',
      );
      expect(ok, isFalse);
      expect(container.read(backupFormProvider).passwordError, 'required');
    });

    test('submit backup with mismatched confirm fails', () async {
      final container = createContainer();
      final notifier = container.read(backupFormProvider.notifier);
      final ok = await notifier.submit(
        password: 'secret',
        confirmPassword: 'other',
        isBackup: true,
        passwordRequiredText: 'required',
        passwordsDoNotMatchText: 'mismatch',
        incorrectPasswordText: 'incorrect',
      );
      expect(ok, isFalse);
      expect(container.read(backupFormProvider).confirmError, 'mismatch');
    });

    test('submit backup success returns true', () async {
      final container = createContainer();
      final notifier = container.read(backupFormProvider.notifier);
      final ok = await notifier.submit(
        password: 'secret',
        confirmPassword: 'secret',
        isBackup: true,
        passwordRequiredText: 'required',
        passwordsDoNotMatchText: 'mismatch',
        incorrectPasswordText: 'incorrect',
      );
      expect(ok, isTrue);
      expect(container.read(backupFormProvider).isSubmitting, false);
    });

    test('submit restore validates password via callback', () async {
      final container = createContainer();
      final notifier = container.read(backupFormProvider.notifier);

      final ok = await notifier.submit(
        password: 'secret',
        confirmPassword: '',
        isBackup: false,
        passwordRequiredText: 'required',
        passwordsDoNotMatchText: 'mismatch',
        incorrectPasswordText: 'incorrect',
        onValidateRestore: (pw) async => pw == 'secret',
      );
      expect(ok, isTrue);
      expect(container.read(backupFormProvider).passwordError, isNull);
    });

    test('submit restore with wrong password shows incorrect error', () async {
      final container = createContainer();
      final notifier = container.read(backupFormProvider.notifier);

      final ok = await notifier.submit(
        password: 'wrong',
        confirmPassword: '',
        isBackup: false,
        passwordRequiredText: 'required',
        passwordsDoNotMatchText: 'mismatch',
        incorrectPasswordText: 'incorrect',
        onValidateRestore: (pw) async => false,
      );
      expect(ok, isFalse);
      expect(container.read(backupFormProvider).passwordError, 'incorrect');
      expect(container.read(backupFormProvider).isSubmitting, false);
    });

    test('submit restore when callback throws shows incorrect error', () async {
      final container = createContainer();
      final notifier = container.read(backupFormProvider.notifier);

      final ok = await notifier.submit(
        password: 'wrong',
        confirmPassword: '',
        isBackup: false,
        passwordRequiredText: 'required',
        passwordsDoNotMatchText: 'mismatch',
        incorrectPasswordText: 'incorrect',
        onValidateRestore: (pw) async => throw Exception('decrypt failed'),
      );
      expect(ok, isFalse);
      expect(container.read(backupFormProvider).passwordError, 'incorrect');
      expect(container.read(backupFormProvider).isSubmitting, false);
    });
  });
}
