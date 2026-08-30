// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BudgetModel {

 String get id; String get name; int get amount; BudgetPeriod get period; DateTime get startDate; DateTime get createdAt; DateTime get updatedAt; String? get categoryId; String? get accountId; int? get resetDay; int? get alertThreshold; DateTime? get endDate;
/// Create a copy of BudgetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetModelCopyWith<BudgetModel> get copyWith => _$BudgetModelCopyWithImpl<BudgetModel>(this as BudgetModel, _$identity);

  /// Serializes this BudgetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BudgetModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.resetDay, _this.resetDay) || other.resetDay == _this.resetDay)&&(identical(other.alertThreshold, _this.alertThreshold) || other.alertThreshold == _this.alertThreshold)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BudgetModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.amount,_this.period,_this.startDate,_this.createdAt,_this.updatedAt,_this.categoryId,_this.accountId,_this.resetDay,_this.alertThreshold,_this.endDate);
}

@override
String toString() {
  final _this = this as BudgetModel;
  return 'BudgetModel(id: ${_this.id}, name: ${_this.name}, amount: ${_this.amount}, period: ${_this.period}, startDate: ${_this.startDate}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, categoryId: ${_this.categoryId}, accountId: ${_this.accountId}, resetDay: ${_this.resetDay}, alertThreshold: ${_this.alertThreshold}, endDate: ${_this.endDate})';
}


}

