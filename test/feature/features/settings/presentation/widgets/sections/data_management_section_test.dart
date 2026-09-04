import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/database/daos/transactions_dao.dart';
import 'package:poka_ce/features/backup/presentation/controllers/backup_controller.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/data_management_section.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker_platform_interface/file_picker_platform_interface.dart';
import 'package:go_router/go_router.dart';

class MockDatabase extends Mock implements AppDatabase {}

class MockTransactionsDao extends Mock implements TransactionsDao {}

class _AppLockKeepAlive extends ConsumerWidget {
  const _AppLockKeepAlive({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appLockControllerProvider);
    ref.watch(backupControllerProvider);
    return child;
  }
}

class MockPreferencesService extends Mock implements PreferencesService {}

class MockAppLockController extends Notifier<AppLockState> with Mock implements AppLockController {
  @override
  AppLockState build() => const AppLockState(isEnabled: true, isAuthenticated: true);
}

class MockAppLockControllerDisabled extends Notifier<AppLockState> with Mock implements AppLockController {
  @override
  AppLockState build() => const AppLockState(isEnabled: false, isAuthenticated: false);
}

class MockBackupController extends AsyncNotifier<void> with Mock implements BackupController {
  @override
  Future<void> build() async {}
}

base class MyPlatformFile extends PlatformFile {
  @override
  String get name => 'file.json';

  @override
  Uri get uri => Uri.file('/mock/path/file.json');

  @override
  String? get path => '/mock/path/file.json';

  @override
  Future<int> length() async => 1024;

  @override
  int? lengthSync() => 1024;

  @override
  XFile get xFile => XFile('/mock/path/file.json');

  @override
  Future<Uint8List> readAsBytes() async => Uint8List(0);

  @override
  Stream<Uint8List> readAsByteStream() => const Stream.empty();
}

