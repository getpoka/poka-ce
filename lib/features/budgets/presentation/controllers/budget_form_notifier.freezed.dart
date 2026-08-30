// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BudgetFormState {

 BudgetModel? get initialBudget; String get name; int get amount; BudgetPeriod get period; int? get resetDay; int? get alertThreshold; DateTime? get endDate; String? get categoryId; String? get accountId; bool get isSaving; bool get isSuccess; String? get error;
/// Create a copy of BudgetFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetFormStateCopyWith<BudgetFormState> get copyWith => _$BudgetFormStateCopyWithImpl<BudgetFormState>(this as BudgetFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BudgetFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetFormState&&(identical(other.initialBudget, _this.initialBudget) || other.initialBudget == _this.initialBudget)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.resetDay, _this.resetDay) || other.resetDay == _this.resetDay)&&(identical(other.alertThreshold, _this.alertThreshold) || other.alertThreshold == _this.alertThreshold)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isSuccess, _this.isSuccess) || other.isSuccess == _this.isSuccess)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as BudgetFormState;
  return Object.hash(runtimeType,_this.initialBudget,_this.name,_this.amount,_this.period,_this.resetDay,_this.alertThreshold,_this.endDate,_this.categoryId,_this.accountId,_this.isSaving,_this.isSuccess,_this.error);
}

@override
String toString() {
  final _this = this as BudgetFormState;
  return 'BudgetFormState(initialBudget: ${_this.initialBudget}, name: ${_this.name}, amount: ${_this.amount}, period: ${_this.period}, resetDay: ${_this.resetDay}, alertThreshold: ${_this.alertThreshold}, endDate: ${_this.endDate}, categoryId: ${_this.categoryId}, accountId: ${_this.accountId}, isSaving: ${_this.isSaving}, isSuccess: ${_this.isSuccess}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $BudgetFormStateCopyWith<$Res>  {
  factory $BudgetFormStateCopyWith(BudgetFormState value, $Res Function(BudgetFormState) _then) = _$BudgetFormStateCopyWithImpl;
@useResult
$Res call({
 BudgetModel? initialBudget, String name, int amount, BudgetPeriod period, int? resetDay, int? alertThreshold, DateTime? endDate, String? categoryId, String? accountId, bool isSaving, bool isSuccess, String? error
});


$BudgetModelCopyWith<$Res>? get initialBudget;

}
/// @nodoc
class _$BudgetFormStateCopyWithImpl<$Res>
    implements $BudgetFormStateCopyWith<$Res> {
  _$BudgetFormStateCopyWithImpl(this._self, this._then);

  final BudgetFormState _self;
  final $Res Function(BudgetFormState) _then;

/// Create a copy of BudgetFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialBudget = freezed,Object? name = null,Object? amount = null,Object? period = null,Object? resetDay = freezed,Object? alertThreshold = freezed,Object? endDate = freezed,Object? categoryId = freezed,Object? accountId = freezed,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(BudgetFormState(
initialBudget: freezed == initialBudget ? _self.initialBudget : initialBudget // ignore: cast_nullable_to_non_nullable
as BudgetModel?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as BudgetPeriod,resetDay: freezed == resetDay ? _self.resetDay : resetDay // ignore: cast_nullable_to_non_nullable
as int?,alertThreshold: freezed == alertThreshold ? _self.alertThreshold : alertThreshold // ignore: cast_nullable_to_non_nullable
as int?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BudgetFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetModelCopyWith<$Res>? get initialBudget {
    if (_self.initialBudget == null) {
    return null;
  }

  return $BudgetModelCopyWith<$Res>(_self.initialBudget!, (value) {
    return _then(_self.copyWith(initialBudget: value));
  });
}
}


