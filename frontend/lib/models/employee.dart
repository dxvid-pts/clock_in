import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/models/vacation_entry.dart';
import 'package:hive/hive.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'employee.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'employee.g.dart';

@freezed
class Employee with _$Employee {
  @HiveType(typeId: 16, adapterName: 'EmployeeAdapter')
  const factory Employee({
    @JsonKey(name: "id") @HiveField(0) required String id,
    @JsonKey(name: "employee_name") @HiveField(1) required String employeeName,
    @JsonKey(name: "vacation_days") @HiveField(2) required int vacationDays,
    @JsonKey(name: "work_hours") @HiveField(3) required int workHours,
  }) = _Employee;

  factory Employee.fromJson(Map<String, Object?> json) =>
      _$EmployeeFromJson(json);
}