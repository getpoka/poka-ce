import 'package:math_expressions/math_expressions.dart';

class MathEvaluator {
  /// Evaluates a math expression string and returns the result, or null if invalid/no operator.
  static String? evaluate(String expression) {
    if (expression.isEmpty) return null;

    var exprToEval = expression;
    final lastChar = exprToEval[exprToEval.length - 1];
    if (lastChar == '+' || lastChar == '-' || lastChar == '*' || lastChar == '÷' || lastChar == '/') {
      exprToEval = exprToEval.substring(0, exprToEval.length - 1);
    }

    // Only evaluate if there is at least one operator left inside (excluding leading negative)
    var hasOperator = false;
    for (var i = 1; i < exprToEval.length; i++) {
      final c = exprToEval[i];
      if (c == '+' || c == '-' || c == '*' || c == '÷' || c == '/') {
        hasOperator = true;
        break;
      }
    }
    if (!hasOperator) return null;

    try {
      final exp = ShuntingYardParser().parse(exprToEval);
      final result = RealEvaluator().evaluate(exp).toString();
      return result.endsWith('.0') ? result.replaceAll('.0', '') : result;
    } on Object {
      return null;
    }
  }

  static bool isOperator(String c) {
    return c == '+' || c == '-' || c == '*' || c == '÷' || c == '/';
  }

  static bool hasUnresolvedOperator(String expression) {
    if (expression.isEmpty) return false;
    for (var i = 1; i < expression.length; i++) {
      if (isOperator(expression[i])) return true;
    }
    return false;
  }

  /// Processes a numpad key press against a current expression and returns the new expression.
  static String handleKeyPress(String currentExpression, String key) {
    var expression = currentExpression;
    switch (key) {
      case 'C':
        return '';
      case '⌫':
        if (expression.isNotEmpty) {
          return expression.substring(0, expression.length - 1);
        }
        return '';
      case '=':
      case 'OK':
        final result = evaluate(expression);
        return result ?? expression;
      case '+/-':
        if (expression.isNotEmpty && !isOperator(expression[expression.length - 1])) {
          final result = evaluate(expression);
          if (result != null) {
            expression = result;
          }
          if (expression.startsWith('-')) {
            return expression.substring(1);
          } else {
            return '-$expression';
          }
        }
        return expression;
      default:
        if (isOperator(key)) {
          if (expression.isEmpty) {
            if (key == '-') return key;
          } else if (isOperator(expression[expression.length - 1])) {
            return expression.substring(0, expression.length - 1) + key;
          } else {
            return expression + key;
          }
        } else {
          if (expression.length >= 20) return expression;

          if (key == '.') {
            final regex = RegExp(r'[+\-*/]');
            final parts = expression.split(regex);
            final lastPart = parts.isNotEmpty ? parts.last : '';
            if (lastPart.contains('.')) return expression;
            if (lastPart.isEmpty) {
              return '${expression}0.';
            }
            return expression + key;
          } else {
            if (expression == '0') {
              return key == '000' ? '0' : key;
            } else if (expression.length >= 2 &&
                expression.endsWith('0') &&
                isOperator(expression[expression.length - 2])) {
              return expression.substring(0, expression.length - 1) + (key == '000' ? '0' : key);
            } else {
              return expression + key;
            }
          }
        }
    }
    return expression;
  }
}
