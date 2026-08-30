// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportState {

 ReportPeriod get period; DateTime? get customDateStart; DateTime? get customDateEnd; ReportData get data; List<BudgetModel> get budgets; bool get isLoading;
/// Create a copy of ReportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportStateCopyWith<ReportState> get copyWith => _$ReportStateCopyWithImpl<ReportState>(this as ReportState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReportState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportState&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.customDateStart, _this.customDateStart) || other.customDateStart == _this.customDateStart)&&(identical(other.customDateEnd, _this.customDateEnd) || other.customDateEnd == _this.customDateEnd)&&(identical(other.data, _this.data) || other.data == _this.data)&&const DeepCollectionEquality().equals(other.budgets, _this.budgets)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading));
}


@override
int get hashCode {
  final _this = this as ReportState;
  return Object.hash(runtimeType,_this.period,_this.customDateStart,_this.customDateEnd,_this.data,const DeepCollectionEquality().hash(_this.budgets),_this.isLoading);
}

@override
String toString() {
  final _this = this as ReportState;
  return 'ReportState(period: ${_this.period}, customDateStart: ${_this.customDateStart}, customDateEnd: ${_this.customDateEnd}, data: ${_this.data}, budgets: ${_this.budgets}, isLoading: ${_this.isLoading})';
}


}

/// @nodoc
abstract mixin class $ReportStateCopyWith<$Res>  {
  factory $ReportStateCopyWith(ReportState value, $Res Function(ReportState) _then) = _$ReportStateCopyWithImpl;
@useResult
$Res call({
 ReportPeriod period, DateTime? customDateStart, DateTime? customDateEnd, ReportData data, List<BudgetModel> budgets, bool isLoading
});




}
/// @nodoc
class _$ReportStateCopyWithImpl<$Res>
    implements $ReportStateCopyWith<$Res> {
  _$ReportStateCopyWithImpl(this._self, this._then);

  final ReportState _self;
  final $Res Function(ReportState) _then;

/// Create a copy of ReportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? customDateStart = freezed,Object? customDateEnd = freezed,Object? data = null,Object? budgets = null,Object? isLoading = null,}) {
  return _then(ReportState(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,customDateStart: freezed == customDateStart ? _self.customDateStart : customDateStart // ignore: cast_nullable_to_non_nullable
as DateTime?,customDateEnd: freezed == customDateEnd ? _self.customDateEnd : customDateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ReportData,budgets: null == budgets ? _self.budgets : budgets // ignore: cast_nullable_to_non_nullable
as List<BudgetModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportState].
extension ReportStatePatterns on ReportState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportState value)  $default,){
final _that = this;
switch (_that) {
case _ReportState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportPeriod period,  DateTime? customDateStart,  DateTime? customDateEnd,  ReportData data,  List<BudgetModel> budgets,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportState() when $default != null:
return $default(_that.period,_that.customDateStart,_that.customDateEnd,_that.data,_that.budgets,_that.isLoading);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportPeriod period,  DateTime? customDateStart,  DateTime? customDateEnd,  ReportData data,  List<BudgetModel> budgets,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _ReportState():
return $default(_that.period,_that.customDateStart,_that.customDateEnd,_that.data,_that.budgets,_that.isLoading);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportPeriod period,  DateTime? customDateStart,  DateTime? customDateEnd,  ReportData data,  List<BudgetModel> budgets,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _ReportState() when $default != null:
return $default(_that.period,_that.customDateStart,_that.customDateEnd,_that.data,_that.budgets,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _ReportState extends ReportState {
  const _ReportState({this.period = ReportPeriod.thisMonth, this.customDateStart, this.customDateEnd, this.data = const ReportData(),  List<BudgetModel> budgets = const [], this.isLoading = true}): _budgets = budgets,super._();
  

@override@JsonKey() final  ReportPeriod period;
@override final  DateTime? customDateStart;
@override final  DateTime? customDateEnd;
@override@JsonKey() final  ReportData data;
 final  List<BudgetModel> _budgets;
@override@JsonKey() List<BudgetModel> get budgets {
  if (_budgets is EqualUnmodifiableListView) return _budgets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_budgets);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of ReportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportStateCopyWith<_ReportState> get copyWith => __$ReportStateCopyWithImpl<_ReportState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportState&&(identical(other.period, period) || other.period == period)&&(identical(other.customDateStart, customDateStart) || other.customDateStart == customDateStart)&&(identical(other.customDateEnd, customDateEnd) || other.customDateEnd == customDateEnd)&&(identical(other.data, data) || other.data == data)&&const DeepCollectionEquality().equals(other.budgets, _budgets)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode {
    return Object.hash(runtimeType,period,customDateStart,customDateEnd,data,const DeepCollectionEquality().hash(_budgets),isLoading);
}

@override
String toString() {
    return 'ReportState(period: $period, customDateStart: $customDateStart, customDateEnd: $customDateEnd, data: $data, budgets: $budgets, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$ReportStateCopyWith<$Res> implements $ReportStateCopyWith<$Res> {
  factory _$ReportStateCopyWith(_ReportState value, $Res Function(_ReportState) _then) = __$ReportStateCopyWithImpl;
@override @useResult
$Res call({
 ReportPeriod period, DateTime? customDateStart, DateTime? customDateEnd, ReportData data, List<BudgetModel> budgets, bool isLoading
});




}
/// @nodoc
class __$ReportStateCopyWithImpl<$Res>
    implements _$ReportStateCopyWith<$Res> {
  __$ReportStateCopyWithImpl(this._self, this._then);

  final _ReportState _self;
  final $Res Function(_ReportState) _then;

/// Create a copy of ReportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? customDateStart = freezed,Object? customDateEnd = freezed,Object? data = null,Object? budgets = null,Object? isLoading = null,}) {
  return _then(_ReportState(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,customDateStart: freezed == customDateStart ? _self.customDateStart : customDateStart // ignore: cast_nullable_to_non_nullable
as DateTime?,customDateEnd: freezed == customDateEnd ? _self.customDateEnd : customDateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ReportData,budgets: null == budgets ? _self._budgets : budgets // ignore: cast_nullable_to_non_nullable
as List<BudgetModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
