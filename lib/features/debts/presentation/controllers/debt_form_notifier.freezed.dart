// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebtFormState {

 DebtModel? get initialDebt; String get accountId; String get categoryId; String get personName; DebtType get type; int get amount; DebtStatus get status; DateTime? get dueDate; String? get note; bool get isSaving; bool get isSuccess; String? get error;
/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtFormStateCopyWith<DebtFormState> get copyWith => _$DebtFormStateCopyWithImpl<DebtFormState>(this as DebtFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DebtFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtFormState&&(identical(other.initialDebt, _this.initialDebt) || other.initialDebt == _this.initialDebt)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.personName, _this.personName) || other.personName == _this.personName)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isSuccess, _this.isSuccess) || other.isSuccess == _this.isSuccess)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as DebtFormState;
  return Object.hash(runtimeType,_this.initialDebt,_this.accountId,_this.categoryId,_this.personName,_this.type,_this.amount,_this.status,_this.dueDate,_this.note,_this.isSaving,_this.isSuccess,_this.error);
}

@override
String toString() {
  final _this = this as DebtFormState;
  return 'DebtFormState(initialDebt: ${_this.initialDebt}, accountId: ${_this.accountId}, categoryId: ${_this.categoryId}, personName: ${_this.personName}, type: ${_this.type}, amount: ${_this.amount}, status: ${_this.status}, dueDate: ${_this.dueDate}, note: ${_this.note}, isSaving: ${_this.isSaving}, isSuccess: ${_this.isSuccess}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $DebtFormStateCopyWith<$Res>  {
  factory $DebtFormStateCopyWith(DebtFormState value, $Res Function(DebtFormState) _then) = _$DebtFormStateCopyWithImpl;
@useResult
$Res call({
 DebtModel? initialDebt, String accountId, String categoryId, String personName, DebtType type, int amount, DebtStatus status, DateTime? dueDate, String? note, bool isSaving, bool isSuccess, String? error
});


$DebtModelCopyWith<$Res>? get initialDebt;

}
/// @nodoc
class _$DebtFormStateCopyWithImpl<$Res>
    implements $DebtFormStateCopyWith<$Res> {
  _$DebtFormStateCopyWithImpl(this._self, this._then);

  final DebtFormState _self;
  final $Res Function(DebtFormState) _then;

/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialDebt = freezed,Object? accountId = null,Object? categoryId = null,Object? personName = null,Object? type = null,Object? amount = null,Object? status = null,Object? dueDate = freezed,Object? note = freezed,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(DebtFormState(
initialDebt: freezed == initialDebt ? _self.initialDebt : initialDebt // ignore: cast_nullable_to_non_nullable
as DebtModel?,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,personName: null == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DebtType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtStatus,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebtModelCopyWith<$Res>? get initialDebt {
    if (_self.initialDebt == null) {
    return null;
  }

  return $DebtModelCopyWith<$Res>(_self.initialDebt!, (value) {
    return _then(_self.copyWith(initialDebt: value));
  });
}
}


/// Adds pattern-matching-related methods to [DebtFormState].
extension DebtFormStatePatterns on DebtFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtFormState value)  $default,){
final _that = this;
switch (_that) {
case _DebtFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtFormState value)?  $default,){
final _that = this;
switch (_that) {
case _DebtFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DebtModel? initialDebt,  String accountId,  String categoryId,  String personName,  DebtType type,  int amount,  DebtStatus status,  DateTime? dueDate,  String? note,  bool isSaving,  bool isSuccess,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtFormState() when $default != null:
return $default(_that.initialDebt,_that.accountId,_that.categoryId,_that.personName,_that.type,_that.amount,_that.status,_that.dueDate,_that.note,_that.isSaving,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DebtModel? initialDebt,  String accountId,  String categoryId,  String personName,  DebtType type,  int amount,  DebtStatus status,  DateTime? dueDate,  String? note,  bool isSaving,  bool isSuccess,  String? error)  $default,) {final _that = this;
switch (_that) {
case _DebtFormState():
return $default(_that.initialDebt,_that.accountId,_that.categoryId,_that.personName,_that.type,_that.amount,_that.status,_that.dueDate,_that.note,_that.isSaving,_that.isSuccess,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DebtModel? initialDebt,  String accountId,  String categoryId,  String personName,  DebtType type,  int amount,  DebtStatus status,  DateTime? dueDate,  String? note,  bool isSaving,  bool isSuccess,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _DebtFormState() when $default != null:
return $default(_that.initialDebt,_that.accountId,_that.categoryId,_that.personName,_that.type,_that.amount,_that.status,_that.dueDate,_that.note,_that.isSaving,_that.isSuccess,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _DebtFormState implements DebtFormState {
  const _DebtFormState({this.initialDebt, this.accountId = '', this.categoryId = '', this.personName = '', this.type = DebtType.debt, this.amount = 0, this.status = DebtStatus.active, this.dueDate, this.note, this.isSaving = false, this.isSuccess = false, this.error});
  

@override final  DebtModel? initialDebt;
@override@JsonKey() final  String accountId;
@override@JsonKey() final  String categoryId;
@override@JsonKey() final  String personName;
@override@JsonKey() final  DebtType type;
@override@JsonKey() final  int amount;
@override@JsonKey() final  DebtStatus status;
@override final  DateTime? dueDate;
@override final  String? note;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSuccess;
@override final  String? error;

/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtFormStateCopyWith<_DebtFormState> get copyWith => __$DebtFormStateCopyWithImpl<_DebtFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtFormState&&(identical(other.initialDebt, initialDebt) || other.initialDebt == initialDebt)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.personName, personName) || other.personName == personName)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.note, note) || other.note == note)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,initialDebt,accountId,categoryId,personName,type,amount,status,dueDate,note,isSaving,isSuccess,error);
}

