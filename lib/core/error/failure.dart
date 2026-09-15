/// Base class for all failures in the application.
sealed class Failure {
  const new(this.message);
  final String message;
}

/// Represents an error occurring during database operations.
class DatabaseFailure extends Failure {
  const new(super.message);
}

/// Represents an error occurring during data validation (e.g., negative amount).
class ValidationFailure extends Failure {
  const new(super.message);
}

/// Represents an unexpected error.
class UnexpectedFailure extends Failure {
  const new(super.message);
}
