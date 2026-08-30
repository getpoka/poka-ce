import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Result sealed class', () {
    test('Success holds value and fold succeeds', () {
      const r = Success<String, Failure>('ok');
      expect(r.value, 'ok');
      final out = r.fold((v) => 'success:$v', (e) => 'error');
      expect(out, 'success:ok');
    });

    test('ErrorResult holds error and fold fails', () {
      const r = ErrorResult<String, Failure>(DatabaseFailure('db err'));
      expect(r.error.message, 'db err');
      final out = r.fold((v) => 'success', (e) => 'error:${e.message}');
      expect(out, 'error:db err');
    });

    test('Success is Result', () {
      const r = Success<int, Failure>(42);
      expect(r, isA<Result<int, Failure>>());
    });

    test('ErrorResult is Result', () {
      const r = ErrorResult<int, Failure>(ValidationFailure('bad'));
      expect(r, isA<Result<int, Failure>>());
    });

    test('Failure subclasses', () {
      expect(const DatabaseFailure('x'), isA<Failure>());
      expect(const ValidationFailure('x'), isA<Failure>());
      expect(const UnexpectedFailure('x'), isA<Failure>());
    });

    test('switch pattern matching exhaustive', () {
      Result<int, Failure> r = const Success(10);
      final val = switch (r) {
        Success(value: final v) => v,
        ErrorResult(error: final e) => -1,
      };
      expect(val, 10);

      r = const ErrorResult(DatabaseFailure('fail'));
      final val2 = switch (r) {
        Success(value: final v) => v,
        ErrorResult(error: final e) => e.message.length,
      };
      expect(val2, 4);
    });
  });
}
