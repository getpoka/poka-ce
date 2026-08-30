import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/services/secure_storage_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureStorageService service;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    service = SecureStorageService(mockStorage);
  });

  group('SecureStorageService', () {
    test('write calls storage', () async {
      when(() => mockStorage.write(key: 'k', value: 'v')).thenAnswer((_) async {});
      await service.write('k', 'v');
      verify(() => mockStorage.write(key: 'k', value: 'v')).called(1);
    });

    test('read calls storage', () async {
      when(() => mockStorage.read(key: 'k')).thenAnswer((_) async => 'v');
      final res = await service.read('k');
      expect(res, 'v');
      verify(() => mockStorage.read(key: 'k')).called(1);
    });

    test('delete calls storage', () async {
      when(() => mockStorage.delete(key: 'k')).thenAnswer((_) async {});
      await service.delete('k');
      verify(() => mockStorage.delete(key: 'k')).called(1);
    });
  });
}
