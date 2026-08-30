import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/backup/presentation/sheets/backup_password_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

Widget _wrapWithProviders(Widget child) {
  return ProviderScope(
    child: TranslationProvider(
      child: MaterialApp(
        builder: (context, c) => FTheme(data: lightTheme, child: c!),
        home: child,
      ),
    ),
  );
}

class _Host extends StatelessWidget {
  final bool isBackup;
  final void Function(String?)? onResult;
  const _Host({required this.isBackup, this.onResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final r = await showBackupPasswordSheet(context, isBackup: isBackup);
            if (onResult != null) onResult!(r);
          },
          child: const Text('Open Sheet'),
        ),
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  group('BackupPasswordSheet', () {
    testWidgets('Shows title "Encrypt" label when isBackup: true', (tester) async {
      await tester.pumpWidget(_wrapWithProviders(const _Host(isBackup: true)));
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Enter password to encrypt backup'), findsOneWidget);
    });

    testWidgets('Shows title "Decrypt" label when isBackup: false', (tester) async {
      await tester.pumpWidget(_wrapWithProviders(const _Host(isBackup: false)));
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Enter password to decrypt backup'), findsOneWidget);
    });

    testWidgets('Shows confirm password field only when isBackup: true', (tester) async {
      await tester.pumpWidget(_wrapWithProviders(const _Host(isBackup: true)));
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();
      // Two password fields when backup
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
    });

    testWidgets('Shows only one password field when isBackup: false', (tester) async {
      await tester.pumpWidget(_wrapWithProviders(const _Host(isBackup: false)));
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsNothing);
    });

    testWidgets('Submit with empty password — does NOT pop', (tester) async {
      String? popped;
      await tester.pumpWidget(_wrapWithProviders(_Host(isBackup: false, onResult: (v) => popped = v)));
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      // Tap Confirm without entering text
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      // Sheet should still be visible, error shown, not popped
      expect(find.text('Password is required'), findsOneWidget);
      expect(find.text('Enter password to decrypt backup'), findsOneWidget);
      expect(popped, isNull);
    });

    testWidgets('Submit backup with mismatched passwords — shows "passwords do not match" error', (tester) async {
      await tester.pumpWidget(_wrapWithProviders(const _Host(isBackup: true)));
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      final editables = find.byType(EditableText);
      expect(editables, findsNWidgets(2));
      await tester.enterText(editables.at(0), 'password123');
      await tester.enterText(editables.at(1), 'different');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('Submit valid password (backup, matching confirm) — pops with the password value', (tester) async {
      String? popped;
      await tester.pumpWidget(_wrapWithProviders(_Host(isBackup: true, onResult: (v) => popped = v)));
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      final editables = find.byType(EditableText);
      expect(editables, findsNWidgets(2));
      await tester.enterText(editables.at(0), 'validPass');
      await tester.enterText(editables.at(1), 'validPass');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(popped, equals('validPass'));
      // Sheet should be dismissed
      expect(find.text('Enter password to encrypt backup'), findsNothing);
    });

    testWidgets('Submit valid password (restore, no confirm) — pops with the password value', (tester) async {
      String? popped;
      await tester.pumpWidget(_wrapWithProviders(_Host(isBackup: false, onResult: (v) => popped = v)));
      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      final editable = find.byType(EditableText);
      expect(editable, findsWidgets);
      await tester.enterText(editable.first, 'restorePass');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(popped, equals('restorePass'));
      expect(find.text('Enter password to decrypt backup'), findsNothing);
    });
  });
}
