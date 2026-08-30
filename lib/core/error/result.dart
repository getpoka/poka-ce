/// A sealed class representing the outcome of an operation.
sealed class Result<T, E> {
  const Result();

  /// Executes [onSuccess] if this is a [Success], or [onError] if this is an [Error].
  R fold<R>(R Function(T value) onSuccess, R Function(E error) onError) {
    return switch (this) {
      Success(value: final v) => onSuccess(v),
      ErrorResult(error: final e) => onError(e),
    };
  }
}

/// Represents a successful outcome.
class Success<T, E> extends Result<T, E> {
  const Success(this.value);
  final T value;
}

/// Represents a failed outcome.
class ErrorResult<T, E> extends Result<T, E> {
  const ErrorResult(this.error);
  final E error;
}
