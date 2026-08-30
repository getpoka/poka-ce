/// Base class for all failures in the application.
sealed class Failure {
  const Failure(this.message);
  final String message;
}

/// Represents an error occurring during database operations.
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// Represents an error occurring during data validation (e.g., negative amount).
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Represents an unexpected error.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
