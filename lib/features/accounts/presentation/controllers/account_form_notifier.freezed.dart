// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountFormState {

 AccountModel? get initialAccount; String get name; AccountType get type; int get balance; String? get icon; String? get color; String? get parentAccountId; bool get isActive; List<String> get restrictedCategoryIds; bool get isSaving; bool get isSuccess; String? get error; String? get nameError;
/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountFormStateCopyWith<AccountFormState> get copyWith => _$AccountFormStateCopyWithImpl<AccountFormState>(this as AccountFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountFormState&&(identical(other.initialAccount, _this.initialAccount) || other.initialAccount == _this.initialAccount)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.parentAccountId, _this.parentAccountId) || other.parentAccountId == _this.parentAccountId)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&const DeepCollectionEquality().equals(other.restrictedCategoryIds, _this.restrictedCategoryIds)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isSuccess, _this.isSuccess) || other.isSuccess == _this.isSuccess)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.nameError, _this.nameError) || other.nameError == _this.nameError));
}


@override
int get hashCode {
  final _this = this as AccountFormState;
  return Object.hash(runtimeType,_this.initialAccount,_this.name,_this.type,_this.balance,_this.icon,_this.color,_this.parentAccountId,_this.isActive,const DeepCollectionEquality().hash(_this.restrictedCategoryIds),_this.isSaving,_this.isSuccess,_this.error,_this.nameError);
}

@override
String toString() {
  final _this = this as AccountFormState;
  return 'AccountFormState(initialAccount: ${_this.initialAccount}, name: ${_this.name}, type: ${_this.type}, balance: ${_this.balance}, icon: ${_this.icon}, color: ${_this.color}, parentAccountId: ${_this.parentAccountId}, isActive: ${_this.isActive}, restrictedCategoryIds: ${_this.restrictedCategoryIds}, isSaving: ${_this.isSaving}, isSuccess: ${_this.isSuccess}, error: ${_this.error}, nameError: ${_this.nameError})';
}


}

