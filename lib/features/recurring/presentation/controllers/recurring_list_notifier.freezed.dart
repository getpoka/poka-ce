// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_list_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringListState {

 List<RecurringTransactionModel> get recurrings; bool get isLoading; String? get error;
/// Create a copy of RecurringListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringListStateCopyWith<RecurringListState> get copyWith => _$RecurringListStateCopyWithImpl<RecurringListState>(this as RecurringListState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecurringListState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringListState&&const DeepCollectionEquality().equals(other.recurrings, _this.recurrings)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as RecurringListState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.recurrings),_this.isLoading,_this.error);
}

@override
String toString() {
  final _this = this as RecurringListState;
  return 'RecurringListState(recurrings: ${_this.recurrings}, isLoading: ${_this.isLoading}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $RecurringListStateCopyWith<$Res>  {
  factory $RecurringListStateCopyWith(RecurringListState value, $Res Function(RecurringListState) _then) = _$RecurringListStateCopyWithImpl;
@useResult
$Res call({
 List<RecurringTransactionModel> recurrings, bool isLoading, String? error
});




}
/// @nodoc
class _$RecurringListStateCopyWithImpl<$Res>
    implements $RecurringListStateCopyWith<$Res> {
  _$RecurringListStateCopyWithImpl(this._self, this._then);

  final RecurringListState _self;
  final $Res Function(RecurringListState) _then;

/// Create a copy of RecurringListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recurrings = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(RecurringListState(
recurrings: null == recurrings ? _self.recurrings : recurrings // ignore: cast_nullable_to_non_nullable
as List<RecurringTransactionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringListState].
extension RecurringListStatePatterns on RecurringListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringListState value)  $default,){
final _that = this;
switch (_that) {
case _RecurringListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringListState value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RecurringTransactionModel> recurrings,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringListState() when $default != null:
return $default(_that.recurrings,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RecurringTransactionModel> recurrings,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _RecurringListState():
return $default(_that.recurrings,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RecurringTransactionModel> recurrings,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _RecurringListState() when $default != null:
return $default(_that.recurrings,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringListState implements RecurringListState {
  const _RecurringListState({ List<RecurringTransactionModel> recurrings = const [], this.isLoading = false, this.error}): _recurrings = recurrings;
  

 final  List<RecurringTransactionModel> _recurrings;
@override@JsonKey() List<RecurringTransactionModel> get recurrings {
  if (_recurrings is EqualUnmodifiableListView) return _recurrings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recurrings);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of RecurringListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringListStateCopyWith<_RecurringListState> get copyWith => __$RecurringListStateCopyWithImpl<_RecurringListState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringListState&&const DeepCollectionEquality().equals(other.recurrings, _recurrings)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_recurrings),isLoading,error);
}

@override
String toString() {
    return 'RecurringListState(recurrings: $recurrings, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RecurringListStateCopyWith<$Res> implements $RecurringListStateCopyWith<$Res> {
  factory _$RecurringListStateCopyWith(_RecurringListState value, $Res Function(_RecurringListState) _then) = __$RecurringListStateCopyWithImpl;
@override @useResult
$Res call({
 List<RecurringTransactionModel> recurrings, bool isLoading, String? error
});




}
/// @nodoc
class __$RecurringListStateCopyWithImpl<$Res>
    implements _$RecurringListStateCopyWith<$Res> {
  __$RecurringListStateCopyWithImpl(this._self, this._then);

  final _RecurringListState _self;
  final $Res Function(_RecurringListState) _then;

/// Create a copy of RecurringListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recurrings = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_RecurringListState(
recurrings: null == recurrings ? _self._recurrings : recurrings // ignore: cast_nullable_to_non_nullable
as List<RecurringTransactionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
