import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/features/settings/data/settings_repository.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSettingsRepository mockRepo;

  setUp(() {
    mockRepo = MockSettingsRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
    container.listen(settingsProvider, (_, __) {});
    addTearDown(container.dispose);
    return container;
  }

  group('SettingsNotifier', () {
    test('initial state is loading then loads settings', () async {
      when(() => mockRepo.getSettings()).thenAnswer(
        (_) async => const SettingsModel(themeMode: 'dark'),
      );
      final container = makeContainer();
      // initial build is loading
      expect(container.read(settingsProvider).isLoading, true);
      await Future.delayed(const Duration(milliseconds: 50));
      final state = container.read(settingsProvider);
      expect(state.isLoading, false);
      expect(state.settings!.themeMode, 'dark');
      expect(state.error, isNull);
    });

    test('handles error during _loadSettings', () async {
      when(() => mockRepo.getSettings()).thenAnswer((_) async => throw Exception('boom'));
      final container = makeContainer();
      // poll until loaded or timeout
      for (var i = 0; i < 20; i++) {
        await Future.delayed(const Duration(milliseconds: 20));
        if (!container.read(settingsProvider).isLoading) break;
      }
      final state = container.read(settingsProvider);
      expect(state.isLoading, false);
      expect(state.error, contains('boom'));
    });

    test('setThemeMode success reloads', () async {
      when(() => mockRepo.getSettings()).thenAnswer(
        (_) async => const SettingsModel(themeMode: 'system'),
      );
      when(() => mockRepo.setThemeMode(any())).thenAnswer((_) async {});
      final container = makeContainer();
      await Future.delayed(const Duration(milliseconds: 30));
      // second load after setThemeMode
      when(() => mockRepo.getSettings()).thenAnswer(
        (_) async => const SettingsModel(themeMode: 'dark'),
      );
      await container.read(settingsProvider.notifier).setThemeMode('dark');
      await Future.delayed(const Duration(milliseconds: 30));
      expect(container.read(settingsProvider).settings!.themeMode, 'dark');
      verify(() => mockRepo.setThemeMode('dark')).called(1);
    });

    test('setThemeMode handles error silently', () async {
      when(() => mockRepo.getSettings()).thenAnswer((_) async => const SettingsModel(themeMode: 'system'));
      when(() => mockRepo.setThemeMode(any())).thenThrow(Exception('fail'));
      final container = makeContainer();
      await Future.delayed(const Duration(milliseconds: 100));
      await container.read(settingsProvider.notifier).setThemeMode('dark');
      await Future.delayed(const Duration(milliseconds: 50));
      // should not throw, state remains not loading
      expect(container.read(settingsProvider).isLoading, false);
    });

    test('setBaseCurrency success reloads', () async {
      when(() => mockRepo.getSettings()).thenAnswer((_) async => const SettingsModel(themeMode: 'system'));
      when(() => mockRepo.setBaseCurrency(any())).thenAnswer((_) async {});
      final container = makeContainer();
      await Future.delayed(const Duration(milliseconds: 30));
      when(() => mockRepo.getSettings()).thenAnswer(
        (_) async => SettingsModel(
          themeMode: 'system',
          baseCurrency: const CurrencyModel(id: 'c1', name: 'Rupiah', code: 'IDR', symbol: 'Rp', precision: 2),
        ),
      );
      await container.read(settingsProvider.notifier).setBaseCurrency('c1');
      await Future.delayed(const Duration(milliseconds: 30));
      verify(() => mockRepo.setBaseCurrency('c1')).called(1);
    });

    test('setBaseCurrency handles error silently', () async {
      when(() => mockRepo.getSettings()).thenAnswer((_) async => const SettingsModel(themeMode: 'system'));
      when(() => mockRepo.setBaseCurrency(any())).thenThrow(Exception('fail'));
      final container = makeContainer();
      await Future.delayed(const Duration(milliseconds: 100));
      await container.read(settingsProvider.notifier).setBaseCurrency('c1');
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(settingsProvider).isLoading, false);
    });

    test('getAvailableCurrencies delegates to repo', () async {
      when(() => mockRepo.getSettings()).thenAnswer((_) async => const SettingsModel(themeMode: 'system'));
      when(() => mockRepo.getCurrencies()).thenAnswer(
        (_) async => [const CurrencyModel(id: 'c1', name: 'Rupiah', code: 'IDR', symbol: 'Rp', precision: 2)],
      );
      final container = makeContainer();
      await Future.delayed(const Duration(milliseconds: 20));
      final list = await container.read(settingsProvider.notifier).getAvailableCurrencies();
      expect(list.length, 1);
      expect(list.first.code, 'IDR');
    });

    test('copyWith preserves fields', () {
      const s = SettingsState(
        isLoading: false,
        error: 'e',
        settings: SettingsModel(themeMode: 'light'),
      );
      final c = s.copyWith(isLoading: true);
      expect(c.isLoading, true);
      expect(c.error, 'e');
      expect(c.settings!.themeMode, 'light');
    });
  });
}
