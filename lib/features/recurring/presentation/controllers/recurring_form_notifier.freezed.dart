// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringFormState {

 RecurringTransactionModel? get initialRecurring; TransactionType get type; int get amount; RecurringPeriod get period; String get accountId; String? get destinationAccountId; String? get categoryId; TransactionAllocation? get allocation; String? get note; bool get isActive; DateTime? get nextDate; bool get isSaving; bool get isSuccess; String? get error;
/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringFormStateCopyWith<RecurringFormState> get copyWith => _$RecurringFormStateCopyWithImpl<RecurringFormState>(this as RecurringFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecurringFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringFormState&&(identical(other.initialRecurring, _this.initialRecurring) || other.initialRecurring == _this.initialRecurring)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.destinationAccountId, _this.destinationAccountId) || other.destinationAccountId == _this.destinationAccountId)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.allocation, _this.allocation) || other.allocation == _this.allocation)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.nextDate, _this.nextDate) || other.nextDate == _this.nextDate)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isSuccess, _this.isSuccess) || other.isSuccess == _this.isSuccess)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as RecurringFormState;
  return Object.hash(runtimeType,_this.initialRecurring,_this.type,_this.amount,_this.period,_this.accountId,_this.destinationAccountId,_this.categoryId,_this.allocation,_this.note,_this.isActive,_this.nextDate,_this.isSaving,_this.isSuccess,_this.error);
}

