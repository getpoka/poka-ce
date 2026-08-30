import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/services/app_lock_service.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter/services.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockTalker extends Mock implements Talker {}

void main() {
  late MockLocalAuthentication mockAuth;
  late MockTalker mockTalker;
  late AppLockService service;

  setUp(() {
    mockAuth = MockLocalAuthentication();
    mockTalker = MockTalker();
    service = AppLockService(mockAuth, mockTalker);
  });

  group('AppLockService', () {
    test('canAuthenticate returns true if biometrics can be checked', () async {
      when(() => mockAuth.canCheckBiometrics).thenAnswer((_) async => true);
      when(() => mockAuth.isDeviceSupported()).thenAnswer((_) async => false);
      final res = await service.canAuthenticate();
      expect(res, true);
    });

    test('canAuthenticate returns true if device is supported', () async {
      when(() => mockAuth.canCheckBiometrics).thenAnswer((_) async => false);
      when(() => mockAuth.isDeviceSupported()).thenAnswer((_) async => true);
      final res = await service.canAuthenticate();
      expect(res, true);
    });

    test('getAvailableBiometrics calls auth', () async {
      when(() => mockAuth.getAvailableBiometrics()).thenAnswer((_) async => [BiometricType.face]);
      final res = await service.getAvailableBiometrics();
      expect(res, [BiometricType.face]);
    });

    test('authenticate success with biometrics', () async {
      when(() => mockAuth.getAvailableBiometrics()).thenAnswer((_) async => [BiometricType.fingerprint]);
      when(
        () => mockAuth.authenticate(
          localizedReason: any(named: 'localizedReason'),
          persistAcrossBackgrounding: any(named: 'persistAcrossBackgrounding'),
          biometricOnly: any(named: 'biometricOnly'),
          sensitiveTransaction: any(named: 'sensitiveTransaction'),
        ),
      ).thenAnswer((_) async => true);

      final res = await service.authenticate();
      expect(res, true);

      // verify biometricOnly is true since available biometrics is not empty
      verify(
        () => mockAuth.authenticate(
          localizedReason: any(named: 'localizedReason'),
          persistAcrossBackgrounding: true,
          biometricOnly: true,
          sensitiveTransaction: false,
        ),
      ).called(1);
    });

    test('authenticate fallback to device credentials when no biometrics', () async {
      when(() => mockAuth.getAvailableBiometrics()).thenAnswer((_) async => []);
      when(
        () => mockAuth.authenticate(
          localizedReason: any(named: 'localizedReason'),
          persistAcrossBackgrounding: any(named: 'persistAcrossBackgrounding'),
          biometricOnly: any(named: 'biometricOnly'),
          sensitiveTransaction: any(named: 'sensitiveTransaction'),
        ),
      ).thenAnswer((_) async => false);

      final res = await service.authenticate();
      expect(res, false);

      // verify biometricOnly is false since available biometrics is empty
      verify(
        () => mockAuth.authenticate(
          localizedReason: any(named: 'localizedReason'),
          persistAcrossBackgrounding: true,
          biometricOnly: false,
          sensitiveTransaction: false,
        ),
      ).called(1);
    });

    test('authenticate throws LocalAuthException', () async {
      when(() => mockAuth.getAvailableBiometrics()).thenAnswer((_) async => [BiometricType.face]);
      when(
        () => mockAuth.authenticate(
          localizedReason: any(named: 'localizedReason'),
          persistAcrossBackgrounding: any(named: 'persistAcrossBackgrounding'),
          biometricOnly: any(named: 'biometricOnly'),
          sensitiveTransaction: any(named: 'sensitiveTransaction'),
        ),
      ).thenThrow(PlatformException(code: 'lockedOut'));

      expect(() => service.authenticate(), throwsA(isA<PlatformException>()));
    });

    test('authenticate catches generic Exception and returns false', () async {
      when(() => mockAuth.getAvailableBiometrics()).thenAnswer((_) async => [BiometricType.face]);
      when(
        () => mockAuth.authenticate(
          localizedReason: any(named: 'localizedReason'),
          persistAcrossBackgrounding: any(named: 'persistAcrossBackgrounding'),
          biometricOnly: any(named: 'biometricOnly'),
          sensitiveTransaction: any(named: 'sensitiveTransaction'),
        ),
      ).thenThrow(Exception('boom'));

      final res = await service.authenticate();
      expect(res, false);
    });

    test('stopAuthentication calls auth', () async {
      when(() => mockAuth.stopAuthentication()).thenAnswer((_) async => true);
      await service.stopAuthentication();
      verify(() => mockAuth.stopAuthentication()).called(1);
    });

    test('stopAuthentication catches exception', () async {
      when(() => mockAuth.stopAuthentication()).thenThrow(Exception('boom'));
      await service.stopAuthentication();
      verify(() => mockAuth.stopAuthentication()).called(1);
    });
  });
}
