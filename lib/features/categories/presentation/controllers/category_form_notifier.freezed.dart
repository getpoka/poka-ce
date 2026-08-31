// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryFormState {

 CategoryModel? get initialCategory; String get name; CategoryType get type; String? get icon; String? get color; String? get parentId; bool get isSaving; bool get isSuccess; String? get error; String? get nameError;
/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryFormStateCopyWith<CategoryFormState> get copyWith => _$CategoryFormStateCopyWithImpl<CategoryFormState>(this as CategoryFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryFormState&&(identical(other.initialCategory, _this.initialCategory) || other.initialCategory == _this.initialCategory)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.parentId, _this.parentId) || other.parentId == _this.parentId)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isSuccess, _this.isSuccess) || other.isSuccess == _this.isSuccess)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.nameError, _this.nameError) || other.nameError == _this.nameError));
}


@override
int get hashCode {
  final _this = this as CategoryFormState;
  return Object.hash(runtimeType,_this.initialCategory,_this.name,_this.type,_this.icon,_this.color,_this.parentId,_this.isSaving,_this.isSuccess,_this.error,_this.nameError);
}

@override
String toString() {
  final _this = this as CategoryFormState;
  return 'CategoryFormState(initialCategory: ${_this.initialCategory}, name: ${_this.name}, type: ${_this.type}, icon: ${_this.icon}, color: ${_this.color}, parentId: ${_this.parentId}, isSaving: ${_this.isSaving}, isSuccess: ${_this.isSuccess}, error: ${_this.error}, nameError: ${_this.nameError})';
}


}

/// @nodoc
abstract mixin class $CategoryFormStateCopyWith<$Res>  {
  factory $CategoryFormStateCopyWith(CategoryFormState value, $Res Function(CategoryFormState) _then) = _$CategoryFormStateCopyWithImpl;
@useResult
$Res call({
 CategoryModel? initialCategory, String name, CategoryType type, String? icon, String? color, String? parentId, bool isSaving, bool isSuccess, String? error, String? nameError
});


$CategoryModelCopyWith<$Res>? get initialCategory;

}
/// @nodoc
class _$CategoryFormStateCopyWithImpl<$Res>
    implements $CategoryFormStateCopyWith<$Res> {
  _$CategoryFormStateCopyWithImpl(this._self, this._then);

  final CategoryFormState _self;
  final $Res Function(CategoryFormState) _then;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialCategory = freezed,Object? name = null,Object? type = null,Object? icon = freezed,Object? color = freezed,Object? parentId = freezed,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,Object? nameError = freezed,}) {
  return _then(CategoryFormState(
initialCategory: freezed == initialCategory ? _self.initialCategory : initialCategory // ignore: cast_nullable_to_non_nullable
as CategoryModel?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CategoryType,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get initialCategory {
    if (_self.initialCategory == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.initialCategory!, (value) {
    return _then(_self.copyWith(initialCategory: value));
  });
}
}


/// Adds pattern-matching-related methods to [CategoryFormState].
extension CategoryFormStatePatterns on CategoryFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryFormState value)  $default,){
final _that = this;
switch (_that) {
case _CategoryFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryFormState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoryModel? initialCategory,  String name,  CategoryType type,  String? icon,  String? color,  String? parentId,  bool isSaving,  bool isSuccess,  String? error,  String? nameError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryFormState() when $default != null:
return $default(_that.initialCategory,_that.name,_that.type,_that.icon,_that.color,_that.parentId,_that.isSaving,_that.isSuccess,_that.error,_that.nameError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoryModel? initialCategory,  String name,  CategoryType type,  String? icon,  String? color,  String? parentId,  bool isSaving,  bool isSuccess,  String? error,  String? nameError)  $default,) {final _that = this;
switch (_that) {
case _CategoryFormState():
return $default(_that.initialCategory,_that.name,_that.type,_that.icon,_that.color,_that.parentId,_that.isSaving,_that.isSuccess,_that.error,_that.nameError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoryModel? initialCategory,  String name,  CategoryType type,  String? icon,  String? color,  String? parentId,  bool isSaving,  bool isSuccess,  String? error,  String? nameError)?  $default,) {final _that = this;
switch (_that) {
case _CategoryFormState() when $default != null:
return $default(_that.initialCategory,_that.name,_that.type,_that.icon,_that.color,_that.parentId,_that.isSaving,_that.isSuccess,_that.error,_that.nameError);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryFormState implements CategoryFormState {
  const _CategoryFormState({this.initialCategory, this.name = '', this.type = CategoryType.expense, this.icon, this.color, this.parentId, this.isSaving = false, this.isSuccess = false, this.error, this.nameError});
  

@override final  CategoryModel? initialCategory;
@override@JsonKey() final  String name;
@override@JsonKey() final  CategoryType type;
@override final  String? icon;
@override final  String? color;
@override final  String? parentId;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSuccess;
@override final  String? error;
@override final  String? nameError;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryFormStateCopyWith<_CategoryFormState> get copyWith => __$CategoryFormStateCopyWithImpl<_CategoryFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryFormState&&(identical(other.initialCategory, initialCategory) || other.initialCategory == initialCategory)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.error, error) || other.error == error)&&(identical(other.nameError, nameError) || other.nameError == nameError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,initialCategory,name,type,icon,color,parentId,isSaving,isSuccess,error,nameError);
}

@override
String toString() {
    return 'CategoryFormState(initialCategory: $initialCategory, name: $name, type: $type, icon: $icon, color: $color, parentId: $parentId, isSaving: $isSaving, isSuccess: $isSuccess, error: $error, nameError: $nameError)';
}


}

/// @nodoc
abstract mixin class _$CategoryFormStateCopyWith<$Res> implements $CategoryFormStateCopyWith<$Res> {
  factory _$CategoryFormStateCopyWith(_CategoryFormState value, $Res Function(_CategoryFormState) _then) = __$CategoryFormStateCopyWithImpl;
@override @useResult
$Res call({
 CategoryModel? initialCategory, String name, CategoryType type, String? icon, String? color, String? parentId, bool isSaving, bool isSuccess, String? error, String? nameError
});


@override $CategoryModelCopyWith<$Res>? get initialCategory;

}
/// @nodoc
class __$CategoryFormStateCopyWithImpl<$Res>
    implements _$CategoryFormStateCopyWith<$Res> {
  __$CategoryFormStateCopyWithImpl(this._self, this._then);

  final _CategoryFormState _self;
  final $Res Function(_CategoryFormState) _then;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialCategory = freezed,Object? name = null,Object? type = null,Object? icon = freezed,Object? color = freezed,Object? parentId = freezed,Object? isSaving = null,Object? isSuccess = null,Object? error = freezed,Object? nameError = freezed,}) {
  return _then(_CategoryFormState(
initialCategory: freezed == initialCategory ? _self.initialCategory : initialCategory // ignore: cast_nullable_to_non_nullable
as CategoryModel?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CategoryType,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get initialCategory {
    if (_self.initialCategory == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.initialCategory!, (value) {
    return _then(_self.copyWith(initialCategory: value));
  });
}
}

// dart format on
