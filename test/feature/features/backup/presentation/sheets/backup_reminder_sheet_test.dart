import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:poka_ce/features/backup/presentation/sheets/backup_reminder_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

Widget _wrapWithTheme(Widget child) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: child,
    ),
  );
}

class _TestHost extends StatelessWidget {
  const _TestHost({
    required this.initialInterval,
    this.onResult,
  });

  final BackupReminderInterval initialInterval;
  final void Function(BackupReminderInterval?)? onResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final res = await showBackupReminderSheet(
              context,
              currentInterval: initialInterval,
            );
            onResult?.call(res);
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

  group('BackupReminderSheet', () {
    testWidgets('displays all reminder interval options', (tester) async {
      await tester.pumpWidget(
        _wrapWithTheme(const _TestHost(initialInterval: BackupReminderInterval.weekly)),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Backup Reminder'), findsWidgets);
      expect(find.text('Off'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);
      expect(find.text('Monthly'), findsOneWidget);
    });

    testWidgets('selecting Monthly pops with BackupReminderInterval.monthly', (tester) async {
      BackupReminderInterval? selected;
      await tester.pumpWidget(
        _wrapWithTheme(
          _TestHost(
            initialInterval: BackupReminderInterval.weekly,
            onResult: (val) => selected = val,
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Monthly'));
      await tester.pumpAndSettle();

      expect(selected, BackupReminderInterval.monthly);
    });

    testWidgets('selecting Off pops with BackupReminderInterval.off', (tester) async {
      BackupReminderInterval? selected;
      await tester.pumpWidget(
        _wrapWithTheme(
          _TestHost(
            initialInterval: BackupReminderInterval.weekly,
            onResult: (val) => selected = val,
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Off'));
      await tester.pumpAndSettle();

      expect(selected, BackupReminderInterval.off);
    });
  });
}
