import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/services/app_lock_service.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/core/services/secure_storage_service.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';

// ── Fakes ───────────────────────────────────────────────────────────────────

class FakePreferencesService implements PreferencesService {
  FakePreferencesService(this._bools, this._strings);
  final Map<String, bool> _bools;
  final Map<String, String> _strings;
  // ignore: unused_field
  final Map<String, String> _unused = {};
  // We keep the same field name as real service expects
  // but we implement interface manually.

  @override
  bool? getBool(String key) => _bools[key];

  @override
  String? getString(String key) => _strings[key];

  @override
  Future<void> saveBool(String key, bool value) async {
    _bools[key] = value;
  }

  @override
  Future<void> saveString(String key, String value) async {
    _strings[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _bools.remove(key);
    _strings.remove(key);
  }

  @override
  Future<void> clear() async {
    _bools.clear();
    _strings.clear();
  }
}

// Minimal fake secure storage that satisfies SecureStorageService interface.
class FakeSecureStorageService implements SecureStorageService {
  FakeSecureStorageService(this.store);
  final Map<String, String> store;

  @override
  Future<void> write(String key, String value) async {
    store[key] = value;
  }

  @override
  Future<String?> read(String key) async => store[key];

  @override
  Future<void> delete(String key) async {
    store.remove(key);
  }
}

class MockAppLockService extends Mock implements AppLockService {}

// ── Helpers ─────────────────────────────────────────────────────────────────

ProviderContainer makeContainer({
  Map<String, bool>? bools,
  Map<String, String>? strings,
  Map<String, String>? secure,
  AppLockService? appLockService,
}) {
  final b = bools ?? <String, bool>{};
  final s = strings ?? <String, String>{};
  final sec = secure ?? <String, String>{};
  final fakePrefs = FakePreferencesService(b, s);
  final fakeSecure = FakeSecureStorageService(sec);
  final mockLock = appLockService ?? MockAppLockService();

  final container = ProviderContainer(
    overrides: [
      preferencesServiceProvider.overrideWithValue(fakePrefs),
      secureStorageProvider.overrideWithValue(fakeSecure),
      appLockServiceProvider.overrideWithValue(mockLock),
    ],
  );
  container.listen(appLockControllerProvider, (_, __) {});
  addTearDown(container.dispose);
  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppLockController', () {
    group('build', () {
      test('disabled by default isAuthenticated true', () {
        final c = makeContainer();
        final state = c.read(appLockControllerProvider);
        expect(state.isEnabled, false);
        expect(state.isAuthenticated, true);
        expect(state.isBiometricEnabled, false);
        expect(state.lockoutUntil, isNull);
      });

      test('enabled but unauthenticated', () {
        final c = makeContainer(bools: {'app_lock_enabled': true});
        final state = c.read(appLockControllerProvider);
        expect(state.isEnabled, true);
        expect(state.isAuthenticated, false);
      });

      test('biometric flag read', () {
        final c = makeContainer(bools: {'app_lock_enabled': true, 'app_lock_biometric': true});
        expect(c.read(appLockControllerProvider).isBiometricEnabled, true);
      });

      test('lockoutUntil future is parsed', () {
        final future = DateTime.now().add(const Duration(minutes: 5)).toIso8601String();
        final c = makeContainer(strings: {'app_lock_locked_until': future});
        expect(c.read(appLockControllerProvider).lockoutUntil, isNotNull);
      });

      test('lockoutUntil past is ignored', () {
        final past = DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String();
        final c = makeContainer(strings: {'app_lock_locked_until': past});
        expect(c.read(appLockControllerProvider).lockoutUntil, isNull);
      });

      test('lockoutUntil invalid ignored', () {
        final c = makeContainer(strings: {'app_lock_locked_until': 'not-a-date'});
        expect(c.read(appLockControllerProvider).lockoutUntil, isNull);
      });

      test('lockoutUntil null yields null', () {
        final c = makeContainer();
        expect(c.read(appLockControllerProvider).lockoutUntil, isNull);
      });
    });

    group('enableAppLock', () {
      test('writes hash+salt and enables', () async {
        final sec = <String, String>{};
        final bools = <String, bool>{};
        final strings = <String, String>{};
        final c = makeContainer(bools: bools, strings: strings, secure: sec);
        await c.read(appLockControllerProvider.notifier).enableAppLock('1234');
        final s = c.read(appLockControllerProvider);
        expect(s.isEnabled, true);
        expect(s.isAuthenticated, true);
        expect(s.lockoutUntil, isNull);
        expect(bools['app_lock_enabled'], true);
        expect(sec.containsKey('app_lock_pin_hash'), true);
        expect(sec.containsKey('app_lock_pin_salt'), true);
        expect(sec.containsKey('app_lock_pin'), false);
        // lockout keys cleared
        expect(strings.containsKey('app_lock_failed_attempts'), false);
      });

      test('removes legacy plaintext pin', () async {
        final sec = <String, String>{'app_lock_pin': 'old'};
        final c = makeContainer(secure: sec);
        await c.read(appLockControllerProvider.notifier).enableAppLock('9999');
        expect(sec.containsKey('app_lock_pin'), false);
      });
    });

    group('disableAppLock', () {
      test('clears all and disables', () async {
        final sec = <String, String>{
          'app_lock_pin_hash': 'abc',
          'app_lock_pin_salt': 'def',
          'app_lock_pin': 'legacy',
        };
        final bools = <String, bool>{'app_lock_enabled': true, 'app_lock_biometric': true};
        final strings = <String, String>{'app_lock_failed_attempts': '3'};
        final c = makeContainer(bools: bools, strings: strings, secure: sec);
        // need to read provider once so state is enabled
        expect(c.read(appLockControllerProvider).isEnabled, true);
        await c.read(appLockControllerProvider.notifier).disableAppLock();
        final s = c.read(appLockControllerProvider);
        expect(s.isEnabled, false);
        expect(s.isBiometricEnabled, false);
        expect(s.isAuthenticated, true);
        expect(bools['app_lock_enabled'], false);
        expect(bools['app_lock_biometric'], false);
        expect(sec.isEmpty, true);
      });
    });

    group('toggleBiometric', () {
      test('returns false when app lock disabled', () async {
        final c = makeContainer();
        final res = await c.read(appLockControllerProvider.notifier).toggleBiometric(enable: true);
        expect(res, false);
      });

      test('returns false when isBiometricActive concurrent', () async {
        final mock = MockAppLockService();
        final c = makeContainer(
          bools: {'app_lock_enabled': true},
          appLockService: mock,
        );
        // force active
        c.read(appLockControllerProvider.notifier).state = c
            .read(appLockControllerProvider)
            .copyWith(isBiometricActive: true);
        final res = await c.read(appLockControllerProvider.notifier).toggleBiometric(enable: true);
        expect(res, false);
      });

      test('enable with canAuth true and authenticate success', () async {
        final mock = MockAppLockService();
        when(() => mock.canAuthenticate()).thenAnswer((_) async => true);
        when(() => mock.authenticate()).thenAnswer((_) async => true);
        final bools = <String, bool>{'app_lock_enabled': true};
        final c = makeContainer(bools: bools, appLockService: mock);
        final res = await c.read(appLockControllerProvider.notifier).toggleBiometric(enable: true);
        expect(res, true);
        expect(c.read(appLockControllerProvider).isBiometricEnabled, true);
        expect(c.read(appLockControllerProvider).isBiometricActive, false);
        expect(bools['app_lock_biometric'], true);
      });

      test('enable with canAuth true but user cancels returns false', () async {
        final mock = MockAppLockService();
        when(() => mock.canAuthenticate()).thenAnswer((_) async => true);
        when(() => mock.authenticate()).thenAnswer((_) async => false);
        final c = makeContainer(bools: {'app_lock_enabled': true}, appLockService: mock);
        final res = await c.read(appLockControllerProvider.notifier).toggleBiometric(enable: true);
        expect(res, false);
        expect(c.read(appLockControllerProvider).isBiometricEnabled, false);
        expect(c.read(appLockControllerProvider).isBiometricActive, false);
      });

      test('enable canAuth true throws Exception returns false', () async {
        final mock = MockAppLockService();
        when(() => mock.canAuthenticate()).thenAnswer((_) async => true);
        when(() => mock.authenticate()).thenThrow(Exception('fail'));
        final c = makeContainer(bools: {'app_lock_enabled': true}, appLockService: mock);
        final res = await c.read(appLockControllerProvider.notifier).toggleBiometric(enable: true);
        expect(res, false);
        expect(c.read(appLockControllerProvider).isBiometricEnabled, false);
        expect(c.read(appLockControllerProvider).isBiometricActive, false);
      });

      test('enable with canAuth false saves directly without prompt', () async {
        final mock = MockAppLockService();
        when(() => mock.canAuthenticate()).thenAnswer((_) async => false);
        final bools = <String, bool>{'app_lock_enabled': true};
        final c = makeContainer(bools: bools, appLockService: mock);
        final res = await c.read(appLockControllerProvider.notifier).toggleBiometric(enable: true);
        expect(res, true);
        expect(bools['app_lock_biometric'], true);
        verifyNever(() => mock.authenticate());
      });

      test('disable biometric always succeeds', () async {
        final mock = MockAppLockService();
        final bools = <String, bool>{'app_lock_enabled': true, 'app_lock_biometric': true};
        final c = makeContainer(bools: bools, appLockService: mock);
        expect(c.read(appLockControllerProvider).isBiometricEnabled, true);
        final res = await c.read(appLockControllerProvider.notifier).toggleBiometric(enable: false);
        expect(res, true);
        expect(c.read(appLockControllerProvider).isBiometricEnabled, false);
        expect(bools['app_lock_biometric'], false);
      });
    });

    group('verifyPin', () {
      test('blocked when lockout active returns lockedOut', () async {
        final future = DateTime.now().add(const Duration(seconds: 30)).toIso8601String();
        final c = makeContainer(
          bools: {'app_lock_enabled': true},
          strings: {'app_lock_locked_until': future},
        );
        // container build will have lockoutUntil
        expect(c.read(appLockControllerProvider).lockoutUntil, isNotNull);
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('1234');
        expect(res, PinVerificationResult.lockedOut);
      });

      test('success with hash', () async {
        final sec = <String, String>{};
        final c = makeContainer(secure: sec);
        await c.read(appLockControllerProvider.notifier).enableAppLock('4321');
        // lock then verify
        c.read(appLockControllerProvider.notifier).lock();
        // enable sets authenticated true, then lock makes false
        expect(c.read(appLockControllerProvider).isAuthenticated, false);
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('4321');
        expect(res, PinVerificationResult.success);
        expect(c.read(appLockControllerProvider).isAuthenticated, true);
      });

      test('wrong pin increments attempts -> wrongPin', () async {
        final sec = <String, String>{};
        final strings = <String, String>{};
        final c = makeContainer(secure: sec, strings: strings);
        await c.read(appLockControllerProvider.notifier).enableAppLock('1111');
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('9999');
        expect(res, PinVerificationResult.wrongPin);
        expect(strings['app_lock_failed_attempts'], '1');
      });

      test('5th wrong attempt triggers lockout', () async {
        final sec = <String, String>{};
        final strings = <String, String>{'app_lock_failed_attempts': '4'};
        final bools = <String, bool>{};
        final c = makeContainer(secure: sec, strings: strings, bools: bools);
        await c.read(appLockControllerProvider.notifier).enableAppLock('2222');
        // override attempts to 4 after enable cleared it – set again
        strings['app_lock_failed_attempts'] = '4';
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('0000');
        expect(res, PinVerificationResult.lockedOut);
        expect(c.read(appLockControllerProvider).lockoutUntil, isNotNull);
        expect(strings.containsKey('app_lock_locked_until'), true);
        expect(strings.containsKey('app_lock_failed_attempts'), false);
      });

      test('legacy pin upgrade path success', () async {
        final sec = <String, String>{'app_lock_pin': 'legacy123'};
        final c = makeContainer(secure: sec);
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('legacy123');
        expect(res, PinVerificationResult.success);
        expect(sec.containsKey('app_lock_pin_hash'), true);
        expect(sec.containsKey('app_lock_pin_salt'), true);
        expect(sec.containsKey('app_lock_pin'), false);
        expect(c.read(appLockControllerProvider).isAuthenticated, true);
      });

      test('legacy wrong pin returns wrongPin', () async {
        final sec = <String, String>{'app_lock_pin': 'correct'};
        final c = makeContainer(secure: sec);
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('wrong');
        expect(res, PinVerificationResult.wrongPin);
      });

      test('no stored hash and no legacy returns wrongPin', () async {
        final c = makeContainer();
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('any');
        expect(res, PinVerificationResult.wrongPin);
      });

      test('hash exists but salt missing returns wrongPin', () async {
        final sec = <String, String>{'app_lock_pin_hash': 'abcd'};
        final c = makeContainer(secure: sec);
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('any');
        expect(res, PinVerificationResult.wrongPin);
      });

      test('lockout expired allows attempt', () async {
        final past = DateTime.now().subtract(const Duration(seconds: 5)).toIso8601String();
        final sec = <String, String>{};
        final c = makeContainer(secure: sec, strings: {'app_lock_locked_until': past});
        await c.read(appLockControllerProvider.notifier).enableAppLock('5555');
        // after enable, lockout cleared
        expect(c.read(appLockControllerProvider).lockoutUntil, isNull);
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('5555');
        expect(res, PinVerificationResult.success);
      });
    });

    group('authenticateBiometric', () {
      test('returns true when not enabled (early)', () async {
        final c = makeContainer();
        final res = await c.read(appLockControllerProvider.notifier).authenticateBiometric();
        expect(res, true);
      });

      test('returns true when biometric not enabled', () async {
        final c = makeContainer(bools: {'app_lock_enabled': true, 'app_lock_biometric': false});
        final res = await c.read(appLockControllerProvider.notifier).authenticateBiometric();
        expect(res, true);
      });

      test('success sets authenticated true', () async {
        final mock = MockAppLockService();
        when(() => mock.authenticate()).thenAnswer((_) async => true);
        final c = makeContainer(
          bools: {'app_lock_enabled': true, 'app_lock_biometric': true},
          appLockService: mock,
        );
        // start unauthenticated
        expect(c.read(appLockControllerProvider).isAuthenticated, false);
        final res = await c.read(appLockControllerProvider.notifier).authenticateBiometric();
        expect(res, true);
        expect(c.read(appLockControllerProvider).isAuthenticated, true);
        expect(c.read(appLockControllerProvider).isBiometricActive, false);
      });

      test('user cancel returns false and not authenticated', () async {
        final mock = MockAppLockService();
        when(() => mock.authenticate()).thenAnswer((_) async => false);
        final c = makeContainer(
          bools: {'app_lock_enabled': true, 'app_lock_biometric': true},
          appLockService: mock,
        );
        c.read(appLockControllerProvider.notifier).lock();
        final res = await c.read(appLockControllerProvider.notifier).authenticateBiometric();
        expect(res, false);
        expect(c.read(appLockControllerProvider).isBiometricActive, false);
        expect(c.read(appLockControllerProvider).isAuthenticated, false);
      });

      test('exception returns false', () async {
        final mock = MockAppLockService();
        when(() => mock.authenticate()).thenThrow(Exception('boom'));
        final c = makeContainer(
          bools: {'app_lock_enabled': true, 'app_lock_biometric': true},
          appLockService: mock,
        );
        final res = await c.read(appLockControllerProvider.notifier).authenticateBiometric();
        expect(res, false);
        expect(c.read(appLockControllerProvider).isBiometricActive, false);
      });

      test('PlatformException also returns false', () async {
        final mock = MockAppLockService();
        when(() => mock.authenticate()).thenThrow(PlatformException(code: 'err'));
        final c = makeContainer(
          bools: {'app_lock_enabled': true, 'app_lock_biometric': true},
          appLockService: mock,
        );
        final res = await c.read(appLockControllerProvider.notifier).authenticateBiometric();
        expect(res, false);
      });
    });

    group('cancelBiometric / lock / unlock', () {
      test('cancelBiometric no-op when inactive', () async {
        final mock = MockAppLockService();
        final c = makeContainer(bools: {'app_lock_enabled': true, 'app_lock_biometric': true}, appLockService: mock);
        await c.read(appLockControllerProvider.notifier).cancelBiometric();
        verifyNever(() => mock.stopAuthentication());
      });

      test('cancelBiometric stops when active', () async {
        final mock = MockAppLockService();
        when(() => mock.stopAuthentication()).thenAnswer((_) async {});
        final c = makeContainer(bools: {'app_lock_enabled': true, 'app_lock_biometric': true}, appLockService: mock);
        // force active
        c.read(appLockControllerProvider.notifier).state = c
            .read(appLockControllerProvider)
            .copyWith(isBiometricActive: true);
        await c.read(appLockControllerProvider.notifier).cancelBiometric();
        verify(() => mock.stopAuthentication()).called(1);
        expect(c.read(appLockControllerProvider).isBiometricActive, false);
      });

      test('lock only when enabled', () {
        final c = makeContainer(bools: {'app_lock_enabled': false});
        // initially authenticated true when disabled
        expect(c.read(appLockControllerProvider).isAuthenticated, true);
        c.read(appLockControllerProvider.notifier).lock();
        expect(c.read(appLockControllerProvider).isAuthenticated, true);
      });

      test('lock sets unauthenticated when enabled', () async {
        final c = makeContainer();
        await c.read(appLockControllerProvider.notifier).enableAppLock('1234');
        expect(c.read(appLockControllerProvider).isAuthenticated, true);
        c.read(appLockControllerProvider.notifier).lock();
        expect(c.read(appLockControllerProvider).isAuthenticated, false);
      });

      test('unlock always sets authenticated', () {
        final c = makeContainer(bools: {'app_lock_enabled': true});
        expect(c.read(appLockControllerProvider).isAuthenticated, false);
        c.read(appLockControllerProvider.notifier).unlock();
        expect(c.read(appLockControllerProvider).isAuthenticated, true);
      });
    });

    group('AppLockSuppression', () {
      test('suppress and release', () {
        final container = ProviderContainer(
          overrides: [
            preferencesServiceProvider.overrideWithValue(FakePreferencesService({}, {})),
            secureStorageProvider.overrideWithValue(FakeSecureStorageService({})),
          ],
        );
        addTearDown(container.dispose);
        expect(container.read(appLockSuppressionProvider), false);
        container.read(appLockSuppressionProvider.notifier).suppress();
        expect(container.read(appLockSuppressionProvider), true);
        container.read(appLockSuppressionProvider.notifier).release();
        expect(container.read(appLockSuppressionProvider), false);
      });
    });

    group('hex helpers via enable/verify roundtrip', () {
      test('pin with special chars hashes correctly', () async {
        final sec = <String, String>{};
        final c = makeContainer(secure: sec);
        await c.read(appLockControllerProvider.notifier).enableAppLock('!@#\$%^');
        final res = await c.read(appLockControllerProvider.notifier).verifyPin('!@#\$%^');
        expect(res, PinVerificationResult.success);
        final wrong = await c.read(appLockControllerProvider.notifier).verifyPin('!@#\$%x');
        expect(wrong, PinVerificationResult.wrongPin);
      });
    });
  });
}
