import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('StringExtension toColor', () {
    test('parses hex without #', () {
      const hex = 'FF5733';
      final color = hex.toColor();
      expect(color, const Color(0xFFFF5733));
    });

    test('parses hex with # prefix', () {
      const hex = '#FF5733';
      final color = hex.toColor();
      expect(color, const Color(0xFFFF5733));
    });

    test('returns default color on invalid hex', () {
      const invalid = 'ZZZZZZ';
      final color = invalid.toColor();
      expect(color, const Color(0xFFCCCCCC));
    });

    test('returns custom default on invalid hex', () {
      const invalid = 'not-a-color';
      const custom = Color(0xFF123456);
      final color = invalid.toColor(custom);
      expect(color, custom);
    });

    test('parses 6-char hex correctly', () {
      expect('000000'.toColor(), const Color(0xFF000000));
      expect('FFFFFF'.toColor(), const Color(0xFFFFFFFF));
    });
  });
}
