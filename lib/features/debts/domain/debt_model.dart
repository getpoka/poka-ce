import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/core/enums.dart';

part 'debt_model.freezed.dart';
part 'debt_model.g.dart';

/// Represents a debt or loan record.
@freezed
abstract class DebtModel with _$DebtModel {
  const factory({
    required String id,
    required String personName,
    required DebtType type,
    required int amount,
    required int remainingAmount,
    required DebtStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? disbursedAmount,
    String? dueDate,
    String? note,
  }) = _DebtModel;
  const new _();

  factory fromJson(Map<String, dynamic> json) => _$DebtModelFromJson(json);

  /// Initial cash disbursed or lent to or from the wallet.
  int get effectiveDisbursedAmount => disbursedAmount ?? amount;

  /// Total interest or extra fee beyond the disbursed amount.
  int get interestAmount => amount > effectiveDisbursedAmount ? amount - effectiveDisbursedAmount : 0;
}
