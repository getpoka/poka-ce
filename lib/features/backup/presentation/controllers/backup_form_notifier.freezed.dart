// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupFormState {

 String? get passwordError; String? get confirmError; bool get isSubmitting;
/// Create a copy of BackupFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupFormStateCopyWith<BackupFormState> get copyWith => _$BackupFormStateCopyWithImpl<BackupFormState>(this as BackupFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BackupFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupFormState&&(identical(other.passwordError, _this.passwordError) || other.passwordError == _this.passwordError)&&(identical(other.confirmError, _this.confirmError) || other.confirmError == _this.confirmError)&&(identical(other.isSubmitting, _this.isSubmitting) || other.isSubmitting == _this.isSubmitting));
}


@override
int get hashCode {
  final _this = this as BackupFormState;
  return Object.hash(runtimeType,_this.passwordError,_this.confirmError,_this.isSubmitting);
}

@override
String toString() {
  final _this = this as BackupFormState;
  return 'BackupFormState(passwordError: ${_this.passwordError}, confirmError: ${_this.confirmError}, isSubmitting: ${_this.isSubmitting})';
}


}

/// @nodoc
abstract mixin class $BackupFormStateCopyWith<$Res>  {
  factory $BackupFormStateCopyWith(BackupFormState value, $Res Function(BackupFormState) _then) = _$BackupFormStateCopyWithImpl;
@useResult
$Res call({
 String? passwordError, String? confirmError, bool isSubmitting
});




}
/// @nodoc
class _$BackupFormStateCopyWithImpl<$Res>
    implements $BackupFormStateCopyWith<$Res> {
  _$BackupFormStateCopyWithImpl(this._self, this._then);

  final BackupFormState _self;
  final $Res Function(BackupFormState) _then;

/// Create a copy of BackupFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? passwordError = freezed,Object? confirmError = freezed,Object? isSubmitting = null,}) {
  return _then(BackupFormState(
passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmError: freezed == confirmError ? _self.confirmError : confirmError // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupFormState].
extension BackupFormStatePatterns on BackupFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupFormState value)  $default,){
final _that = this;
switch (_that) {
case _BackupFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupFormState value)?  $default,){
final _that = this;
switch (_that) {
case _BackupFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? passwordError,  String? confirmError,  bool isSubmitting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupFormState() when $default != null:
return $default(_that.passwordError,_that.confirmError,_that.isSubmitting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? passwordError,  String? confirmError,  bool isSubmitting)  $default,) {final _that = this;
switch (_that) {
case _BackupFormState():
return $default(_that.passwordError,_that.confirmError,_that.isSubmitting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? passwordError,  String? confirmError,  bool isSubmitting)?  $default,) {final _that = this;
switch (_that) {
case _BackupFormState() when $default != null:
return $default(_that.passwordError,_that.confirmError,_that.isSubmitting);case _:
  return null;

}
}

}

/// @nodoc


class _BackupFormState implements BackupFormState {
  const _BackupFormState({this.passwordError, this.confirmError, this.isSubmitting = false});
  

@override final  String? passwordError;
@override final  String? confirmError;
@override@JsonKey() final  bool isSubmitting;

/// Create a copy of BackupFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupFormStateCopyWith<_BackupFormState> get copyWith => __$BackupFormStateCopyWithImpl<_BackupFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupFormState&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmError, confirmError) || other.confirmError == confirmError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode {
    return Object.hash(runtimeType,passwordError,confirmError,isSubmitting);
}

@override
String toString() {
    return 'BackupFormState(passwordError: $passwordError, confirmError: $confirmError, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class _$BackupFormStateCopyWith<$Res> implements $BackupFormStateCopyWith<$Res> {
  factory _$BackupFormStateCopyWith(_BackupFormState value, $Res Function(_BackupFormState) _then) = __$BackupFormStateCopyWithImpl;
@override @useResult
$Res call({
 String? passwordError, String? confirmError, bool isSubmitting
});




}
/// @nodoc
class __$BackupFormStateCopyWithImpl<$Res>
    implements _$BackupFormStateCopyWith<$Res> {
  __$BackupFormStateCopyWithImpl(this._self, this._then);

  final _BackupFormState _self;
  final $Res Function(_BackupFormState) _then;

/// Create a copy of BackupFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? passwordError = freezed,Object? confirmError = freezed,Object? isSubmitting = null,}) {
  return _then(_BackupFormState(
passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmError: freezed == confirmError ? _self.confirmError : confirmError // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
