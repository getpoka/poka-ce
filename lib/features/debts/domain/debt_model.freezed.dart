// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DebtModel {

 String get id; String get personName; DebtType get type; int get amount; int get remainingAmount; DebtStatus get status; DateTime get createdAt; DateTime get updatedAt; DateTime? get dueDate; String? get note;
/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtModelCopyWith<DebtModel> get copyWith => _$DebtModelCopyWithImpl<DebtModel>(this as DebtModel, _$identity);

  /// Serializes this DebtModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DebtModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.personName, _this.personName) || other.personName == _this.personName)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.remainingAmount, _this.remainingAmount) || other.remainingAmount == _this.remainingAmount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DebtModel;
  return Object.hash(runtimeType,_this.id,_this.personName,_this.type,_this.amount,_this.remainingAmount,_this.status,_this.createdAt,_this.updatedAt,_this.dueDate,_this.note);
}

@override
String toString() {
  final _this = this as DebtModel;
  return 'DebtModel(id: ${_this.id}, personName: ${_this.personName}, type: ${_this.type}, amount: ${_this.amount}, remainingAmount: ${_this.remainingAmount}, status: ${_this.status}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, dueDate: ${_this.dueDate}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $DebtModelCopyWith<$Res>  {
  factory $DebtModelCopyWith(DebtModel value, $Res Function(DebtModel) _then) = _$DebtModelCopyWithImpl;
@useResult
$Res call({
 String id, String personName, DebtType type, int amount, int remainingAmount, DebtStatus status, DateTime createdAt, DateTime updatedAt, DateTime? dueDate, String? note
});




}
/// @nodoc
class _$DebtModelCopyWithImpl<$Res>
    implements $DebtModelCopyWith<$Res> {
  _$DebtModelCopyWithImpl(this._self, this._then);

  final DebtModel _self;
  final $Res Function(DebtModel) _then;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? personName = null,Object? type = null,Object? amount = null,Object? remainingAmount = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? dueDate = freezed,Object? note = freezed,}) {
  return _then(DebtModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,personName: null == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DebtType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DebtModel].
extension DebtModelPatterns on DebtModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtModel value)  $default,){
final _that = this;
switch (_that) {
case _DebtModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtModel value)?  $default,){
final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String personName,  DebtType type,  int amount,  int remainingAmount,  DebtStatus status,  DateTime createdAt,  DateTime updatedAt,  DateTime? dueDate,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
return $default(_that.id,_that.personName,_that.type,_that.amount,_that.remainingAmount,_that.status,_that.createdAt,_that.updatedAt,_that.dueDate,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String personName,  DebtType type,  int amount,  int remainingAmount,  DebtStatus status,  DateTime createdAt,  DateTime updatedAt,  DateTime? dueDate,  String? note)  $default,) {final _that = this;
switch (_that) {
case _DebtModel():
return $default(_that.id,_that.personName,_that.type,_that.amount,_that.remainingAmount,_that.status,_that.createdAt,_that.updatedAt,_that.dueDate,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String personName,  DebtType type,  int amount,  int remainingAmount,  DebtStatus status,  DateTime createdAt,  DateTime updatedAt,  DateTime? dueDate,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
return $default(_that.id,_that.personName,_that.type,_that.amount,_that.remainingAmount,_that.status,_that.createdAt,_that.updatedAt,_that.dueDate,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DebtModel implements DebtModel {
  const _DebtModel({required this.id, required this.personName, required this.type, required this.amount, required this.remainingAmount, required this.status, required this.createdAt, required this.updatedAt, this.dueDate, this.note});
  factory _DebtModel.fromJson(Map<String, dynamic> json) => _$DebtModelFromJson(json);

@override final  String id;
@override final  String personName;
@override final  DebtType type;
@override final  int amount;
@override final  int remainingAmount;
@override final  DebtStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? dueDate;
@override final  String? note;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtModelCopyWith<_DebtModel> get copyWith => __$DebtModelCopyWithImpl<_DebtModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebtModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.personName, personName) || other.personName == personName)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,personName,type,amount,remainingAmount,status,createdAt,updatedAt,dueDate,note);
}

@override
String toString() {
    return 'DebtModel(id: $id, personName: $personName, type: $type, amount: $amount, remainingAmount: $remainingAmount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, dueDate: $dueDate, note: $note)';
}


}

/// @nodoc
abstract mixin class _$DebtModelCopyWith<$Res> implements $DebtModelCopyWith<$Res> {
  factory _$DebtModelCopyWith(_DebtModel value, $Res Function(_DebtModel) _then) = __$DebtModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String personName, DebtType type, int amount, int remainingAmount, DebtStatus status, DateTime createdAt, DateTime updatedAt, DateTime? dueDate, String? note
});




}
/// @nodoc
class __$DebtModelCopyWithImpl<$Res>
    implements _$DebtModelCopyWith<$Res> {
  __$DebtModelCopyWithImpl(this._self, this._then);

  final _DebtModel _self;
  final $Res Function(_DebtModel) _then;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? personName = null,Object? type = null,Object? amount = null,Object? remainingAmount = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? dueDate = freezed,Object? note = freezed,}) {
  return _then(_DebtModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,personName: null == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DebtType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
