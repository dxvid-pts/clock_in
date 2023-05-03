// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: "id")
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "email")
  @HiveField(1)
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: "admin")
  @HiveField(2)
  bool get isAdmin => throw _privateConstructorUsedError;
  @JsonKey(name: "token")
  @HiveField(3)
  String get token => throw _privateConstructorUsedError;
  @JsonKey(name: "vacationDays")
  @HiveField(4)
  int get vacationDays => throw _privateConstructorUsedError;
  @JsonKey(name: "hoursPerDay")
  @HiveField(5)
  int get hoursPerDay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "email") @HiveField(1) String email,
      @JsonKey(name: "admin") @HiveField(2) bool isAdmin,
      @JsonKey(name: "token") @HiveField(3) String token,
      @JsonKey(name: "vacationDays") @HiveField(4) int vacationDays,
      @JsonKey(name: "hoursPerDay") @HiveField(5) int hoursPerDay});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? isAdmin = null,
    Object? token = null,
    Object? vacationDays = null,
    Object? hoursPerDay = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      vacationDays: null == vacationDays
          ? _value.vacationDays
          : vacationDays // ignore: cast_nullable_to_non_nullable
              as int,
      hoursPerDay: null == hoursPerDay
          ? _value.hoursPerDay
          : hoursPerDay // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "email") @HiveField(1) String email,
      @JsonKey(name: "admin") @HiveField(2) bool isAdmin,
      @JsonKey(name: "token") @HiveField(3) String token,
      @JsonKey(name: "vacationDays") @HiveField(4) int vacationDays,
      @JsonKey(name: "hoursPerDay") @HiveField(5) int hoursPerDay});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? isAdmin = null,
    Object? token = null,
    Object? vacationDays = null,
    Object? hoursPerDay = null,
  }) {
    return _then(_$_User(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      vacationDays: null == vacationDays
          ? _value.vacationDays
          : vacationDays // ignore: cast_nullable_to_non_nullable
              as int,
      hoursPerDay: null == hoursPerDay
          ? _value.hoursPerDay
          : hoursPerDay // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'UserAdapter')
class _$_User with DiagnosticableTreeMixin implements _User {
  const _$_User(
      {@JsonKey(name: "id") @HiveField(0) required this.id,
      @JsonKey(name: "email") @HiveField(1) required this.email,
      @JsonKey(name: "admin") @HiveField(2) required this.isAdmin,
      @JsonKey(name: "token") @HiveField(3) required this.token,
      @JsonKey(name: "vacationDays") @HiveField(4) required this.vacationDays,
      @JsonKey(name: "hoursPerDay") @HiveField(5) required this.hoursPerDay});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  final String id;
  @override
  @JsonKey(name: "email")
  @HiveField(1)
  final String email;
  @override
  @JsonKey(name: "admin")
  @HiveField(2)
  final bool isAdmin;
  @override
  @JsonKey(name: "token")
  @HiveField(3)
  final String token;
  @override
  @JsonKey(name: "vacationDays")
  @HiveField(4)
  final int vacationDays;
  @override
  @JsonKey(name: "hoursPerDay")
  @HiveField(5)
  final int hoursPerDay;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(id: $id, email: $email, isAdmin: $isAdmin, token: $token, vacationDays: $vacationDays, hoursPerDay: $hoursPerDay)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('isAdmin', isAdmin))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('vacationDays', vacationDays))
      ..add(DiagnosticsProperty('hoursPerDay', hoursPerDay));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.vacationDays, vacationDays) ||
                other.vacationDays == vacationDays) &&
            (identical(other.hoursPerDay, hoursPerDay) ||
                other.hoursPerDay == hoursPerDay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, isAdmin, token, vacationDays, hoursPerDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@JsonKey(name: "id")
      @HiveField(0)
          required final String id,
      @JsonKey(name: "email")
      @HiveField(1)
          required final String email,
      @JsonKey(name: "admin")
      @HiveField(2)
          required final bool isAdmin,
      @JsonKey(name: "token")
      @HiveField(3)
          required final String token,
      @JsonKey(name: "vacationDays")
      @HiveField(4)
          required final int vacationDays,
      @JsonKey(name: "hoursPerDay")
      @HiveField(5)
          required final int hoursPerDay}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  String get id;
  @override
  @JsonKey(name: "email")
  @HiveField(1)
  String get email;
  @override
  @JsonKey(name: "admin")
  @HiveField(2)
  bool get isAdmin;
  @override
  @JsonKey(name: "token")
  @HiveField(3)
  String get token;
  @override
  @JsonKey(name: "vacationDays")
  @HiveField(4)
  int get vacationDays;
  @override
  @JsonKey(name: "hoursPerDay")
  @HiveField(5)
  int get hoursPerDay;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
