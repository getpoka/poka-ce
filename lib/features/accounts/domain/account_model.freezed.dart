// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel {

 String get id; String get name; AccountType get type; int get balance; DateTime get createdAt; DateTime get updatedAt; int get initialBalance; String? get icon; String? get color; String? get parentId; bool get isActive; int get sort; List<String> get restrictedCategoryIds;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AccountModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.initialBalance, _this.initialBalance) || other.initialBalance == _this.initialBalance)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.parentId, _this.parentId) || other.parentId == _this.parentId)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.sort, _this.sort) || other.sort == _this.sort)&&const DeepCollectionEquality().equals(other.restrictedCategoryIds, _this.restrictedCategoryIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AccountModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.type,_this.balance,_this.createdAt,_this.updatedAt,_this.initialBalance,_this.icon,_this.color,_this.parentId,_this.isActive,_this.sort,const DeepCollectionEquality().hash(_this.restrictedCategoryIds));
}

@override
String toString() {
  final _this = this as AccountModel;
  return 'AccountModel(id: ${_this.id}, name: ${_this.name}, type: ${_this.type}, balance: ${_this.balance}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, initialBalance: ${_this.initialBalance}, icon: ${_this.icon}, color: ${_this.color}, parentId: ${_this.parentId}, isActive: ${_this.isActive}, sort: ${_this.sort}, restrictedCategoryIds: ${_this.restrictedCategoryIds})';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, AccountType type, int balance, DateTime createdAt, DateTime updatedAt, int initialBalance, String? icon, String? color, String? parentId, bool isActive, int sort, List<String> restrictedCategoryIds
});




}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? balance = null,Object? createdAt = null,Object? updatedAt = null,Object? initialBalance = null,Object? icon = freezed,Object? color = freezed,Object? parentId = freezed,Object? isActive = null,Object? sort = null,Object? restrictedCategoryIds = null,}) {
  return _then(AccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,initialBalance: null == initialBalance ? _self.initialBalance : initialBalance // ignore: cast_nullable_to_non_nullable
as int,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,restrictedCategoryIds: null == restrictedCategoryIds ? _self.restrictedCategoryIds : restrictedCategoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  AccountType type,  int balance,  DateTime createdAt,  DateTime updatedAt,  int initialBalance,  String? icon,  String? color,  String? parentId,  bool isActive,  int sort,  List<String> restrictedCategoryIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.balance,_that.createdAt,_that.updatedAt,_that.initialBalance,_that.icon,_that.color,_that.parentId,_that.isActive,_that.sort,_that.restrictedCategoryIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  AccountType type,  int balance,  DateTime createdAt,  DateTime updatedAt,  int initialBalance,  String? icon,  String? color,  String? parentId,  bool isActive,  int sort,  List<String> restrictedCategoryIds)  $default,) {final _that = this;
switch (_that) {
case _AccountModel():
return $default(_that.id,_that.name,_that.type,_that.balance,_that.createdAt,_that.updatedAt,_that.initialBalance,_that.icon,_that.color,_that.parentId,_that.isActive,_that.sort,_that.restrictedCategoryIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  AccountType type,  int balance,  DateTime createdAt,  DateTime updatedAt,  int initialBalance,  String? icon,  String? color,  String? parentId,  bool isActive,  int sort,  List<String> restrictedCategoryIds)?  $default,) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.balance,_that.createdAt,_that.updatedAt,_that.initialBalance,_that.icon,_that.color,_that.parentId,_that.isActive,_that.sort,_that.restrictedCategoryIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountModel extends AccountModel {
  const _AccountModel({required this.id, required this.name, required this.type, required this.balance, required this.createdAt, required this.updatedAt, this.initialBalance = 0, this.icon, this.color, this.parentId, this.isActive = true, this.sort = 0,  List<String> restrictedCategoryIds = const []}): _restrictedCategoryIds = restrictedCategoryIds,super._();
  factory _AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  AccountType type;
@override final  int balance;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  int initialBalance;
@override final  String? icon;
@override final  String? color;
@override final  String? parentId;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int sort;
 final  List<String> _restrictedCategoryIds;
@override@JsonKey() List<String> get restrictedCategoryIds {
  if (_restrictedCategoryIds is EqualUnmodifiableListView) return _restrictedCategoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_restrictedCategoryIds);
}


/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.initialBalance, initialBalance) || other.initialBalance == initialBalance)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other.restrictedCategoryIds, _restrictedCategoryIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,type,balance,createdAt,updatedAt,initialBalance,icon,color,parentId,isActive,sort,const DeepCollectionEquality().hash(_restrictedCategoryIds));
}

@override
String toString() {
    return 'AccountModel(id: $id, name: $name, type: $type, balance: $balance, createdAt: $createdAt, updatedAt: $updatedAt, initialBalance: $initialBalance, icon: $icon, color: $color, parentId: $parentId, isActive: $isActive, sort: $sort, restrictedCategoryIds: $restrictedCategoryIds)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, AccountType type, int balance, DateTime createdAt, DateTime updatedAt, int initialBalance, String? icon, String? color, String? parentId, bool isActive, int sort, List<String> restrictedCategoryIds
});




}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? balance = null,Object? createdAt = null,Object? updatedAt = null,Object? initialBalance = null,Object? icon = freezed,Object? color = freezed,Object? parentId = freezed,Object? isActive = null,Object? sort = null,Object? restrictedCategoryIds = null,}) {
  return _then(_AccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,initialBalance: null == initialBalance ? _self.initialBalance : initialBalance // ignore: cast_nullable_to_non_nullable
as int,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,restrictedCategoryIds: null == restrictedCategoryIds ? _self._restrictedCategoryIds : restrictedCategoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