/// @nodoc
abstract mixin class $BudgetModelCopyWith<$Res>  {
  factory $BudgetModelCopyWith(BudgetModel value, $Res Function(BudgetModel) _then) = _$BudgetModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, int amount, BudgetPeriod period, DateTime startDate, DateTime createdAt, DateTime updatedAt, String? categoryId, String? accountId, int? resetDay, int? alertThreshold, DateTime? endDate
});




}
/// @nodoc
class _$BudgetModelCopyWithImpl<$Res>
    implements $BudgetModelCopyWith<$Res> {
  _$BudgetModelCopyWithImpl(this._self, this._then);

  final BudgetModel _self;
  final $Res Function(BudgetModel) _then;

/// Create a copy of BudgetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? period = null,Object? startDate = null,Object? createdAt = null,Object? updatedAt = null,Object? categoryId = freezed,Object? accountId = freezed,Object? resetDay = freezed,Object? alertThreshold = freezed,Object? endDate = freezed,}) {
  return _then(BudgetModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as BudgetPeriod,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,resetDay: freezed == resetDay ? _self.resetDay : resetDay // ignore: cast_nullable_to_non_nullable
as int?,alertThreshold: freezed == alertThreshold ? _self.alertThreshold : alertThreshold // ignore: cast_nullable_to_non_nullable
as int?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetModel].
extension BudgetModelPatterns on BudgetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetModel value)  $default,){
final _that = this;
switch (_that) {
case _BudgetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetModel value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int amount,  BudgetPeriod period,  DateTime startDate,  DateTime createdAt,  DateTime updatedAt,  String? categoryId,  String? accountId,  int? resetDay,  int? alertThreshold,  DateTime? endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetModel() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.period,_that.startDate,_that.createdAt,_that.updatedAt,_that.categoryId,_that.accountId,_that.resetDay,_that.alertThreshold,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int amount,  BudgetPeriod period,  DateTime startDate,  DateTime createdAt,  DateTime updatedAt,  String? categoryId,  String? accountId,  int? resetDay,  int? alertThreshold,  DateTime? endDate)  $default,) {final _that = this;
switch (_that) {
case _BudgetModel():
return $default(_that.id,_that.name,_that.amount,_that.period,_that.startDate,_that.createdAt,_that.updatedAt,_that.categoryId,_that.accountId,_that.resetDay,_that.alertThreshold,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int amount,  BudgetPeriod period,  DateTime startDate,  DateTime createdAt,  DateTime updatedAt,  String? categoryId,  String? accountId,  int? resetDay,  int? alertThreshold,  DateTime? endDate)?  $default,) {final _that = this;
switch (_that) {
case _BudgetModel() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.period,_that.startDate,_that.createdAt,_that.updatedAt,_that.categoryId,_that.accountId,_that.resetDay,_that.alertThreshold,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetModel implements BudgetModel {
  const _BudgetModel({required this.id, required this.name, required this.amount, required this.period, required this.startDate, required this.createdAt, required this.updatedAt, this.categoryId, this.accountId, this.resetDay, this.alertThreshold, this.endDate});
  factory _BudgetModel.fromJson(Map<String, dynamic> json) => _$BudgetModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  int amount;
@override final  BudgetPeriod period;
@override final  DateTime startDate;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? categoryId;
@override final  String? accountId;
@override final  int? resetDay;
@override final  int? alertThreshold;
@override final  DateTime? endDate;

/// Create a copy of BudgetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetModelCopyWith<_BudgetModel> get copyWith => __$BudgetModelCopyWithImpl<_BudgetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.period, period) || other.period == period)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.resetDay, resetDay) || other.resetDay == resetDay)&&(identical(other.alertThreshold, alertThreshold) || other.alertThreshold == alertThreshold)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,amount,period,startDate,createdAt,updatedAt,categoryId,accountId,resetDay,alertThreshold,endDate);
}

@override
String toString() {
    return 'BudgetModel(id: $id, name: $name, amount: $amount, period: $period, startDate: $startDate, createdAt: $createdAt, updatedAt: $updatedAt, categoryId: $categoryId, accountId: $accountId, resetDay: $resetDay, alertThreshold: $alertThreshold, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$BudgetModelCopyWith<$Res> implements $BudgetModelCopyWith<$Res> {
  factory _$BudgetModelCopyWith(_BudgetModel value, $Res Function(_BudgetModel) _then) = __$BudgetModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int amount, BudgetPeriod period, DateTime startDate, DateTime createdAt, DateTime updatedAt, String? categoryId, String? accountId, int? resetDay, int? alertThreshold, DateTime? endDate
});




}
/// @nodoc
class __$BudgetModelCopyWithImpl<$Res>
    implements _$BudgetModelCopyWith<$Res> {
  __$BudgetModelCopyWithImpl(this._self, this._then);

  final _BudgetModel _self;
  final $Res Function(_BudgetModel) _then;

/// Create a copy of BudgetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? period = null,Object? startDate = null,Object? createdAt = null,Object? updatedAt = null,Object? categoryId = freezed,Object? accountId = freezed,Object? resetDay = freezed,Object? alertThreshold = freezed,Object? endDate = freezed,}) {
  return _then(_BudgetModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as BudgetPeriod,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,resetDay: freezed == resetDay ? _self.resetDay : resetDay // ignore: cast_nullable_to_non_nullable
as int?,alertThreshold: freezed == alertThreshold ? _self.alertThreshold : alertThreshold // ignore: cast_nullable_to_non_nullable
as int?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$BudgetRecordModel {

 String get id; String get budgetId; int get spentAmount; DateTime get periodStart; DateTime get periodEnd; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of BudgetRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetRecordModelCopyWith<BudgetRecordModel> get copyWith => _$BudgetRecordModelCopyWithImpl<BudgetRecordModel>(this as BudgetRecordModel, _$identity);

  /// Serializes this BudgetRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BudgetRecordModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetRecordModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.budgetId, _this.budgetId) || other.budgetId == _this.budgetId)&&(identical(other.spentAmount, _this.spentAmount) || other.spentAmount == _this.spentAmount)&&(identical(other.periodStart, _this.periodStart) || other.periodStart == _this.periodStart)&&(identical(other.periodEnd, _this.periodEnd) || other.periodEnd == _this.periodEnd)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BudgetRecordModel;
  return Object.hash(runtimeType,_this.id,_this.budgetId,_this.spentAmount,_this.periodStart,_this.periodEnd,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as BudgetRecordModel;
  return 'BudgetRecordModel(id: ${_this.id}, budgetId: ${_this.budgetId}, spentAmount: ${_this.spentAmount}, periodStart: ${_this.periodStart}, periodEnd: ${_this.periodEnd}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $BudgetRecordModelCopyWith<$Res>  {
  factory $BudgetRecordModelCopyWith(BudgetRecordModel value, $Res Function(BudgetRecordModel) _then) = _$BudgetRecordModelCopyWithImpl;
@useResult
$Res call({
 String id, String budgetId, int spentAmount, DateTime periodStart, DateTime periodEnd, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$BudgetRecordModelCopyWithImpl<$Res>
    implements $BudgetRecordModelCopyWith<$Res> {
  _$BudgetRecordModelCopyWithImpl(this._self, this._then);

  final BudgetRecordModel _self;
  final $Res Function(BudgetRecordModel) _then;

/// Create a copy of BudgetRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? budgetId = null,Object? spentAmount = null,Object? periodStart = null,Object? periodEnd = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(BudgetRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,budgetId: null == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as String,spentAmount: null == spentAmount ? _self.spentAmount : spentAmount // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetRecordModel].
extension BudgetRecordModelPatterns on BudgetRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _BudgetRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String budgetId,  int spentAmount,  DateTime periodStart,  DateTime periodEnd,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetRecordModel() when $default != null:
return $default(_that.id,_that.budgetId,_that.spentAmount,_that.periodStart,_that.periodEnd,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String budgetId,  int spentAmount,  DateTime periodStart,  DateTime periodEnd,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BudgetRecordModel():
return $default(_that.id,_that.budgetId,_that.spentAmount,_that.periodStart,_that.periodEnd,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String budgetId,  int spentAmount,  DateTime periodStart,  DateTime periodEnd,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BudgetRecordModel() when $default != null:
return $default(_that.id,_that.budgetId,_that.spentAmount,_that.periodStart,_that.periodEnd,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetRecordModel implements BudgetRecordModel {
  const _BudgetRecordModel({required this.id, required this.budgetId, required this.spentAmount, required this.periodStart, required this.periodEnd, required this.createdAt, required this.updatedAt});
  factory _BudgetRecordModel.fromJson(Map<String, dynamic> json) => _$BudgetRecordModelFromJson(json);

@override final  String id;
@override final  String budgetId;
@override final  int spentAmount;
@override final  DateTime periodStart;
@override final  DateTime periodEnd;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of BudgetRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetRecordModelCopyWith<_BudgetRecordModel> get copyWith => __$BudgetRecordModelCopyWithImpl<_BudgetRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.budgetId, budgetId) || other.budgetId == budgetId)&&(identical(other.spentAmount, spentAmount) || other.spentAmount == spentAmount)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,budgetId,spentAmount,periodStart,periodEnd,createdAt,updatedAt);
}

@override
String toString() {
    return 'BudgetRecordModel(id: $id, budgetId: $budgetId, spentAmount: $spentAmount, periodStart: $periodStart, periodEnd: $periodEnd, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BudgetRecordModelCopyWith<$Res> implements $BudgetRecordModelCopyWith<$Res> {
  factory _$BudgetRecordModelCopyWith(_BudgetRecordModel value, $Res Function(_BudgetRecordModel) _then) = __$BudgetRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String budgetId, int spentAmount, DateTime periodStart, DateTime periodEnd, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$BudgetRecordModelCopyWithImpl<$Res>
    implements _$BudgetRecordModelCopyWith<$Res> {
  __$BudgetRecordModelCopyWithImpl(this._self, this._then);

  final _BudgetRecordModel _self;
  final $Res Function(_BudgetRecordModel) _then;

/// Create a copy of BudgetRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? budgetId = null,Object? spentAmount = null,Object? periodStart = null,Object? periodEnd = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_BudgetRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,budgetId: null == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as String,spentAmount: null == spentAmount ? _self.spentAmount : spentAmount // ignore: cast_nullable_to_non_nullable
as int,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
