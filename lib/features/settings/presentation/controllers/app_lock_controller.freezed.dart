// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_lock_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppLockState {

 bool get isEnabled; bool get isAuthenticated; bool get isBiometricEnabled;/// True while a biometric prompt is actively being shown to the user.
 bool get isBiometricActive;/// Timestamp until which PIN attempts are blocked after too many failures.
 DateTime? get lockoutUntil;
/// Create a copy of AppLockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLockStateCopyWith<AppLockState> get copyWith => _$AppLockStateCopyWithImpl<AppLockState>(this as AppLockState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppLockState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLockState&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled)&&(identical(other.isAuthenticated, _this.isAuthenticated) || other.isAuthenticated == _this.isAuthenticated)&&(identical(other.isBiometricEnabled, _this.isBiometricEnabled) || other.isBiometricEnabled == _this.isBiometricEnabled)&&(identical(other.isBiometricActive, _this.isBiometricActive) || other.isBiometricActive == _this.isBiometricActive)&&(identical(other.lockoutUntil, _this.lockoutUntil) || other.lockoutUntil == _this.lockoutUntil));
}


@override
int get hashCode {
  final _this = this as AppLockState;
  return Object.hash(runtimeType,_this.isEnabled,_this.isAuthenticated,_this.isBiometricEnabled,_this.isBiometricActive,_this.lockoutUntil);
}

@override
String toString() {
  final _this = this as AppLockState;
  return 'AppLockState(isEnabled: ${_this.isEnabled}, isAuthenticated: ${_this.isAuthenticated}, isBiometricEnabled: ${_this.isBiometricEnabled}, isBiometricActive: ${_this.isBiometricActive}, lockoutUntil: ${_this.lockoutUntil})';
}


}

/// @nodoc
abstract mixin class $AppLockStateCopyWith<$Res>  {
  factory $AppLockStateCopyWith(AppLockState value, $Res Function(AppLockState) _then) = _$AppLockStateCopyWithImpl;
@useResult
$Res call({
 bool isEnabled, bool isAuthenticated, bool isBiometricEnabled, bool isBiometricActive, DateTime? lockoutUntil
});




}
/// @nodoc
class _$AppLockStateCopyWithImpl<$Res>
    implements $AppLockStateCopyWith<$Res> {
  _$AppLockStateCopyWithImpl(this._self, this._then);

  final AppLockState _self;
  final $Res Function(AppLockState) _then;

/// Create a copy of AppLockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isEnabled = null,Object? isAuthenticated = null,Object? isBiometricEnabled = null,Object? isBiometricActive = null,Object? lockoutUntil = freezed,}) {
  return _then(AppLockState(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,isBiometricEnabled: null == isBiometricEnabled ? _self.isBiometricEnabled : isBiometricEnabled // ignore: cast_nullable_to_non_nullable
as bool,isBiometricActive: null == isBiometricActive ? _self.isBiometricActive : isBiometricActive // ignore: cast_nullable_to_non_nullable
as bool,lockoutUntil: freezed == lockoutUntil ? _self.lockoutUntil : lockoutUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppLockState].
extension AppLockStatePatterns on AppLockState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppLockState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppLockState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppLockState value)  $default,){
final _that = this;
switch (_that) {
case _AppLockState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppLockState value)?  $default,){
final _that = this;
switch (_that) {
case _AppLockState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isEnabled,  bool isAuthenticated,  bool isBiometricEnabled,  bool isBiometricActive,  DateTime? lockoutUntil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppLockState() when $default != null:
return $default(_that.isEnabled,_that.isAuthenticated,_that.isBiometricEnabled,_that.isBiometricActive,_that.lockoutUntil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isEnabled,  bool isAuthenticated,  bool isBiometricEnabled,  bool isBiometricActive,  DateTime? lockoutUntil)  $default,) {final _that = this;
switch (_that) {
case _AppLockState():
return $default(_that.isEnabled,_that.isAuthenticated,_that.isBiometricEnabled,_that.isBiometricActive,_that.lockoutUntil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isEnabled,  bool isAuthenticated,  bool isBiometricEnabled,  bool isBiometricActive,  DateTime? lockoutUntil)?  $default,) {final _that = this;
switch (_that) {
case _AppLockState() when $default != null:
return $default(_that.isEnabled,_that.isAuthenticated,_that.isBiometricEnabled,_that.isBiometricActive,_that.lockoutUntil);case _:
  return null;

}
}

}

/// @nodoc


class _AppLockState implements AppLockState {
  const _AppLockState({this.isEnabled = false, this.isAuthenticated = false, this.isBiometricEnabled = false, this.isBiometricActive = false, this.lockoutUntil});
  

@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  bool isAuthenticated;
@override@JsonKey() final  bool isBiometricEnabled;
/// True while a biometric prompt is actively being shown to the user.
@override@JsonKey() final  bool isBiometricActive;
/// Timestamp until which PIN attempts are blocked after too many failures.
@override final  DateTime? lockoutUntil;

/// Create a copy of AppLockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppLockStateCopyWith<_AppLockState> get copyWith => __$AppLockStateCopyWithImpl<_AppLockState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppLockState&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated)&&(identical(other.isBiometricEnabled, isBiometricEnabled) || other.isBiometricEnabled == isBiometricEnabled)&&(identical(other.isBiometricActive, isBiometricActive) || other.isBiometricActive == isBiometricActive)&&(identical(other.lockoutUntil, lockoutUntil) || other.lockoutUntil == lockoutUntil));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isEnabled,isAuthenticated,isBiometricEnabled,isBiometricActive,lockoutUntil);
}

@override
String toString() {
    return 'AppLockState(isEnabled: $isEnabled, isAuthenticated: $isAuthenticated, isBiometricEnabled: $isBiometricEnabled, isBiometricActive: $isBiometricActive, lockoutUntil: $lockoutUntil)';
}


}

/// @nodoc
abstract mixin class _$AppLockStateCopyWith<$Res> implements $AppLockStateCopyWith<$Res> {
  factory _$AppLockStateCopyWith(_AppLockState value, $Res Function(_AppLockState) _then) = __$AppLockStateCopyWithImpl;
@override @useResult
$Res call({
 bool isEnabled, bool isAuthenticated, bool isBiometricEnabled, bool isBiometricActive, DateTime? lockoutUntil
});




}
/// @nodoc
class __$AppLockStateCopyWithImpl<$Res>
    implements _$AppLockStateCopyWith<$Res> {
  __$AppLockStateCopyWithImpl(this._self, this._then);

  final _AppLockState _self;
  final $Res Function(_AppLockState) _then;

/// Create a copy of AppLockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isEnabled = null,Object? isAuthenticated = null,Object? isBiometricEnabled = null,Object? isBiometricActive = null,Object? lockoutUntil = freezed,}) {
  return _then(_AppLockState(
isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,isBiometricEnabled: null == isBiometricEnabled ? _self.isBiometricEnabled : isBiometricEnabled // ignore: cast_nullable_to_non_nullable
as bool,isBiometricActive: null == isBiometricActive ? _self.isBiometricActive : isBiometricActive // ignore: cast_nullable_to_non_nullable
as bool,lockoutUntil: freezed == lockoutUntil ? _self.lockoutUntil : lockoutUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
