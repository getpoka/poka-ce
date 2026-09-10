import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/backup/presentation/sheets/notification_permission_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);

  Widget buildApp(Widget child) {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(
          data: lightTheme,
          child: child!,
        ),
        home: Scaffold(body: child),
      ),
    );
  }

  group('NotificationPermissionSheet', () {
    testWidgets('renders rationale sheet elements correctly', (tester) async {
      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showNotificationRationaleSheet(context),
              child: const Text('Open Sheet'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text(t.backup.permissionRationaleTitle), findsOneWidget);
      expect(find.text(t.backup.permissionRationaleDesc), findsOneWidget);
      expect(find.text(t.backup.allowNotifications), findsOneWidget);
      expect(find.text(t.common.cancel), findsOneWidget);
    });

    testWidgets('tapping cancel dismisses sheet with false', (tester) async {
      bool? result;

      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await showNotificationRationaleSheet(context);
              },
              child: const Text('Open Sheet'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.common.cancel));
      await tester.pumpAndSettle();

      expect(result, isFalse);
      expect(find.text(t.backup.permissionRationaleTitle), findsNothing);
    });

    testWidgets('tapping allow notifications dismisses sheet with true', (tester) async {
      bool? result;

      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await showNotificationRationaleSheet(context);
              },
              child: const Text('Open Sheet'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.backup.allowNotifications));
      await tester.pumpAndSettle();

      expect(result, isTrue);
      expect(find.text(t.backup.permissionRationaleTitle), findsNothing);
    });
  });
}
