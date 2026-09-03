import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/shared/utils/math_evaluator.dart';

void main() {
  group('MathEvaluator.evaluate', () {
    test('empty expression returns null', () {
      expect(MathEvaluator.evaluate(''), isNull);
    });

    test('plain number without operator returns null', () {
      expect(MathEvaluator.evaluate('125'), isNull);
    });

    test('trailing operator is stripped, leaving no operator -> null', () {
      expect(MathEvaluator.evaluate('125+'), isNull);
    });

    test('leading negative only is not an operator expression', () {
      expect(MathEvaluator.evaluate('-125'), isNull);
    });

    test('simple addition', () {
      expect(MathEvaluator.evaluate('5+3'), '8');
    });

    test('simple subtraction', () {
      expect(MathEvaluator.evaluate('10-4'), '6');
    });

    test('multiplication', () {
      expect(MathEvaluator.evaluate('2*3'), '6');
    });

    test('÷ symbol is treated as operator but not parseable, returns null', () {
      expect(MathEvaluator.evaluate('10÷2'), isNull);
    });

    test('division with / symbol', () {
      expect(MathEvaluator.evaluate('7/2'), '3.5');
    });

    test('result ending in .0 is normalized to integer string', () {
      expect(MathEvaluator.evaluate('1.5+1.5'), '3');
    });

    test('malformed expression returns null', () {
      expect(MathEvaluator.evaluate('5++*'), isNull);
      expect(MathEvaluator.evaluate('abc+1'), isNull);
    });
  });

  group('MathEvaluator.isOperator', () {
    test('recognizes all operators', () {
      expect(MathEvaluator.isOperator('+'), isTrue);
      expect(MathEvaluator.isOperator('-'), isTrue);
      expect(MathEvaluator.isOperator('*'), isTrue);
      expect(MathEvaluator.isOperator('÷'), isTrue);
      expect(MathEvaluator.isOperator('/'), isTrue);
    });

    test('rejects non-operators', () {
      expect(MathEvaluator.isOperator('5'), isFalse);
      expect(MathEvaluator.isOperator('.'), isFalse);
      expect(MathEvaluator.isOperator('C'), isFalse);
    });
  });

  group('MathEvaluator.hasUnresolvedOperator', () {
    test('empty expression has no operator', () {
      expect(MathEvaluator.hasUnresolvedOperator(''), isFalse);
    });

    test('leading negative does not count as unresolved', () {
      expect(MathEvaluator.hasUnresolvedOperator('-5'), isFalse);
    });

    test('number only has no operator', () {
      expect(MathEvaluator.hasUnresolvedOperator('1500'), isFalse);
    });

    test('expression with operator returns true', () {
      expect(MathEvaluator.hasUnresolvedOperator('15+5'), isTrue);
      expect(MathEvaluator.hasUnresolvedOperator('15*5'), isTrue);
    });
  });

  group('MathEvaluator.handleKeyPress', () {
    test('C clears expression', () {
      expect(MathEvaluator.handleKeyPress('123+456', 'C'), '');
    });

    test('backspace removes last char', () {
      expect(MathEvaluator.handleKeyPress('123', '⌫'), '12');
    });

    test('backspace on empty stays empty', () {
      expect(MathEvaluator.handleKeyPress('', '⌫'), '');
    });

    test('= evaluates expression', () {
      expect(MathEvaluator.handleKeyPress('5+3', '='), '8');
    });

    test('OK evaluates expression', () {
      expect(MathEvaluator.handleKeyPress('10*2', 'OK'), '20');
    });

    test('= keeps expression when not evaluable', () {
      expect(MathEvaluator.handleKeyPress('5', '='), '5');
    });

    test('plus-minus negates plain number', () {
      expect(MathEvaluator.handleKeyPress('5', '+/-'), '-5');
    });

    test('plus-minus evaluates then negates', () {
      expect(MathEvaluator.handleKeyPress('5+3', '+/-'), '-8');
    });

    test('plus-minus removes leading minus', () {
      expect(MathEvaluator.handleKeyPress('-5', '+/-'), '5');
    });

    test('plus-minus evaluates negative result then strips minus', () {
      expect(MathEvaluator.handleKeyPress('-5+3', '+/-'), '2');
    });

    test('plus-minus ignored when last char is operator', () {
      expect(MathEvaluator.handleKeyPress('5+', '+/-'), '5+');
    });

    test('operator on empty expression only allows minus', () {
      expect(MathEvaluator.handleKeyPress('', '-'), '-');
      expect(MathEvaluator.handleKeyPress('', '+'), '');
    });

    test('operator replaces previous operator', () {
      expect(MathEvaluator.handleKeyPress('5+', '*'), '5*');
      expect(MathEvaluator.handleKeyPress('5*', '÷'), '5÷');
    });

    test('operator appends after number', () {
      expect(MathEvaluator.handleKeyPress('5', '+'), '5+');
    });

    test('first digit replaces leading zero', () {
      expect(MathEvaluator.handleKeyPress('0', '5'), '5');
    });

    test('triple zero on leading zero stays zero', () {
      expect(MathEvaluator.handleKeyPress('0', '000'), '0');
    });

    test('digit after operator on trailing zero replaces the zero', () {
      expect(MathEvaluator.handleKeyPress('5+0', '7'), '5+7');
    });

    test('triple zero after operator on trailing zero keeps single zero', () {
      expect(MathEvaluator.handleKeyPress('5+0', '000'), '5+0');
    });

    test('digit appends to normal number', () {
      expect(MathEvaluator.handleKeyPress('12', '3'), '123');
    });

    test('digit is capped at 20 characters', () {
      const maxExpression = '12345678901234567890';
      expect(MathEvaluator.handleKeyPress(maxExpression, '9'), maxExpression);
    });

    test('decimal point appends to number', () {
      expect(MathEvaluator.handleKeyPress('5', '.'), '5.');
    });

    test('second decimal point in same part is ignored', () {
      expect(MathEvaluator.handleKeyPress('5.', '.'), '5.');
    });

    test('decimal point after operator inserts leading zero', () {
      expect(MathEvaluator.handleKeyPress('5+', '.'), '5+0.');
    });

    test('decimal point in earlier part still allowed', () {
      expect(MathEvaluator.handleKeyPress('5.5+2', '.'), '5.5+2.');
    });
  });
}
