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

  group('SettingsNotifier coverage', () {
    test('setLanguage success reloads', () async {
      when(
        () => mockRepo.getSettings(),
      ).thenAnswer((_) async => const SettingsModel(themeMode: 'system', language: 'system'));
      when(() => mockRepo.setLanguage(any())).thenAnswer((_) async {});
      final container = makeContainer();
      await Future.delayed(const Duration(milliseconds: 30));
      when(
        () => mockRepo.getSettings(),
      ).thenAnswer((_) async => const SettingsModel(themeMode: 'system', language: 'en'));
      await container.read(settingsProvider.notifier).setLanguage('en');
      await Future.delayed(const Duration(milliseconds: 30));
      verify(() => mockRepo.setLanguage('en')).called(1);
      expect(container.read(settingsProvider).settings!.language, 'en');
    });

    test('setLanguage handles error silently', () async {
      when(() => mockRepo.getSettings()).thenAnswer((_) async => const SettingsModel(themeMode: 'system'));
      when(() => mockRepo.setLanguage(any())).thenThrow(Exception('fail'));
      final container = makeContainer();
      await Future.delayed(const Duration(milliseconds: 30));
      await container.read(settingsProvider.notifier).setLanguage('en');
      await Future.delayed(const Duration(milliseconds: 30));
      expect(container.read(settingsProvider).isLoading, false);
      verify(() => mockRepo.setLanguage('en')).called(1);
    });

    test('copyWith covers isLoading and error branches', () {
      const base = SettingsState(
        isLoading: false,
        error: 'old',
        settings: SettingsModel(themeMode: 'light', language: 'en'),
      );
      // cover isLoading line (DA:24) by toggling it
      final c1 = base.copyWith(isLoading: true);
      expect(c1.isLoading, true);
      expect(c1.error, 'old');
      expect(c1.settings!.themeMode, 'light');

      // cover error line by providing new error
      final c2 = base.copyWith(error: 'new');
      expect(c2.error, 'new');
      expect(c2.isLoading, false);

      // cover settings override
      final c3 = base.copyWith(settings: const SettingsModel(themeMode: 'dark'));
      expect(c3.settings!.themeMode, 'dark');

      // cover no-args preserves
      final c4 = base.copyWith();
      expect(c4.isLoading, false);
      expect(c4.error, 'old');
      expect(c4.settings!.themeMode, 'light');
    });

    test('getAvailableCurrencies delegates to repo when notifier already loaded', () async {
      when(() => mockRepo.getSettings()).thenAnswer((_) async => const SettingsModel(themeMode: 'system'));
      when(
        () => mockRepo.getCurrencies(),
      ).thenAnswer(
        (_) async => [const CurrencyModel(id: 'c1', name: 'Rupiah', code: 'IDR', symbol: 'Rp', precision: 2)],
      );
      final container = makeContainer();
      await Future.delayed(const Duration(milliseconds: 20));
      final list = await container.read(settingsProvider.notifier).getAvailableCurrencies();
      expect(list.first.symbol, 'Rp');
    });
  });
}