/// @nodoc
abstract mixin class $AccountFormStateCopyWith<$Res>  {
  factory $AccountFormStateCopyWith(AccountFormState value, $Res Function(AccountFormState) _then) = _$AccountFormStateCopyWithImpl;
@useResult
$Res call({
 AccountModel? initialAccount, String name, AccountType type, int balance, String? icon, String? color, String? parentAccountId, bool isActive, List<String> restrictedCategoryIds, bool isSaving, bool isSuccess, String? error, String? nameError
});


$AccountModelCopyWith<$Res>? get initialAccount;

}
/// @nodoc
class _$AccountFormStateCopyWithImpl<$Res>
    implements $AccountFormStateCopyWith<$Res> {
  _$AccountFormStateCopyWithImpl(this._self, this._then);

  final AccountFormState _self;
  final $Res Function(AccountFormState) _then;

/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialAccount = freezed,Object? name = null,Object? type = null,Object? balance = null,Object? icon = freezed,Object? color = freezed,Object? parentAccountId = freezed,Object? isActive = null,Object? restrictedCategoryIds = null,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,Object? nameError = freezed,}) {
  return _then(AccountFormState(
initialAccount: freezed == initialAccount ? _self.initialAccount : initialAccount // ignore: cast_nullable_to_non_nullable
as AccountModel?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,parentAccountId: freezed == parentAccountId ? _self.parentAccountId : parentAccountId // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,restrictedCategoryIds: null == restrictedCategoryIds ? _self.restrictedCategoryIds : restrictedCategoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountModelCopyWith<$Res>? get initialAccount {
    if (_self.initialAccount == null) {
    return null;
  }

  return $AccountModelCopyWith<$Res>(_self.initialAccount!, (value) {
    return _then(_self.copyWith(initialAccount: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountFormState].
extension AccountFormStatePatterns on AccountFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountFormState value)  $default,){
final _that = this;
switch (_that) {
case _AccountFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountFormState value)?  $default,){
final _that = this;
switch (_that) {
case _AccountFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountModel? initialAccount,  String name,  AccountType type,  int balance,  String? icon,  String? color,  String? parentAccountId,  bool isActive,  List<String> restrictedCategoryIds,  bool isSaving,  bool isSuccess,  String? error,  String? nameError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountFormState() when $default != null:
return $default(_that.initialAccount,_that.name,_that.type,_that.balance,_that.icon,_that.color,_that.parentAccountId,_that.isActive,_that.restrictedCategoryIds,_that.isSaving,_that.isSuccess,_that.error,_that.nameError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountModel? initialAccount,  String name,  AccountType type,  int balance,  String? icon,  String? color,  String? parentAccountId,  bool isActive,  List<String> restrictedCategoryIds,  bool isSaving,  bool isSuccess,  String? error,  String? nameError)  $default,) {final _that = this;
switch (_that) {
case _AccountFormState():
return $default(_that.initialAccount,_that.name,_that.type,_that.balance,_that.icon,_that.color,_that.parentAccountId,_that.isActive,_that.restrictedCategoryIds,_that.isSaving,_that.isSuccess,_that.error,_that.nameError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountModel? initialAccount,  String name,  AccountType type,  int balance,  String? icon,  String? color,  String? parentAccountId,  bool isActive,  List<String> restrictedCategoryIds,  bool isSaving,  bool isSuccess,  String? error,  String? nameError)?  $default,) {final _that = this;
switch (_that) {
case _AccountFormState() when $default != null:
return $default(_that.initialAccount,_that.name,_that.type,_that.balance,_that.icon,_that.color,_that.parentAccountId,_that.isActive,_that.restrictedCategoryIds,_that.isSaving,_that.isSuccess,_that.error,_that.nameError);case _:
  return null;

}
}

}

/// @nodoc


class _AccountFormState implements AccountFormState {
  const _AccountFormState({this.initialAccount, this.name = '', this.type = AccountType.assets, this.balance = 0, this.icon, this.color, this.parentAccountId, this.isActive = true,  List<String> restrictedCategoryIds = const [], this.isSaving = false, this.isSuccess = false, this.error, this.nameError}): _restrictedCategoryIds = restrictedCategoryIds;
  

@override final  AccountModel? initialAccount;
@override@JsonKey() final  String name;
@override@JsonKey() final  AccountType type;
@override@JsonKey() final  int balance;
@override final  String? icon;
@override final  String? color;
@override final  String? parentAccountId;
@override@JsonKey() final  bool isActive;
 final  List<String> _restrictedCategoryIds;
@override@JsonKey() List<String> get restrictedCategoryIds {
  if (_restrictedCategoryIds is EqualUnmodifiableListView) return _restrictedCategoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_restrictedCategoryIds);
}

@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSuccess;
@override final  String? error;
@override final  String? nameError;

/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountFormStateCopyWith<_AccountFormState> get copyWith => __$AccountFormStateCopyWithImpl<_AccountFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountFormState&&(identical(other.initialAccount, initialAccount) || other.initialAccount == initialAccount)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.parentAccountId, parentAccountId) || other.parentAccountId == parentAccountId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.restrictedCategoryIds, _restrictedCategoryIds)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error)&&(identical(other.nameError, nameError) || other.nameError == nameError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,initialAccount,name,type,balance,icon,color,parentAccountId,isActive,const DeepCollectionEquality().hash(_restrictedCategoryIds),isSaving,isSuccess,error,nameError);
}

@override
String toString() {
    return 'AccountFormState(initialAccount: $initialAccount, name: $name, type: $type, balance: $balance, icon: $icon, color: $color, parentAccountId: $parentAccountId, isActive: $isActive, restrictedCategoryIds: $restrictedCategoryIds, isSaving: $isSaving, isSuccess: $isSuccess, error: $error, nameError: $nameError)';
}


}

/// @nodoc
abstract mixin class _$AccountFormStateCopyWith<$Res> implements $AccountFormStateCopyWith<$Res> {
  factory _$AccountFormStateCopyWith(_AccountFormState value, $Res Function(_AccountFormState) _then) = __$AccountFormStateCopyWithImpl;
@override @useResult
$Res call({
 AccountModel? initialAccount, String name, AccountType type, int balance, String? icon, String? color, String? parentAccountId, bool isActive, List<String> restrictedCategoryIds, bool isSaving, bool isSuccess, String? error, String? nameError
});


@override $AccountModelCopyWith<$Res>? get initialAccount;

}
/// @nodoc
class __$AccountFormStateCopyWithImpl<$Res>
    implements _$AccountFormStateCopyWith<$Res> {
  __$AccountFormStateCopyWithImpl(this._self, this._then);

  final _AccountFormState _self;
  final $Res Function(_AccountFormState) _then;

/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialAccount = freezed,Object? name = null,Object? type = null,Object? balance = null,Object? icon = freezed,Object? color = freezed,Object? parentAccountId = freezed,Object? isActive = null,Object? restrictedCategoryIds = null,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,Object? nameError = freezed,}) {
  return _then(_AccountFormState(
initialAccount: freezed == initialAccount ? _self.initialAccount : initialAccount // ignore: cast_nullable_to_non_nullable
as AccountModel?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,parentAccountId: freezed == parentAccountId ? _self.parentAccountId : parentAccountId // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,restrictedCategoryIds: null == restrictedCategoryIds ? _self._restrictedCategoryIds : restrictedCategoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AccountFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountModelCopyWith<$Res>? get initialAccount {
    if (_self.initialAccount == null) {
    return null;
  }

  return $AccountModelCopyWith<$Res>(_self.initialAccount!, (value) {
    return _then(_self.copyWith(initialAccount: value));
  });
}
}

// dart format on
