/// Drift TypeConverters and helper functions for the Three-Tier Temporal Architecture.
///
/// - [LocalDateConverter]: maps `String` ↔ `String` for `DateTimeColumn` backed by `'YYYY-MM-DD'`.
/// - [LocalDateTimeConverter]: maps `String` ↔ `String` for `DateTimeColumn` backed by `'YYYY-MM-DDTHH:mm:ss'`.
///
/// These converters are identity-pass-through — Drift stores `TextColumn` values
/// directly as the string we provide. Their purpose is to document intent and
/// centralise the two temporal formats in one place.
library;

import 'package:drift/drift.dart';

/// Drift converter for a pure calendar date stored as `'YYYY-MM-DD'` text.
///
/// Never apply `.toUtc()` or `.toLocal()` to values handled by this converter.
class LocalDateConverter extends TypeConverter<String, String> {
  /// Creates a [LocalDateConverter].
  const new();

  @override
  String fromSql(String fromDb) => fromDb;

  @override
  String toSql(String value) => value;
}

/// Drift converter for a wall-clock event datetime stored as `'YYYY-MM-DDTHH:mm:ss'` text.
///
/// Represents the local date and time of a physical receipt chosen in the UI.
/// Never convert to UTC on save or during date grouping.
class LocalDateTimeConverter extends TypeConverter<String, String> {
  /// Creates a [LocalDateTimeConverter].
  const new();

  @override
  String fromSql(String fromDb) => fromDb;

  @override
  String toSql(String value) => value;
}

/// Returns today's date as a `'YYYY-MM-DD'` string using the device's local calendar.
///
/// Do NOT call `.toUtc()` on the result — this is a pure calendar date.
String todayAsLocalDate([DateTime? date]) {
  final now = date ?? DateTime.now();
  final y = now.year.toString().padLeft(4, '0');
  final m = now.month.toString().padLeft(2, '0');
  final d = now.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

/// Formats a [DateTime] as `'YYYY-MM-DDTHH:mm:ss'` using local wall-clock values.
///
/// Do NOT call `.toUtc()` or `.toLocal()` on the result — this is a wall-clock receipt instant.
String formatAsLocalDateTime(DateTime date) {
  final y = date.year.toString().padLeft(4, '0');
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  final h = date.hour.toString().padLeft(2, '0');
  final min = date.minute.toString().padLeft(2, '0');
  final s = date.second.toString().padLeft(2, '0');
  return '$y-$m-${d}T$h:$min:$s';
}

/// Returns the current local wall-clock time as `'YYYY-MM-DDTHH:mm:ss'`.
///
/// If [date] is provided, formats that [DateTime] instead of `DateTime.now()`.
/// Suitable for transaction date fields (LocalDateTime semantic tier).
/// Do NOT call `.toUtc()` on the result.
String nowAsLocalDateTime([DateTime? date]) {
  return formatAsLocalDateTime(date ?? DateTime.now());
}
