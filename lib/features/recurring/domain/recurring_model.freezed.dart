// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecurringTransactionModel {

 String get id; String get accountId; TransactionType get type; int get amount; RecurringPeriod get period; DateTime get nextDate; DateTime get createdAt; DateTime get updatedAt; String? get destinationAccountId; String? get categoryId; TransactionAllocation? get allocation; String? get note; bool get isActive;
/// Create a copy of RecurringTransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringTransactionModelCopyWith<RecurringTransactionModel> get copyWith => _$RecurringTransactionModelCopyWithImpl<RecurringTransactionModel>(this as RecurringTransactionModel, _$identity);

  /// Serializes this RecurringTransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RecurringTransactionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringTransactionModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.nextDate, _this.nextDate) || other.nextDate == _this.nextDate)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.destinationAccountId, _this.destinationAccountId) || other.destinationAccountId == _this.destinationAccountId)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.allocation, _this.allocation) || other.allocation == _this.allocation)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RecurringTransactionModel;
  return Object.hash(runtimeType,_this.id,_this.accountId,_this.type,_this.amount,_this.period,_this.nextDate,_this.createdAt,_this.updatedAt,_this.destinationAccountId,_this.categoryId,_this.allocation,_this.note,_this.isActive);
}

@override
String toString() {
  final _this = this as RecurringTransactionModel;
  return 'RecurringTransactionModel(id: ${_this.id}, accountId: ${_this.accountId}, type: ${_this.type}, amount: ${_this.amount}, period: ${_this.period}, nextDate: ${_this.nextDate}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, destinationAccountId: ${_this.destinationAccountId}, categoryId: ${_this.categoryId}, allocation: ${_this.allocation}, note: ${_this.note}, isActive: ${_this.isActive})';
}


}

