import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/dialogs/poka_confirm_dialog.dart';
import 'package:poka_ce/theme/theme.dart';

Widget wrapHost({required void Function(bool?) onResult, String? confirmText}) {
  return TranslationProvider(
    child: MaterialApp(
      builder: (context, c) => FTheme(data: lightTheme, child: c!),
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                final r = await showPokaConfirmDialog(
                  context,
                  title: 'Delete Account?',
                  body: 'This will remove all data.',
                  confirmText: confirmText,
                );
                onResult(r);
              },
              child: const Text('Open Dialog'),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => LocaleSettings.setLocaleSync(AppLocale.en));

  group('showPokaConfirmDialog', () {
    testWidgets('shows title, body and warning text', (tester) async {
      await tester.pumpWidget(wrapHost(onResult: (_) {}));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Delete Account?'), findsOneWidget);
      expect(find.text('This will remove all data.'), findsOneWidget);
      expect(find.text('This action cannot be undone.'), findsOneWidget);
    });

    testWidgets('confirm pops with true', (tester) async {
      bool? result;
      await tester.pumpWidget(wrapHost(onResult: (v) => result = v));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      // Default confirm label is "Delete"
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    testWidgets('cancel pops with false', (tester) async {
      bool? result;
      await tester.pumpWidget(wrapHost(onResult: (v) => result = v));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });

    testWidgets('custom confirmText overrides delete label', (tester) async {
      bool? result;
      await tester.pumpWidget(wrapHost(onResult: (v) => result = v, confirmText: 'Remove'));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Remove'), findsOneWidget);
      expect(find.text('Delete'), findsNothing);

      await tester.tap(find.text('Remove'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });
  });
}