/// Adds pattern-matching-related methods to [BudgetFormState].
extension BudgetFormStatePatterns on BudgetFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetFormState value)  $default,){
final _that = this;
switch (_that) {
case _BudgetFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetFormState value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BudgetModel? initialBudget,  String name,  int amount,  BudgetPeriod period,  int? resetDay,  int? alertThreshold,  DateTime? endDate,  String? categoryId,  String? accountId,  bool isSaving,  bool isSuccess,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetFormState() when $default != null:
return $default(_that.initialBudget,_that.name,_that.amount,_that.period,_that.resetDay,_that.alertThreshold,_that.endDate,_that.categoryId,_that.accountId,_that.isSaving,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BudgetModel? initialBudget,  String name,  int amount,  BudgetPeriod period,  int? resetDay,  int? alertThreshold,  DateTime? endDate,  String? categoryId,  String? accountId,  bool isSaving,  bool isSuccess,  String? error)  $default,) {final _that = this;
switch (_that) {
case _BudgetFormState():
return $default(_that.initialBudget,_that.name,_that.amount,_that.period,_that.resetDay,_that.alertThreshold,_that.endDate,_that.categoryId,_that.accountId,_that.isSaving,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BudgetModel? initialBudget,  String name,  int amount,  BudgetPeriod period,  int? resetDay,  int? alertThreshold,  DateTime? endDate,  String? categoryId,  String? accountId,  bool isSaving,  bool isSuccess,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _BudgetFormState() when $default != null:
return $default(_that.initialBudget,_that.name,_that.amount,_that.period,_that.resetDay,_that.alertThreshold,_that.endDate,_that.categoryId,_that.accountId,_that.isSaving,_that.isSuccess,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _BudgetFormState implements BudgetFormState {
  const _BudgetFormState({this.initialBudget, this.name = '', this.amount = 0, this.period = BudgetPeriod.monthly, this.resetDay, this.alertThreshold, this.endDate, this.categoryId, this.accountId, this.isSaving = false, this.isSuccess = false, this.error});
  

@override final  BudgetModel? initialBudget;
@override@JsonKey() final  String name;
@override@JsonKey() final  int amount;
@override@JsonKey() final  BudgetPeriod period;
@override final  int? resetDay;
@override final  int? alertThreshold;
@override final  DateTime? endDate;
@override final  String? categoryId;
@override final  String? accountId;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSuccess;
@override final  String? error;

/// Create a copy of BudgetFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetFormStateCopyWith<_BudgetFormState> get copyWith => __$BudgetFormStateCopyWithImpl<_BudgetFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetFormState&&(identical(other.initialBudget, initialBudget) || other.initialBudget == initialBudget)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.period, period) || other.period == period)&&(identical(other.resetDay, resetDay) || other.resetDay == resetDay)&&(identical(other.alertThreshold, alertThreshold) || other.alertThreshold == alertThreshold)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,initialBudget,name,amount,period,resetDay,alertThreshold,endDate,categoryId,accountId,isSaving,isSuccess,error);
}

@override
String toString() {
    return 'BudgetFormState(initialBudget: $initialBudget, name: $name, amount: $amount, period: $period, resetDay: $resetDay, alertThreshold: $alertThreshold, endDate: $endDate, categoryId: $categoryId, accountId: $accountId, isSaving: $isSaving, isSuccess: $isSuccess, error: $error)';
}


}

/// @nodoc
abstract mixin class _$BudgetFormStateCopyWith<$Res> implements $BudgetFormStateCopyWith<$Res> {
  factory _$BudgetFormStateCopyWith(_BudgetFormState value, $Res Function(_BudgetFormState) _then) = __$BudgetFormStateCopyWithImpl;
@override @useResult
$Res call({
 BudgetModel? initialBudget, String name, int amount, BudgetPeriod period, int? resetDay, int? alertThreshold, DateTime? endDate, String? categoryId, String? accountId, bool isSaving, bool isSuccess, String? error
});


@override $BudgetModelCopyWith<$Res>? get initialBudget;

}
/// @nodoc
class __$BudgetFormStateCopyWithImpl<$Res>
    implements _$BudgetFormStateCopyWith<$Res> {
  __$BudgetFormStateCopyWithImpl(this._self, this._then);

  final _BudgetFormState _self;
  final $Res Function(_BudgetFormState) _then;

/// Create a copy of BudgetFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialBudget = freezed,Object? name = null,Object? amount = null,Object? period = null,Object? resetDay = freezed,Object? alertThreshold = freezed,Object? endDate = freezed,Object? categoryId = freezed,Object? accountId = freezed,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(_BudgetFormState(
initialBudget: freezed == initialBudget ? _self.initialBudget : initialBudget // ignore: cast_nullable_to_non_nullable
as BudgetModel?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as BudgetPeriod,resetDay: freezed == resetDay ? _self.resetDay : resetDay // ignore: cast_nullable_to_non_nullable
as int?,alertThreshold: freezed == alertThreshold ? _self.alertThreshold : alertThreshold // ignore: cast_nullable_to_non_nullable
as int?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BudgetFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetModelCopyWith<$Res>? get initialBudget {
    if (_self.initialBudget == null) {
    return null;
  }

  return $BudgetModelCopyWith<$Res>(_self.initialBudget!, (value) {
    return _then(_self.copyWith(initialBudget: value));
  });
}
}

// dart format on
