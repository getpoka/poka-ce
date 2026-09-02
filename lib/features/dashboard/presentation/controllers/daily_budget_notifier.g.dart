// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_budget_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DailyBudget)
final dailyBudgetProvider = DailyBudgetProvider._();

final class DailyBudgetProvider extends $NotifierProvider<DailyBudget, double> {
  DailyBudgetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyBudgetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyBudgetHash();

  @$internal
  @override
  DailyBudget create() => DailyBudget();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$dailyBudgetHash() => r'34bcbf6b2fb88d53578cac24e3ae6749f25448ed';

abstract class _$DailyBudget extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