@override
String toString() {
  final _this = this as RecurringFormState;
  return 'RecurringFormState(initialRecurring: ${_this.initialRecurring}, type: ${_this.type}, amount: ${_this.amount}, period: ${_this.period}, accountId: ${_this.accountId}, destinationAccountId: ${_this.destinationAccountId}, categoryId: ${_this.categoryId}, allocation: ${_this.allocation}, note: ${_this.note}, isActive: ${_this.isActive}, nextDate: ${_this.nextDate}, isSaving: ${_this.isSaving}, isSuccess: ${_this.isSuccess}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $RecurringFormStateCopyWith<$Res>  {
  factory $RecurringFormStateCopyWith(RecurringFormState value, $Res Function(RecurringFormState) _then) = _$RecurringFormStateCopyWithImpl;
@useResult
$Res call({
 RecurringTransactionModel? initialRecurring, TransactionType type, int amount, RecurringPeriod period, String accountId, String? destinationAccountId, String? categoryId, TransactionAllocation? allocation, String? note, bool isActive, DateTime? nextDate, bool isSaving, bool isSuccess, String? error
});


$RecurringTransactionModelCopyWith<$Res>? get initialRecurring;

}
/// @nodoc
class _$RecurringFormStateCopyWithImpl<$Res>
    implements $RecurringFormStateCopyWith<$Res> {
  _$RecurringFormStateCopyWithImpl(this._self, this._then);

  final RecurringFormState _self;
  final $Res Function(RecurringFormState) _then;

/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialRecurring = freezed,Object? type = null,Object? amount = null,Object? period = null,Object? accountId = null,Object? destinationAccountId = freezed,Object? categoryId = freezed,Object? allocation = freezed,Object? note = freezed,Object? isActive = null,Object? nextDate = freezed,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(RecurringFormState(
initialRecurring: freezed == initialRecurring ? _self.initialRecurring : initialRecurring // ignore: cast_nullable_to_non_nullable
as RecurringTransactionModel?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as RecurringPeriod,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,destinationAccountId: freezed == destinationAccountId ? _self.destinationAccountId : destinationAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,allocation: freezed == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as TransactionAllocation?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,nextDate: freezed == nextDate ? _self.nextDate : nextDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurringTransactionModelCopyWith<$Res>? get initialRecurring {
    if (_self.initialRecurring == null) {
    return null;
  }

  return $RecurringTransactionModelCopyWith<$Res>(_self.initialRecurring!, (value) {
    return _then(_self.copyWith(initialRecurring: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecurringFormState].
extension RecurringFormStatePatterns on RecurringFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringFormState value)  $default,){
final _that = this;
switch (_that) {
case _RecurringFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringFormState value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecurringTransactionModel? initialRecurring,  TransactionType type,  int amount,  RecurringPeriod period,  String accountId,  String? destinationAccountId,  String? categoryId,  TransactionAllocation? allocation,  String? note,  bool isActive,  DateTime? nextDate,  bool isSaving,  bool isSuccess,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringFormState() when $default != null:
return $default(_that.initialRecurring,_that.type,_that.amount,_that.period,_that.accountId,_that.destinationAccountId,_that.categoryId,_that.allocation,_that.note,_that.isActive,_that.nextDate,_that.isSaving,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecurringTransactionModel? initialRecurring,  TransactionType type,  int amount,  RecurringPeriod period,  String accountId,  String? destinationAccountId,  String? categoryId,  TransactionAllocation? allocation,  String? note,  bool isActive,  DateTime? nextDate,  bool isSaving,  bool isSuccess,  String? error)  $default,) {final _that = this;
switch (_that) {
case _RecurringFormState():
return $default(_that.initialRecurring,_that.type,_that.amount,_that.period,_that.accountId,_that.destinationAccountId,_that.categoryId,_that.allocation,_that.note,_that.isActive,_that.nextDate,_that.isSaving,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecurringTransactionModel? initialRecurring,  TransactionType type,  int amount,  RecurringPeriod period,  String accountId,  String? destinationAccountId,  String? categoryId,  TransactionAllocation? allocation,  String? note,  bool isActive,  DateTime? nextDate,  bool isSaving,  bool isSuccess,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _RecurringFormState() when $default != null:
return $default(_that.initialRecurring,_that.type,_that.amount,_that.period,_that.accountId,_that.destinationAccountId,_that.categoryId,_that.allocation,_that.note,_that.isActive,_that.nextDate,_that.isSaving,_that.isSuccess,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringFormState implements RecurringFormState {
  const _RecurringFormState({this.initialRecurring, this.type = TransactionType.expense, this.amount = 0, this.period = RecurringPeriod.monthly, this.accountId = '', this.destinationAccountId, this.categoryId, this.allocation, this.note, this.isActive = true, this.nextDate, this.isSaving = false, this.isSuccess = false, this.error});
  

@override final  RecurringTransactionModel? initialRecurring;
@override@JsonKey() final  TransactionType type;
@override@JsonKey() final  int amount;
@override@JsonKey() final  RecurringPeriod period;
@override@JsonKey() final  String accountId;
@override final  String? destinationAccountId;
@override final  String? categoryId;
@override final  TransactionAllocation? allocation;
@override final  String? note;
@override@JsonKey() final  bool isActive;
@override final  DateTime? nextDate;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSuccess;
@override final  String? error;

/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringFormStateCopyWith<_RecurringFormState> get copyWith => __$RecurringFormStateCopyWithImpl<_RecurringFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringFormState&&(identical(other.initialRecurring, initialRecurring) || other.initialRecurring == initialRecurring)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.period, period) || other.period == period)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.destinationAccountId, destinationAccountId) || other.destinationAccountId == destinationAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.allocation, allocation) || other.allocation == allocation)&&(identical(other.note, note) || other.note == note)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.nextDate, nextDate) || other.nextDate == nextDate)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,initialRecurring,type,amount,period,accountId,destinationAccountId,categoryId,allocation,note,isActive,nextDate,isSaving,isSuccess,error);
}

@override
String toString() {
    return 'RecurringFormState(initialRecurring: $initialRecurring, type: $type, amount: $amount, period: $period, accountId: $accountId, destinationAccountId: $destinationAccountId, categoryId: $categoryId, allocation: $allocation, note: $note, isActive: $isActive, nextDate: $nextDate, isSaving: $isSaving, isSuccess: $isSuccess, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RecurringFormStateCopyWith<$Res> implements $RecurringFormStateCopyWith<$Res> {
  factory _$RecurringFormStateCopyWith(_RecurringFormState value, $Res Function(_RecurringFormState) _then) = __$RecurringFormStateCopyWithImpl;
@override @useResult
$Res call({
 RecurringTransactionModel? initialRecurring, TransactionType type, int amount, RecurringPeriod period, String accountId, String? destinationAccountId, String? categoryId, TransactionAllocation? allocation, String? note, bool isActive, DateTime? nextDate, bool isSaving, bool isSuccess, String? error
});


@override $RecurringTransactionModelCopyWith<$Res>? get initialRecurring;

}
/// @nodoc
class __$RecurringFormStateCopyWithImpl<$Res>
    implements _$RecurringFormStateCopyWith<$Res> {
  __$RecurringFormStateCopyWithImpl(this._self, this._then);

  final _RecurringFormState _self;
  final $Res Function(_RecurringFormState) _then;

/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialRecurring = freezed,Object? type = null,Object? amount = null,Object? period = null,Object? accountId = null,Object? destinationAccountId = freezed,Object? categoryId = freezed,Object? allocation = freezed,Object? note = freezed,Object? isActive = null,Object? nextDate = freezed,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(_RecurringFormState(
initialRecurring: freezed == initialRecurring ? _self.initialRecurring : initialRecurring // ignore: cast_nullable_to_non_nullable
as RecurringTransactionModel?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as RecurringPeriod,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,destinationAccountId: freezed == destinationAccountId ? _self.destinationAccountId : destinationAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,allocation: freezed == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as TransactionAllocation?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,nextDate: freezed == nextDate ? _self.nextDate : nextDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RecurringFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurringTransactionModelCopyWith<$Res>? get initialRecurring {
    if (_self.initialRecurring == null) {
    return null;
  }

  return $RecurringTransactionModelCopyWith<$Res>(_self.initialRecurring!, (value) {
    return _then(_self.copyWith(initialRecurring: value));
  });
}
}

// dart format on
