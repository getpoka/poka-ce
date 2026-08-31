import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/app.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

Future<AppDatabase> pumpAppForTesting(WidgetTester tester) async {
  Animate.restartOnHotReload = false;

  // Ignore overflow errors in tests
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
      return;
    }
    originalOnError(details);
  };

  SharedPreferences.setMockInitialValues({});
  final sharedPrefs = await SharedPreferences.getInstance();

  final memoryDb = AppDatabase(connection: NativeDatabase.memory());

  // Wait for migration and seeder to complete
  await memoryDb.customSelect('SELECT 1').get();

  // Find the IDR currency from the seeder
  final idrCurrency = await (memoryDb.select(memoryDb.currencies)..where((t) => t.code.equals('IDR'))).getSingle();
  await memoryDb.settingsDao.setSetting('baseCurrencyId', idrCurrency.id);

  // Use a wide enough screen
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        databaseProvider.overrideWithValue(memoryDb),
      ],
      child: const PokaApp(),
    ),
  );

  await tester.pumpAndSettle();

  return memoryDb;
}

/// Safely tears down the application and database in a test environment.
/// This prevents hanging (deadlock) where Drift's `db.close()` waits for
/// active streams to close, which in turn require `FakeAsync` timers to run.
Future<void> tearDownAppForTesting(WidgetTester tester, AppDatabase db) async {
  // Unmount the application to cancel all Riverpod stream listeners
  await tester.pumpWidget(Container());
  // Process any pending FakeAsync timers (like Drift's stream debouncers)
  await tester.pumpAndSettle();
  // Now it's safe to close the database without hanging
  await db.close();
}