/// @nodoc
abstract mixin class $RecurringTransactionModelCopyWith<$Res>  {
  factory $RecurringTransactionModelCopyWith(RecurringTransactionModel value, $Res Function(RecurringTransactionModel) _then) = _$RecurringTransactionModelCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, TransactionType type, int amount, RecurringPeriod period, DateTime nextDate, DateTime createdAt, DateTime updatedAt, String? destinationAccountId, String? categoryId, TransactionAllocation? allocation, String? note, bool isActive
});




}
/// @nodoc
class _$RecurringTransactionModelCopyWithImpl<$Res>
    implements $RecurringTransactionModelCopyWith<$Res> {
  _$RecurringTransactionModelCopyWithImpl(this._self, this._then);

  final RecurringTransactionModel _self;
  final $Res Function(RecurringTransactionModel) _then;

/// Create a copy of RecurringTransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? type = null,Object? amount = null,Object? period = null,Object? nextDate = null,Object? createdAt = null,Object? updatedAt = null,Object? destinationAccountId = freezed,Object? categoryId = freezed,Object? allocation = freezed,Object? note = freezed,Object? isActive = null,}) {
  return _then(RecurringTransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as RecurringPeriod,nextDate: null == nextDate ? _self.nextDate : nextDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,destinationAccountId: freezed == destinationAccountId ? _self.destinationAccountId : destinationAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,allocation: freezed == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as TransactionAllocation?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringTransactionModel].
extension RecurringTransactionModelPatterns on RecurringTransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringTransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringTransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringTransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _RecurringTransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringTransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringTransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  TransactionType type,  int amount,  RecurringPeriod period,  DateTime nextDate,  DateTime createdAt,  DateTime updatedAt,  String? destinationAccountId,  String? categoryId,  TransactionAllocation? allocation,  String? note,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringTransactionModel() when $default != null:
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.period,_that.nextDate,_that.createdAt,_that.updatedAt,_that.destinationAccountId,_that.categoryId,_that.allocation,_that.note,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  TransactionType type,  int amount,  RecurringPeriod period,  DateTime nextDate,  DateTime createdAt,  DateTime updatedAt,  String? destinationAccountId,  String? categoryId,  TransactionAllocation? allocation,  String? note,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _RecurringTransactionModel():
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.period,_that.nextDate,_that.createdAt,_that.updatedAt,_that.destinationAccountId,_that.categoryId,_that.allocation,_that.note,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  TransactionType type,  int amount,  RecurringPeriod period,  DateTime nextDate,  DateTime createdAt,  DateTime updatedAt,  String? destinationAccountId,  String? categoryId,  TransactionAllocation? allocation,  String? note,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _RecurringTransactionModel() when $default != null:
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.period,_that.nextDate,_that.createdAt,_that.updatedAt,_that.destinationAccountId,_that.categoryId,_that.allocation,_that.note,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecurringTransactionModel implements RecurringTransactionModel {
  const _RecurringTransactionModel({required this.id, required this.accountId, required this.type, required this.amount, required this.period, required this.nextDate, required this.createdAt, required this.updatedAt, this.destinationAccountId, this.categoryId, this.allocation, this.note, this.isActive = true});
  factory _RecurringTransactionModel.fromJson(Map<String, dynamic> json) => _$RecurringTransactionModelFromJson(json);

@override final  String id;
@override final  String accountId;
@override final  TransactionType type;
@override final  int amount;
@override final  RecurringPeriod period;
@override final  DateTime nextDate;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? destinationAccountId;
@override final  String? categoryId;
@override final  TransactionAllocation? allocation;
@override final  String? note;
@override@JsonKey() final  bool isActive;

/// Create a copy of RecurringTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringTransactionModelCopyWith<_RecurringTransactionModel> get copyWith => __$RecurringTransactionModelCopyWithImpl<_RecurringTransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecurringTransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.period, period) || other.period == period)&&(identical(other.nextDate, nextDate) || other.nextDate == nextDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.destinationAccountId, destinationAccountId) || other.destinationAccountId == destinationAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.allocation, allocation) || other.allocation == allocation)&&(identical(other.note, note) || other.note == note)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,accountId,type,amount,period,nextDate,createdAt,updatedAt,destinationAccountId,categoryId,allocation,note,isActive);
}

@override
String toString() {
    return 'RecurringTransactionModel(id: $id, accountId: $accountId, type: $type, amount: $amount, period: $period, nextDate: $nextDate, createdAt: $createdAt, updatedAt: $updatedAt, destinationAccountId: $destinationAccountId, categoryId: $categoryId, allocation: $allocation, note: $note, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$RecurringTransactionModelCopyWith<$Res> implements $RecurringTransactionModelCopyWith<$Res> {
  factory _$RecurringTransactionModelCopyWith(_RecurringTransactionModel value, $Res Function(_RecurringTransactionModel) _then) = __$RecurringTransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, TransactionType type, int amount, RecurringPeriod period, DateTime nextDate, DateTime createdAt, DateTime updatedAt, String? destinationAccountId, String? categoryId, TransactionAllocation? allocation, String? note, bool isActive
});




}
/// @nodoc
class __$RecurringTransactionModelCopyWithImpl<$Res>
    implements _$RecurringTransactionModelCopyWith<$Res> {
  __$RecurringTransactionModelCopyWithImpl(this._self, this._then);

  final _RecurringTransactionModel _self;
  final $Res Function(_RecurringTransactionModel) _then;

/// Create a copy of RecurringTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? type = null,Object? amount = null,Object? period = null,Object? nextDate = null,Object? createdAt = null,Object? updatedAt = null,Object? destinationAccountId = freezed,Object? categoryId = freezed,Object? allocation = freezed,Object? note = freezed,Object? isActive = null,}) {
  return _then(_RecurringTransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as RecurringPeriod,nextDate: null == nextDate ? _self.nextDate : nextDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,destinationAccountId: freezed == destinationAccountId ? _self.destinationAccountId : destinationAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,allocation: freezed == allocation ? _self.allocation : allocation // ignore: cast_nullable_to_non_nullable
as TransactionAllocation?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