class ManualMockFilePickerPlatform extends FilePickerPlatform {
  @override
  Future<List<PlatformFile>> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    AndroidOptions androidOptions = const AndroidOptions(),
    WindowsOptions windowsOptions = const WindowsOptions(),
    LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions(),
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
    bool readSequential = false,
    String? initialFileName,
    Object? darwinOptions,
  }) async {
    return [MyPlatformFile()];
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocaleRaw('en');

  late MockDatabase mockDb;
  late MockTransactionsDao mockDao;
  late MockPreferencesService mockPrefs;
  late MockAppLockController mockAppLock;
  late MockBackupController mockBackup;

  setUpAll(() {
    registerFallbackValue(DateTime.now());
    registerFallbackValue(FileType.any);
    registerFallbackValue(FilePickerStatus.picking);
  });

  setUp(() {
    mockDb = MockDatabase();
    mockDao = MockTransactionsDao();
    mockPrefs = MockPreferencesService();
    mockAppLock = MockAppLockController();
    mockBackup = MockBackupController();

    when(() => mockDb.transactionsDao).thenReturn(mockDao);
    when(() => mockDb.resetAllData()).thenAnswer((_) async {});
    when(() => mockDb.close()).thenAnswer((_) async {});
    when(() => mockDao.clearOldTransactions(any())).thenAnswer((_) async => 0);
    when(() => mockPrefs.clear()).thenAnswer((_) async => true);

    when(() => mockAppLock.enableAppLock(any())).thenAnswer((_) async {});
    when(() => mockAppLock.disableAppLock()).thenAnswer((_) async {});
    when(() => mockAppLock.verifyPin('123456')).thenAnswer((_) async => PinVerificationResult.success);

    when(() => mockBackup.backup(any(), sharePositionOrigin: any(named: 'sharePositionOrigin')))
        .thenAnswer((_) async => true);
    when(() => mockBackup.restore(any(), any())).thenAnswer((_) async => true);

    FilePickerPlatform.instance = ManualMockFilePickerPlatform();
  });

  Widget wrap(Widget child) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => Scaffold(body: SingleChildScrollView(child: child)),
        ),
      ],
      errorBuilder: (context, state) => const Scaffold(body: Text('Route not found')),
    );

    return ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(mockDb),
        preferencesServiceProvider.overrideWithValue(mockPrefs),
        appLockControllerProvider.overrideWith(() => mockAppLock),
        backupControllerProvider.overrideWith(() => mockBackup),
      ],
      child: TranslationProvider(
        child: _AppLockKeepAlive(
          child: MaterialApp.router(
            routerConfig: router,
            builder: (context, c) => FTheme(
              data: lightTheme,
              child: FToaster(child: c!),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> enterPin(WidgetTester tester) async {
    for (var i = 1; i <= 6; i++) {
      await tester.tap(find.text(i.toString()));
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();
  }

  group('DataManagementSection Tests', () {
    testWidgets('Backup Data flow', (tester) async {
      await tester.pumpWidget(wrap(const DataManagementSection()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backup & Restore'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backup').last);
      await tester.pumpAndSettle();

      await enterPin(tester);

      final fields = find.byType(EditableText);
      await tester.enterText(fields.first, 'password123');
      await tester.enterText(fields.last, 'password123');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      verify(() => mockBackup.backup('password123', sharePositionOrigin: any(named: 'sharePositionOrigin'))).called(1);
    });

    testWidgets('Restore Data flow', (tester) async {
      await tester.pumpWidget(wrap(const DataManagementSection()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backup & Restore'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Restore').last); // Taps action sheet item
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FButton, 'Delete').last); // Taps confirm button
      await tester.pumpAndSettle();

      await enterPin(tester);

      final fields = find.byType(EditableText);
      await tester.enterText(fields.first, 'password123');
      await tester.enterText(fields.last, 'password123');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      verify(() => mockBackup.restore('password123', '/mock/path/file.json')).called(1);
    });

    testWidgets('Backup Data flow - PIN cancelled', (tester) async {
      when(() => mockAppLock.verifyPin(any())).thenAnswer((_) async => PinVerificationResult.lockedOut);

      await tester.pumpWidget(wrap(const DataManagementSection()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backup & Restore'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backup').last);
      await tester.pumpAndSettle();

      // Tap backspace or something to cancel, or just close the sheet
      // Actually we can just simulate pressing back button or tapping outside
      await tester.tapAt(const Offset(10, 10)); // Tap outside
      await tester.pumpAndSettle();
    });

    testWidgets('Backup Data flow - Backup Failed', (tester) async {
      when(() => mockBackup.backup(any(), sharePositionOrigin: any(named: 'sharePositionOrigin')))
          .thenAnswer((_) async => false);

      await tester.pumpWidget(wrap(const DataManagementSection()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backup & Restore'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Backup').last);
      await tester.pumpAndSettle();

      await enterPin(tester);

      final fields = find.byType(EditableText);
      await tester.enterText(fields.first, 'password123');
      await tester.enterText(fields.last, 'password123');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      // We just verify it completed without crashing.
    });

    testWidgets('Reset Data flow - App Lock disabled triggers setup', (tester) async {
      final mockAppLockDisabled = MockAppLockControllerDisabled();
      when(() => mockAppLockDisabled.enableAppLock(any())).thenAnswer((_) async {});
      when(() => mockAppLockDisabled.disableAppLock()).thenAnswer((_) async {});

      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const Scaffold(body: SingleChildScrollView(child: DataManagementSection())),
          ),
        ],
        errorBuilder: (context, state) => const Scaffold(body: Text('Route not found')),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(mockDb),
            preferencesServiceProvider.overrideWithValue(mockPrefs),
            appLockControllerProvider.overrideWith(() => mockAppLockDisabled),
            backupControllerProvider.overrideWith(() => mockBackup),
          ],
          child: TranslationProvider(
            child: _AppLockKeepAlive(
              child: MaterialApp.router(
                routerConfig: router,
                builder: (context, c) => FTheme(
                  data: lightTheme,
                  child: FToaster(child: c!),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Reset Data'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FButton, 'Reset Data').last);
      await tester.pumpAndSettle();

      await enterPin(tester);
      await enterPin(tester);

      verify(() => mockAppLockDisabled.enableAppLock('123456')).called(1);
    });

    testWidgets('Clear Old Transactions flow', (tester) async {
      await tester.pumpWidget(wrap(const DataManagementSection()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Clear Old Transactions'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FButton, 'Delete').last);
      await tester.pumpAndSettle();

      await enterPin(tester);

      verify(() => mockDao.clearOldTransactions(any())).called(1);
    });

    testWidgets('Reset Data flow', (tester) async {
      await tester.pumpWidget(wrap(const DataManagementSection()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Reset Data'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FButton, 'Reset Data').last);
      await tester.pumpAndSettle();

      await enterPin(tester);

      verify(() => mockDb.resetAllData()).called(1);
      verify(() => mockPrefs.clear()).called(1);
      verify(() => mockAppLock.disableAppLock()).called(1);
    });
  });
}
