/// Result type contract for Poka CE.
///
/// All Repository methods MUST return [Result<T>] — never throw exceptions.
/// Riverpod Notifiers MUST use Dart 3 switch exhaustive pattern matching:
///
/// ```dart
/// switch (result) {
///   case Success(:final value) => state = value,
///   case Failure(:final failure) => state = Error(failure),
/// }
/// ```
library;

export 'package:result_dart/result_dart.dart' show Failure, Result, Success;
