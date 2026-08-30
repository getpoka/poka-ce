/// Unit of Work interface to encapsulate database transactions in the domain layer
/// without coupling the domain to the data layer's specific implementation (e.g. Drift).
// ignore: one_member_abstracts
abstract class IUnitOfWork {
  /// Executes the given [action] within a database transaction.
  /// If the action throws an exception, the transaction is rolled back.
  Future<T> execute<T>(Future<T> Function() action);
}
