// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'split_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SplitItem {

/// Amount in smallest integer currency unit (e.g. cents/rupiah).
 int get amount;/// Optional ID for editing an existing saved item.
 String? get id;/// Category ID (nullable — user may not have selected one yet).
 String? get categoryId;/// Category display name, resolved at creation time for fast rendering.
 String? get categoryName;/// Optional per-item note.
 String? get note;/// Optional 50/30/20 budget rule allocation tag.
 TransactionAllocation? get allocation;
/// Create a copy of SplitItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitItemCopyWith<SplitItem> get copyWith => _$SplitItemCopyWithImpl<SplitItem>(this as SplitItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SplitItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitItem&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.categoryName, _this.categoryName) || other.categoryName == _this.categoryName)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.allocation, _this.allocation) || other.allocation == _this.allocation));
}


@override
int get hashCode {
  final _this = this as SplitItem;
  return Object.hash(runtimeType,_this.amount,_this.id,_this.categoryId,_this.categoryName,_this.note,_this.allocation);
}

@override
String toString() {
  final _this = this as SplitItem;
  return 'SplitItem(amount: ${_this.amount}, id: ${_this.id}, categoryId: ${_this.categoryId}, categoryName: ${_this.categoryName}, note: ${_this.note}, allocation: ${_this.allocation})';
}


}

/// @nodoc
abstract mixin class $SplitItemCopyWith<$Res>  {
  factory $SplitItemCopyWith(SplitItem value, $Res Function(SplitItem) _then) = _$SplitItemCopyWithImpl;
@useResult
$Res call({
 int amount, String? id, String? categoryId, String? categoryName, String? note, TransactionAllocation? allocation
});




}
/// @nodoc
class _$SplitItemCopyWithImpl<$Res>
    implements $SplitItemCopyWith<$Res> {
  _$SplitItemCopyWithImpl(this._self, this._then);

  final SplitItem _self;
  final $Res Function(SplitItem) _then;

/// Create a copy of SplitItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? id = freezed,Object? categoryId = freezed,Object? categoryName = freezed,Object? note = freezed,Object? allocation = freezed,}) {
  return _then(SplitItem(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,allocation: freezed == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as TransactionAllocation?,
  ));
}

}


/// Adds pattern-matching-related methods to [SplitItem].
extension SplitItemPatterns on SplitItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SplitItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SplitItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SplitItem value)  $default,){
final _that = this;
switch (_that) {
case _SplitItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SplitItem value)?  $default,){
final _that = this;
switch (_that) {
case _SplitItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount,  String? id,  String? categoryId,  String? categoryName,  String? note,  TransactionAllocation? allocation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SplitItem() when $default != null:
return $default(_that.amount,_that.id,_that.categoryId,_that.categoryName,_that.note,_that.allocation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount,  String? id,  String? categoryId,  String? categoryName,  String? note,  TransactionAllocation? allocation)  $default,) {final _that = this;
switch (_that) {
case _SplitItem():
return $default(_that.amount,_that.id,_that.categoryId,_that.categoryName,_that.note,_that.allocation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount,  String? id,  String? categoryId,  String? categoryName,  String? note,  TransactionAllocation? allocation)?  $default,) {final _that = this;
switch (_that) {
case _SplitItem() when $default != null:
return $default(_that.amount,_that.id,_that.categoryId,_that.categoryName,_that.note,_that.allocation);case _:
  return null;

}
}

}

/// @nodoc


class _SplitItem implements SplitItem {
  const _SplitItem({required this.amount, this.id, this.categoryId, this.categoryName, this.note, this.allocation});
  

/// Amount in smallest integer currency unit (e.g. cents/rupiah).
@override final  int amount;
/// Optional ID for editing an existing saved item.
@override final  String? id;
/// Category ID (nullable — user may not have selected one yet).
@override final  String? categoryId;
/// Category display name, resolved at creation time for fast rendering.
@override final  String? categoryName;
/// Optional per-item note.
@override final  String? note;
/// Optional 50/30/20 budget rule allocation tag.
@override final  TransactionAllocation? allocation;

/// Create a copy of SplitItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplitItemCopyWith<_SplitItem> get copyWith => __$SplitItemCopyWithImpl<_SplitItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplitItem&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.note, note) || other.note == note)&&(identical(other.allocation, allocation) || other.allocation == allocation));
}


@override
int get hashCode {
    return Object.hash(runtimeType,amount,id,categoryId,categoryName,note,allocation);
}

@override
String toString() {
    return 'SplitItem(amount: $amount, id: $id, categoryId: $categoryId, categoryName: $categoryName, note: $note, allocation: $allocation)';
}


}

/// @nodoc
abstract mixin class _$SplitItemCopyWith<$Res> implements $SplitItemCopyWith<$Res> {
  factory _$SplitItemCopyWith(_SplitItem value, $Res Function(_SplitItem) _then) = __$SplitItemCopyWithImpl;
@override @useResult
$Res call({
 int amount, String? id, String? categoryId, String? categoryName, String? note, TransactionAllocation? allocation
});




}
/// @nodoc
class __$SplitItemCopyWithImpl<$Res>
    implements _$SplitItemCopyWith<$Res> {
  __$SplitItemCopyWithImpl(this._self, this._then);

  final _SplitItem _self;
  final $Res Function(_SplitItem) _then;

/// Create a copy of SplitItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? id = freezed,Object? categoryId = freezed,Object? categoryName = freezed,Object? note = freezed,Object? allocation = freezed,}) {
  return _then(_SplitItem(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,allocation: freezed == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as TransactionAllocation?,
  ));
}


}

// dart format on
