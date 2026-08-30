import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AppConfig', () {
    test('should have seedEssentials default to true', () {
      expect(AppConfig.seedEssentials, isA<bool>());
      // Note: testing default environment values in tests can be tricky as
      // test runner might not pass the environment variable.
      expect(AppConfig.seedEssentials, isTrue);
    });

    test('should have seedDummyData default to false', () {
      expect(AppConfig.seedDummyData, isA<bool>());
      expect(AppConfig.seedDummyData, isFalse);
    });
  });
}
