// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(budgetProgress)
final budgetProgressProvider = BudgetProgressFamily._();

final class BudgetProgressProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  BudgetProgressProvider._({
    required BudgetProgressFamily super.from,
    required BudgetModel super.argument,
  }) : super(
         retry: null,
         name: r'budgetProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$budgetProgressHash();

  @override
  String toString() {
    return r'budgetProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as BudgetModel;
    return budgetProgress(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BudgetProgressProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$budgetProgressHash() => r'5d43323347de03a8b8c5789ac2a53c9be9b2ca46';

final class BudgetProgressFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, BudgetModel> {
  BudgetProgressFamily._()
    : super(
        retry: null,
        name: r'budgetProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BudgetProgressProvider call(BudgetModel budget) =>
      BudgetProgressProvider._(argument: budget, from: this);

  @override
  String toString() => r'budgetProgressProvider';
}
