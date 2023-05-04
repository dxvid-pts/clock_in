// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return _Employee.fromJson(json);
}

/// @nodoc
mixin _$Employee {
  @JsonKey(name: "id")
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "employee_name")
  @HiveField(1)
  String get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: "vacation_days")
  @HiveField(2)
  int get vacationDays => throw _privateConstructorUsedError;
  @JsonKey(name: "work_hours")
  @HiveField(3)
  int get workHours => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeCopyWith<Employee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeCopyWith<$Res> {
  factory $EmployeeCopyWith(Employee value, $Res Function(Employee) then) =
      _$EmployeeCopyWithImpl<$Res, Employee>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "employee_name") @HiveField(1) String employeeName,
      @JsonKey(name: "vacation_days") @HiveField(2) int vacationDays,
      @JsonKey(name: "work_hours") @HiveField(3) int workHours});
}

/// @nodoc
class _$EmployeeCopyWithImpl<$Res, $Val extends Employee>
    implements $EmployeeCopyWith<$Res> {
  _$EmployeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeName = null,
    Object? vacationDays = null,
    Object? workHours = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      vacationDays: null == vacationDays
          ? _value.vacationDays
          : vacationDays // ignore: cast_nullable_to_non_nullable
              as int,
      workHours: null == workHours
          ? _value.workHours
          : workHours // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EmployeeCopyWith<$Res> implements $EmployeeCopyWith<$Res> {
  factory _$$_EmployeeCopyWith(
          _$_Employee value, $Res Function(_$_Employee) then) =
      __$$_EmployeeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") @HiveField(0) String id,
      @JsonKey(name: "employee_name") @HiveField(1) String employeeName,
      @JsonKey(name: "vacation_days") @HiveField(2) int vacationDays,
      @JsonKey(name: "work_hours") @HiveField(3) int workHours});
}

/// @nodoc
class __$$_EmployeeCopyWithImpl<$Res>
    extends _$EmployeeCopyWithImpl<$Res, _$_Employee>
    implements _$$_EmployeeCopyWith<$Res> {
  __$$_EmployeeCopyWithImpl(
      _$_Employee _value, $Res Function(_$_Employee) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeName = null,
    Object? vacationDays = null,
    Object? workHours = null,
  }) {
    return _then(_$_Employee(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      vacationDays: null == vacationDays
          ? _value.vacationDays
          : vacationDays // ignore: cast_nullable_to_non_nullable
              as int,
      workHours: null == workHours
          ? _value.workHours
          : workHours // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 16, adapterName: 'EmployeeAdapter')
class _$_Employee with DiagnosticableTreeMixin implements _Employee {
  const _$_Employee(
      {@JsonKey(name: "id") @HiveField(0) required this.id,
      @JsonKey(name: "employee_name") @HiveField(1) required this.employeeName,
      @JsonKey(name: "vacation_days") @HiveField(2) required this.vacationDays,
      @JsonKey(name: "work_hours") @HiveField(3) required this.workHours});

  factory _$_Employee.fromJson(Map<String, dynamic> json) =>
      _$$_EmployeeFromJson(json);

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  final String id;
  @override
  @JsonKey(name: "employee_name")
  @HiveField(1)
  final String employeeName;
  @override
  @JsonKey(name: "vacation_days")
  @HiveField(2)
  final int vacationDays;
  @override
  @JsonKey(name: "work_hours")
  @HiveField(3)
  final int workHours;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Employee(id: $id, employeeName: $employeeName, vacationDays: $vacationDays, workHours: $workHours)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Employee'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('employeeName', employeeName))
      ..add(DiagnosticsProperty('vacationDays', vacationDays))
      ..add(DiagnosticsProperty('workHours', workHours));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Employee &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.vacationDays, vacationDays) ||
                other.vacationDays == vacationDays) &&
            (identical(other.workHours, workHours) ||
                other.workHours == workHours));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, employeeName, vacationDays, workHours);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EmployeeCopyWith<_$_Employee> get copyWith =>
      __$$_EmployeeCopyWithImpl<_$_Employee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EmployeeToJson(
      this,
    );
  }
}

abstract class _Employee implements Employee {
  const factory _Employee(
      {@JsonKey(name: "id")
      @HiveField(0)
          required final String id,
      @JsonKey(name: "employee_name")
      @HiveField(1)
          required final String employeeName,
      @JsonKey(name: "vacation_days")
      @HiveField(2)
          required final int vacationDays,
      @JsonKey(name: "work_hours")
      @HiveField(3)
          required final int workHours}) = _$_Employee;

  factory _Employee.fromJson(Map<String, dynamic> json) = _$_Employee.fromJson;

  @override
  @JsonKey(name: "id")
  @HiveField(0)
  String get id;
  @override
  @JsonKey(name: "employee_name")
  @HiveField(1)
  String get employeeName;
  @override
  @JsonKey(name: "vacation_days")
  @HiveField(2)
  int get vacationDays;
  @override
  @JsonKey(name: "work_hours")
  @HiveField(3)
  int get workHours;
  @override
  @JsonKey(ignore: true)
  _$$_EmployeeCopyWith<_$_Employee> get copyWith =>
      throw _privateConstructorUsedError;
}
