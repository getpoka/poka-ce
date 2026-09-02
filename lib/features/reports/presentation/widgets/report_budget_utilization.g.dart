// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_budget_utilization.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportBudgetTotalSpent)
final reportBudgetTotalSpentProvider = ReportBudgetTotalSpentProvider._();

final class ReportBudgetTotalSpentProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  ReportBudgetTotalSpentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportBudgetTotalSpentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportBudgetTotalSpentHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return reportBudgetTotalSpent(ref);
  }
}

String _$reportBudgetTotalSpentHash() =>
    r'ad0a6a59b580ca6f6df25980bf13725a39bc41d2';