@override
String toString() {
    return 'DebtFormState(initialDebt: $initialDebt, accountId: $accountId, categoryId: $categoryId, personName: $personName, type: $type, amount: $amount, status: $status, dueDate: $dueDate, note: $note, isSaving: $isSaving, isSuccess: $isSuccess, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DebtFormStateCopyWith<$Res> implements $DebtFormStateCopyWith<$Res> {
  factory _$DebtFormStateCopyWith(_DebtFormState value, $Res Function(_DebtFormState) _then) = __$DebtFormStateCopyWithImpl;
@override @useResult
$Res call({
 DebtModel? initialDebt, String accountId, String categoryId, String personName, DebtType type, int amount, DebtStatus status, DateTime? dueDate, String? note, bool isSaving, bool isSuccess, String? error
});


@override $DebtModelCopyWith<$Res>? get initialDebt;

}
/// @nodoc
class __$DebtFormStateCopyWithImpl<$Res>
    implements _$DebtFormStateCopyWith<$Res> {
  __$DebtFormStateCopyWithImpl(this._self, this._then);

  final _DebtFormState _self;
  final $Res Function(_DebtFormState) _then;

/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialDebt = freezed,Object? accountId = null,Object? categoryId = null,Object? personName = null,Object? type = null,Object? amount = null,Object? status = null,Object? dueDate = freezed,Object? note = freezed,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,}) {
  return _then(_DebtFormState(
initialDebt: freezed == initialDebt ? _self.initialDebt : initialDebt // ignore: cast_nullable_to_non_nullable
as DebtModel?,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,personName: null == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DebtType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtStatus,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DebtFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebtModelCopyWith<$Res>? get initialDebt {
    if (_self.initialDebt == null) {
    return null;
  }

  return $DebtModelCopyWith<$Res>(_self.initialDebt!, (value) {
    return _then(_self.copyWith(initialDebt: value));
  });
}
}

// dart format on
