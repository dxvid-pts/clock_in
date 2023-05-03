// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmployeeRequest _$EmployeeRequestFromJson(Map<String, dynamic> json) {
  return _EmployeeRequest.fromJson(json);
}

/// @nodoc
mixin _$EmployeeRequest {
  @JsonKey(name: "id")
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "employeeId")
  @HiveField(1)
  String get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: "vacation_entry")
  @HiveField(2)
  VacationEntry get vacationEntry => throw _privateConstructorUsedError;
  @JsonKey(name: "accepted")
  @HiveField(3)
  bool? get accepted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeRequestCopyWith<EmployeeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeRequestCopyWith<$Res> {
  factory $EmployeeRequestCopyWith(
          EmployeeRequest value, $Res Function(EmployeeRequest) then) =
      _$EmployeeRequestCopyWithImpl<$Res, EmployeeRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "id")
      @HiveField(0)
          String id,
      @JsonKey(name: "employeeId")
      @HiveField(1)
          String employeeId,
      @JsonKey(name: "vacation_entry")
      @HiveField(2)
          VacationEntry vacationEntry,
      @JsonKey(name: "accepted")
      @HiveField(3)
          bool? accepted});

  $VacationEntryCopyWith<$Res> get vacationEntry;
}

/// @nodoc
class _$EmployeeRequestCopyWithImpl<$Res, $Val extends EmployeeRequest>
    implements $EmployeeRequestCopyWith<$Res> {
  _$EmployeeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? vacationEntry = null,
    Object? accepted = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      vacationEntry: null == vacationEntry
          ? _value.vacationEntry
          : vacationEntry // ignore: cast_nullable_to_non_nullable
              as VacationEntry,
      accepted: freezed == accepted
          ? _value.accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VacationEntryCopyWith<$Res> get vacationEntry {
    return $VacationEntryCopyWith<$Res>(_value.vacationEntry, (value) {
      return _then(_value.copyWith(vacationEntry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EmployeeRequestCopyWith<$Res>
    implements $EmployeeRequestCopyWith<$Res> {
  factory _$$_EmployeeRequestCopyWith(
          _$_EmployeeRequest value, $Res Function(_$_EmployeeRequest) then) =
      __$$_EmployeeRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id")
      @HiveField(0)
          String id,
      @JsonKey(name: "employeeId")
      @HiveField(1)
          String employeeId,
      @JsonKey(name: "vacation_entry")
      @HiveField(2)
          VacationEntry vacationEntry,
      @JsonKey(name: "accepted")
      @HiveField(3)
          bool? accepted});

  @override
  $VacationEntryCopyWith<$Res> get vacationEntry;
}

/// @nodoc
class __$$_EmployeeRequestCopyWithImpl<$Res>
    extends _$EmployeeRequestCopyWithImpl<$Res, _$_EmployeeRequest>
    implements _$$_EmployeeRequestCopyWith<$Res> {
  __$$_EmployeeRequestCopyWithImpl(
      _$_EmployeeRequest _value, $Res Function(_$_EmployeeRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? vacationEntry = null,
    Object? accepted = freezed,
  }) {
    return _then(_$_EmployeeRequest(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      vacationEntry: null == vacationEntry
          ? _value.vacationEntry
          : vacationEntry // ignore: cast_nullable_to_non_nullable
              as VacationEntry,
      accepted: freezed == accepted
          ? _value.accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 10, adapterName: 'EmployeeRequestAdapter')
class _$_EmployeeRequest
    with DiagnosticableTreeMixin
    implements _EmployeeRequest {
  const _$_EmployeeRequest(
      {@JsonKey(name: "id")
      @HiveField(0)
          required this.id,
      @JsonKey(name: "employeeId")
      @HiveField(1)
          required this.employeeId,
      @JsonKey(name: "vacation_entry")
      @HiveField(2)
          required this.vacationEntry,
      @JsonKey(name: "accepted")
      @HiveField(3)
          required this.accepted});

  factory _$_EmployeeRequest.fromJson(Map<String, dynamic> json) =>
      _$$_EmployeeRequestFromJson(json);

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  final String id;
  @override
  @JsonKey(name: "employeeId")
  @HiveField(1)
  final String employeeId;
  @override
  @JsonKey(name: "vacation_entry")
  @HiveField(2)
  final VacationEntry vacationEntry;
  @override
  @JsonKey(name: "accepted")
  @HiveField(3)
  final bool? accepted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EmployeeRequest(id: $id, employeeId: $employeeId, vacationEntry: $vacationEntry, accepted: $accepted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EmployeeRequest'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('employeeId', employeeId))
      ..add(DiagnosticsProperty('vacationEntry', vacationEntry))
      ..add(DiagnosticsProperty('accepted', accepted));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EmployeeRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.vacationEntry, vacationEntry) ||
                other.vacationEntry == vacationEntry) &&
            (identical(other.accepted, accepted) ||
                other.accepted == accepted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, employeeId, vacationEntry, accepted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EmployeeRequestCopyWith<_$_EmployeeRequest> get copyWith =>
      __$$_EmployeeRequestCopyWithImpl<_$_EmployeeRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EmployeeRequestToJson(
      this,
    );
  }
}

abstract class _EmployeeRequest implements EmployeeRequest {
  const factory _EmployeeRequest(
      {@JsonKey(name: "id")
      @HiveField(0)
          required final String id,
      @JsonKey(name: "employeeId")
      @HiveField(1)
          required final String employeeId,
      @JsonKey(name: "vacation_entry")
      @HiveField(2)
          required final VacationEntry vacationEntry,
      @JsonKey(name: "accepted")
      @HiveField(3)
          required final bool? accepted}) = _$_EmployeeRequest;

  factory _EmployeeRequest.fromJson(Map<String, dynamic> json) =
      _$_EmployeeRequest.fromJson;

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  String get id;
  @override
  @JsonKey(name: "employeeId")
  @HiveField(1)
  String get employeeId;
  @override
  @JsonKey(name: "vacation_entry")
  @HiveField(2)
  VacationEntry get vacationEntry;
  @override
  @JsonKey(name: "accepted")
  @HiveField(3)
  bool? get accepted;
  @override
  @JsonKey(ignore: true)
  _$$_EmployeeRequestCopyWith<_$_EmployeeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
