import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/backup/presentation/sheets/backup_restore_action_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

Widget _wrapWithProviders(Widget child) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: child,
    ),
  );
}

class _Host extends StatelessWidget {
  final void Function(BackupAction?)? onResult;
  const _Host({this.onResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final r = await showBackupRestoreActionSheet(context);
            if (onResult != null) onResult!(r);
          },
          child: const Text('Open'),
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

  group('BackupRestoreActionSheet', () {
    testWidgets('Shows both Backup and Restore options', (tester) async {
      await tester.pumpWidget(_wrapWithProviders(const _Host()));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Backup & Restore'), findsWidgets); // header + maybe other
      expect(find.text('Backup'), findsOneWidget);
      expect(find.text('Restore'), findsOneWidget);
    });

    testWidgets('Tapping Backup pops with BackupAction.backup', (tester) async {
      BackupAction? popped;
      await tester.pumpWidget(_wrapWithProviders(_Host(onResult: (v) => popped = v)));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backup'));
      await tester.pumpAndSettle();

      expect(popped, equals(BackupAction.backup));
    });

    testWidgets('Tapping Restore pops with BackupAction.restore', (tester) async {
      BackupAction? popped;
      await tester.pumpWidget(_wrapWithProviders(_Host(onResult: (v) => popped = v)));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Restore'));
      await tester.pumpAndSettle();

      expect(popped, equals(BackupAction.restore));
    });
  });
}
