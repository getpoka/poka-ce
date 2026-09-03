import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late PreferencesService service;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    service = PreferencesService(mockPrefs);
  });

  group('PreferencesService', () {
    test('saveString calls prefs', () async {
      when(() => mockPrefs.setString('k', 'v')).thenAnswer((_) async => true);
      await service.saveString('k', 'v');
      verify(() => mockPrefs.setString('k', 'v')).called(1);
    });

    test('getString calls prefs', () {
      when(() => mockPrefs.getString('k')).thenReturn('v');
      final res = service.getString('k');
      expect(res, 'v');
      verify(() => mockPrefs.getString('k')).called(1);
    });

    test('saveBool calls prefs', () async {
      when(() => mockPrefs.setBool('k', true)).thenAnswer((_) async => true);
      await service.saveBool('k', true);
      verify(() => mockPrefs.setBool('k', true)).called(1);
    });

    test('getBool calls prefs', () {
      when(() => mockPrefs.getBool('k')).thenReturn(true);
      final res = service.getBool('k');
      expect(res, true);
      verify(() => mockPrefs.getBool('k')).called(1);
    });

    test('remove calls prefs', () async {
      when(() => mockPrefs.remove('k')).thenAnswer((_) async => true);
      await service.remove('k');
      verify(() => mockPrefs.remove('k')).called(1);
    });

    test('clear calls prefs', () async {
      when(() => mockPrefs.clear()).thenAnswer((_) async => true);
      await service.clear();
      verify(() => mockPrefs.clear()).called(1);
    });
  });

  group('Preferences providers', () {
    test('sharedPreferencesProvider throws when not overridden', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(
        () => container.read(sharedPreferencesProvider),
        throwsA(
          predicate((e) => e.toString().contains('UnimplementedError')),
        ),
      );
    });

    test('preferencesServiceProvider builds from overridden prefs', () {
      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(mockPrefs)],
      );
      addTearDown(container.dispose);
      final resolved = container.read(preferencesServiceProvider);
      expect(resolved, isA<PreferencesService>());
    });
  });
}
