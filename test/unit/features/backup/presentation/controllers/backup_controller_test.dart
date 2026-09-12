import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/backup/data/backup_service.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:drift/drift.dart';
import 'package:poka_ce/features/backup/presentation/controllers/backup_controller.dart';
import 'package:result_dart/result_dart.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBackupService extends Mock implements BackupService {}

class MockBackupReminderService extends Mock implements BackupReminderService {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockSelectable extends Mock implements Selectable<QueryRow> {}

class MockQueryRow extends Mock implements QueryRow {}

class FakeSharePlatform extends SharePlatform with MockPlatformInterfaceMixin {
  @override
  Future<ShareResult> share(ShareParams params) async {
    return const ShareResult('fake', ShareResultStatus.success);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBackupService mockService;
  late MockBackupReminderService mockReminderService;
  late MockAppDatabase mockDb;
  late MockSelectable mockSelectable;
  late SharePlatform originalSharePlatform;

  setUp(() {
    mockService = MockBackupService();
    mockReminderService = MockBackupReminderService();
    mockDb = MockAppDatabase();
    mockSelectable = MockSelectable();
    when(() => mockDb.close()).thenAnswer((_) async {});
    when(() => mockDb.customStatement(any())).thenAnswer((_) async {});
    when(() => mockDb.customSelect(any())).thenReturn(mockSelectable);
    when(() => mockSelectable.get()).thenAnswer((_) async => <QueryRow>[]);
    when(() => mockReminderService.recordBackupCompleted(any())).thenAnswer((_) async {});
    when(() => mockReminderService.recordBackupCompleted()).thenAnswer((_) async {});
    originalSharePlatform = SharePlatform.instance;
    // Default: fake that succeeds
    SharePlatform.instance = FakeSharePlatform();
  });

  tearDown(() {
    SharePlatform.instance = originalSharePlatform;
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(mockDb),
        backupServiceProvider.overrideWithValue(mockService),
        backupReminderServiceProvider.overrideWithValue(mockReminderService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('BackupController', () {
    test('initial state is AsyncValue.data(null)', () {
      final container = createContainer();
      final state = container.read(backupControllerProvider);
      expect(state, const AsyncValue<void>.data(null));
      expect(state.hasValue, isTrue);
      expect(state.isLoading, isFalse);
      expect(state.hasError, isFalse);
    });

    test('backup() — on BackupService success: state transitions loading -> data, returns true', () async {
      final tempFile = File(
        '${Directory.systemTemp.path}/backup_success_${DateTime.now().microsecondsSinceEpoch}.enc.db',
      );
      await tempFile.writeAsString('fake');
      addTearDown(() async {
        if (await tempFile.exists()) await tempFile.delete();
      });

      when(
        () => mockService.createEncryptedBackup(any(), onBeforeRead: any(named: 'onBeforeRead')),
      ).thenAnswer((invocation) async {
        final onBefore = invocation.namedArguments[#onBeforeRead] as Future<void> Function()?;
        await onBefore?.call();
        return Success(tempFile);
      });

      final container = createContainer();
      final notifier = container.read(backupControllerProvider.notifier);

      final future = notifier.backup('password123');
      // Immediately after call, state should be loading
      expect(container.read(backupControllerProvider).isLoading, isTrue);

      final result = await future;
      expect(result, isTrue);
      expect(container.read(backupControllerProvider).hasValue, isTrue);
      expect(container.read(backupControllerProvider).isLoading, isFalse);
      expect(container.read(backupControllerProvider).hasError, isFalse);
      verify(
        () => mockService.createEncryptedBackup('password123', onBeforeRead: any(named: 'onBeforeRead')),
      ).called(1);
      verify(() => mockDb.customSelect('PRAGMA wal_checkpoint(TRUNCATE);')).called(1);
      verify(() => mockReminderService.recordBackupCompleted()).called(1);
    });

    test('backup() — executes PRAGMA wal_checkpoint(TRUNCATE) and handles busy status gracefully', () async {
      final tempFile = File(
        '${Directory.systemTemp.path}/backup_busy_${DateTime.now().microsecondsSinceEpoch}.enc.db',
      );
      await tempFile.writeAsString('fake');
      addTearDown(() async {
        if (await tempFile.exists()) await tempFile.delete();
      });

      final mockRow = MockQueryRow();
      when(() => mockRow.data).thenReturn(<String, Object?>{'busy': 1, 'log': 10, 'checkpointed': 5});
      when(() => mockSelectable.get()).thenAnswer((_) async => <QueryRow>[mockRow]);

      when(
        () => mockService.createEncryptedBackup(any(), onBeforeRead: any(named: 'onBeforeRead')),
      ).thenAnswer((invocation) async {
        final onBefore = invocation.namedArguments[#onBeforeRead] as Future<void> Function()?;
        await onBefore?.call();
        return Success(tempFile);
      });

      final container = createContainer();
      final notifier = container.read(backupControllerProvider.notifier);

      final result = await notifier.backup('password123');
      expect(result, isTrue);
      verify(() => mockDb.customSelect('PRAGMA wal_checkpoint(TRUNCATE);')).called(1);
    });

    test('backup() — handles WAL checkpoint error gracefully without failing the entire backup', () async {
      final tempFile = File(
        '${Directory.systemTemp.path}/backup_err_${DateTime.now().microsecondsSinceEpoch}.enc.db',
      );
      await tempFile.writeAsString('fake');
      addTearDown(() async {
        if (await tempFile.exists()) await tempFile.delete();
      });

      when(() => mockSelectable.get()).thenThrow(Exception('database locked'));

      when(
        () => mockService.createEncryptedBackup(any(), onBeforeRead: any(named: 'onBeforeRead')),
      ).thenAnswer((invocation) async {
        final onBefore = invocation.namedArguments[#onBeforeRead] as Future<void> Function()?;
        await onBefore?.call();
        return Success(tempFile);
      });

      final container = createContainer();
      final notifier = container.read(backupControllerProvider.notifier);

      final result = await notifier.backup('password123');
      expect(result, isTrue);
      verify(() => mockDb.customSelect('PRAGMA wal_checkpoint(TRUNCATE);')).called(1);
    });

    test('backup() — on BackupService failure: state transitions loading -> error, returns false', () async {
      when(
        () => mockService.createEncryptedBackup(any(), onBeforeRead: any(named: 'onBeforeRead')),
      ).thenAnswer((_) async => Failure(Exception('disk full')));

      final container = createContainer();
      final notifier = container.read(backupControllerProvider.notifier);

      final future = notifier.backup('pass');
      expect(container.read(backupControllerProvider).isLoading, isTrue);

      final result = await future;
      expect(result, isFalse);
      final state = container.read(backupControllerProvider);
      expect(state.hasError, isTrue);
      expect(state.isLoading, isFalse);
      expect(state.error.toString(), contains('disk full'));
    });

    test('backup() — on Exception thrown: state = error, returns false', () async {
      when(
        () => mockService.createEncryptedBackup(any(), onBeforeRead: any(named: 'onBeforeRead')),
      ).thenThrow(Exception('unexpected throw'));

      final container = createContainer();
      final notifier = container.read(backupControllerProvider.notifier);

      final result = await notifier.backup('pass');
      expect(result, isFalse);
      expect(container.read(backupControllerProvider).hasError, isTrue);
      expect(container.read(backupControllerProvider).error.toString(), contains('unexpected throw'));
    });

    test('restore() — on success: state = data, returns true', () async {
      when(() => mockService.restoreEncryptedBackup(any(), any(), onBeforeWrite: any(named: 'onBeforeWrite')))
          .thenAnswer((invocation) async {
            final onBefore = invocation.namedArguments[#onBeforeWrite] as Future<void> Function()?;
            await onBefore?.call();
            return const Success(unit);
          });

      final container = createContainer();
      final notifier = container.read(backupControllerProvider.notifier);

      final future = notifier.restore('pass', '/tmp/file.enc.db');
      expect(container.read(backupControllerProvider).isLoading, isTrue);

      final result = await future;
      expect(result, isTrue);
      expect(container.read(backupControllerProvider).hasValue, isTrue);
      expect(container.read(backupControllerProvider).hasError, isFalse);
      verify(
        () =>
            mockService.restoreEncryptedBackup('/tmp/file.enc.db', 'pass', onBeforeWrite: any(named: 'onBeforeWrite')),
      ).called(1);
      verify(() => mockDb.close()).called(1);
    });

    test('restore() — on failure: state = error, returns false', () async {
      when(
        () => mockService.restoreEncryptedBackup(any(), any(), onBeforeWrite: any(named: 'onBeforeWrite')),
      ).thenAnswer((_) async => Failure(Exception('wrong password')));

      final container = createContainer();
      final notifier = container.read(backupControllerProvider.notifier);

      final future = notifier.restore('bad', '/tmp/file.enc.db');
      expect(container.read(backupControllerProvider).isLoading, isTrue);

      final result = await future;
      expect(result, isFalse);
      expect(container.read(backupControllerProvider).hasError, isTrue);
      expect(container.read(backupControllerProvider).error.toString(), contains('wrong password'));
    });

    test('restore() — on Exception thrown: state = error, returns false', () async {
      when(() => mockService.restoreEncryptedBackup(any(), any(), onBeforeWrite: any(named: 'onBeforeWrite')))
          .thenThrow(Exception('io error'));

      final container = createContainer();
      final result = await container.read(backupControllerProvider.notifier).restore('pass', '/tmp/x');
      expect(result, isFalse);
      expect(container.read(backupControllerProvider).hasError, isTrue);
      expect(container.read(backupControllerProvider).error.toString(), contains('io error'));
    });
  });
}
