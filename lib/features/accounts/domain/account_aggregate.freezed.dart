// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_aggregate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountAggregate {

 AccountModel get account; List<AccountModel> get pockets;
/// Create a copy of AccountAggregate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountAggregateCopyWith<AccountAggregate> get copyWith => _$AccountAggregateCopyWithImpl<AccountAggregate>(this as AccountAggregate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountAggregate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountAggregate&&(identical(other.account, _this.account) || other.account == _this.account)&&const DeepCollectionEquality().equals(other.pockets, _this.pockets));
}


@override
int get hashCode {
  final _this = this as AccountAggregate;
  return Object.hash(runtimeType,_this.account,const DeepCollectionEquality().hash(_this.pockets));
}

@override
String toString() {
  final _this = this as AccountAggregate;
  return 'AccountAggregate(account: ${_this.account}, pockets: ${_this.pockets})';
}


}

/// @nodoc
abstract mixin class $AccountAggregateCopyWith<$Res>  {
  factory $AccountAggregateCopyWith(AccountAggregate value, $Res Function(AccountAggregate) _then) = _$AccountAggregateCopyWithImpl;
@useResult
$Res call({
 AccountModel account, List<AccountModel> pockets
});


$AccountModelCopyWith<$Res> get account;

}
/// @nodoc
class _$AccountAggregateCopyWithImpl<$Res>
    implements $AccountAggregateCopyWith<$Res> {
  _$AccountAggregateCopyWithImpl(this._self, this._then);

  final AccountAggregate _self;
  final $Res Function(AccountAggregate) _then;

/// Create a copy of AccountAggregate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? pockets = null,}) {
  return _then(AccountAggregate(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountModel,pockets: null == pockets ? _self.pockets : pockets // ignore: cast_nullable_to_non_nullable
as List<AccountModel>,
  ));
}
/// Create a copy of AccountAggregate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountModelCopyWith<$Res> get account {
  
  return $AccountModelCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountAggregate].
extension AccountAggregatePatterns on AccountAggregate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountAggregate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountAggregate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountAggregate value)  $default,){
final _that = this;
switch (_that) {
case _AccountAggregate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountAggregate value)?  $default,){
final _that = this;
switch (_that) {
case _AccountAggregate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountModel account,  List<AccountModel> pockets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountAggregate() when $default != null:
return $default(_that.account,_that.pockets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountModel account,  List<AccountModel> pockets)  $default,) {final _that = this;
switch (_that) {
case _AccountAggregate():
return $default(_that.account,_that.pockets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountModel account,  List<AccountModel> pockets)?  $default,) {final _that = this;
switch (_that) {
case _AccountAggregate() when $default != null:
return $default(_that.account,_that.pockets);case _:
  return null;

}
}

}

/// @nodoc


class _AccountAggregate extends AccountAggregate {
  const _AccountAggregate({required this.account,  List<AccountModel> pockets = const []}): _pockets = pockets,super._();
  

@override final  AccountModel account;
 final  List<AccountModel> _pockets;
@override@JsonKey() List<AccountModel> get pockets {
  if (_pockets is EqualUnmodifiableListView) return _pockets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pockets);
}


/// Create a copy of AccountAggregate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountAggregateCopyWith<_AccountAggregate> get copyWith => __$AccountAggregateCopyWithImpl<_AccountAggregate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountAggregate&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.pockets, _pockets));
}


@override
int get hashCode {
    return Object.hash(runtimeType,account,const DeepCollectionEquality().hash(_pockets));
}

@override
String toString() {
    return 'AccountAggregate(account: $account, pockets: $pockets)';
}


}

/// @nodoc
abstract mixin class _$AccountAggregateCopyWith<$Res> implements $AccountAggregateCopyWith<$Res> {
  factory _$AccountAggregateCopyWith(_AccountAggregate value, $Res Function(_AccountAggregate) _then) = __$AccountAggregateCopyWithImpl;
@override @useResult
$Res call({
 AccountModel account, List<AccountModel> pockets
});


@override $AccountModelCopyWith<$Res> get account;

}
/// @nodoc
class __$AccountAggregateCopyWithImpl<$Res>
    implements _$AccountAggregateCopyWith<$Res> {
  __$AccountAggregateCopyWithImpl(this._self, this._then);

  final _AccountAggregate _self;
  final $Res Function(_AccountAggregate) _then;

/// Create a copy of AccountAggregate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? pockets = null,}) {
  return _then(_AccountAggregate(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountModel,pockets: null == pockets ? _self._pockets : pockets // ignore: cast_nullable_to_non_nullable
as List<AccountModel>,
  ));
}

/// Create a copy of AccountAggregate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountModelCopyWith<$Res> get account {
  
  return $AccountModelCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
