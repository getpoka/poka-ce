import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('CurrencyModel', () {
    test('fromJson/toJson', () {
      const m = CurrencyModel(id: 'c1', name: 'Rupiah', code: 'IDR', symbol: 'Rp', precision: 2);
      final json = m.toJson();
      final restored = CurrencyModel.fromJson(json);
      expect(restored, equals(m));
    });

    test('copyWith', () {
      const m = CurrencyModel(id: 'c1', name: 'Rupiah', code: 'IDR', symbol: 'Rp', precision: 2);
      final c = m.copyWith(name: 'Dollar', code: 'USD');
      expect(c.name, 'Dollar');
      expect(c.code, 'USD');
      expect(c.id, 'c1');
    });

    test('equality', () {
      const a = CurrencyModel(id: 'c1', name: 'Rupiah', code: 'IDR', symbol: 'Rp', precision: 2);
      const b = CurrencyModel(id: 'c1', name: 'Rupiah', code: 'IDR', symbol: 'Rp', precision: 2);
      expect(a, equals(b));
    });
  });
}
