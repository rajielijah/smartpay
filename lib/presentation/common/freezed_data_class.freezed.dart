// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginObjectImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$LoginObjectImplCopyWith(
          _$LoginObjectImpl value, $Res Function(_$LoginObjectImpl) then) =
      __$$LoginObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginObjectImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$LoginObjectImpl>
    implements _$$LoginObjectImplCopyWith<$Res> {
  __$$LoginObjectImplCopyWithImpl(
      _$LoginObjectImpl _value, $Res Function(_$LoginObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginObjectImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginObjectImpl implements _LoginObject {
  _$LoginObjectImpl(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginObjectImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      __$$LoginObjectImplCopyWithImpl<_$LoginObjectImpl>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String email, final String password) =
      _$LoginObjectImpl;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignUpObject {
  String get full_name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get device_name => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignUpObjectCopyWith<SignUpObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpObjectCopyWith<$Res> {
  factory $SignUpObjectCopyWith(
          SignUpObject value, $Res Function(SignUpObject) then) =
      _$SignUpObjectCopyWithImpl<$Res, SignUpObject>;
  @useResult
  $Res call(
      {String full_name,
      String email,
      String password,
      String device_name,
      String username,
      String country,
      String otp});
}

/// @nodoc
class _$SignUpObjectCopyWithImpl<$Res, $Val extends SignUpObject>
    implements $SignUpObjectCopyWith<$Res> {
  _$SignUpObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? full_name = null,
    Object? email = null,
    Object? password = null,
    Object? device_name = null,
    Object? username = null,
    Object? country = null,
    Object? otp = null,
  }) {
    return _then(_value.copyWith(
      full_name: null == full_name
          ? _value.full_name
          : full_name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      device_name: null == device_name
          ? _value.device_name
          : device_name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpObjectImplCopyWith<$Res>
    implements $SignUpObjectCopyWith<$Res> {
  factory _$$SignUpObjectImplCopyWith(
          _$SignUpObjectImpl value, $Res Function(_$SignUpObjectImpl) then) =
      __$$SignUpObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String full_name,
      String email,
      String password,
      String device_name,
      String username,
      String country,
      String otp});
}

/// @nodoc
class __$$SignUpObjectImplCopyWithImpl<$Res>
    extends _$SignUpObjectCopyWithImpl<$Res, _$SignUpObjectImpl>
    implements _$$SignUpObjectImplCopyWith<$Res> {
  __$$SignUpObjectImplCopyWithImpl(
      _$SignUpObjectImpl _value, $Res Function(_$SignUpObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? full_name = null,
    Object? email = null,
    Object? password = null,
    Object? device_name = null,
    Object? username = null,
    Object? country = null,
    Object? otp = null,
  }) {
    return _then(_$SignUpObjectImpl(
      null == full_name
          ? _value.full_name
          : full_name // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == device_name
          ? _value.device_name
          : device_name // ignore: cast_nullable_to_non_nullable
              as String,
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignUpObjectImpl implements _SignUpObject {
  _$SignUpObjectImpl(this.full_name, this.email, this.password,
      this.device_name, this.username, this.country, this.otp);

  @override
  final String full_name;
  @override
  final String email;
  @override
  final String password;
  @override
  final String device_name;
  @override
  final String username;
  @override
  final String country;
  @override
  final String otp;

  @override
  String toString() {
    return 'SignUpObject(full_name: $full_name, email: $email, password: $password, device_name: $device_name, username: $username, country: $country, otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpObjectImpl &&
            (identical(other.full_name, full_name) ||
                other.full_name == full_name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.device_name, device_name) ||
                other.device_name == device_name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, full_name, email, password,
      device_name, username, country, otp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpObjectImplCopyWith<_$SignUpObjectImpl> get copyWith =>
      __$$SignUpObjectImplCopyWithImpl<_$SignUpObjectImpl>(this, _$identity);
}

abstract class _SignUpObject implements SignUpObject {
  factory _SignUpObject(
      final String full_name,
      final String email,
      final String password,
      final String device_name,
      final String username,
      final String country,
      final String otp) = _$SignUpObjectImpl;

  @override
  String get full_name;
  @override
  String get email;
  @override
  String get password;
  @override
  String get device_name;
  @override
  String get username;
  @override
  String get country;
  @override
  String get otp;
  @override
  @JsonKey(ignore: true)
  _$$SignUpObjectImplCopyWith<_$SignUpObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
