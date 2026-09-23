import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/filter/transaction_filter_allocation_group.dart';

void main() {
  group('TransactionFilterAllocationGroup', () {
    test('covers all TransactionAllocation values', () {
      expect(TransactionAllocation.values, hasLength(3));
      expect(
        TransactionAllocation.values,
        containsAll([TransactionAllocation.need, TransactionAllocation.want, TransactionAllocation.saving]),
      );
    });
  });
}
