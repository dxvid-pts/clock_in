// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeAdapter extends TypeAdapter<_$_Employee> {
  @override
  final int typeId = 16;

  @override
  _$_Employee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Employee(
      id: fields[0] as String,
      employeeName: fields[1] as String,
      vacationDays: fields[2] as int,
      workHours: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Employee obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.employeeName)
      ..writeByte(2)
      ..write(obj.vacationDays)
      ..writeByte(3)
      ..write(obj.workHours);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Employee _$$_EmployeeFromJson(Map<String, dynamic> json) => _$_Employee(
      id: json['id'] as String,
      employeeName: json['employee_name'] as String,
      vacationDays: json['vacation_days'] as int,
      workHours: json['work_hours'] as int,
    );

Map<String, dynamic> _$$_EmployeeToJson(_$_Employee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_name': instance.employeeName,
      'vacation_days': instance.vacationDays,
      'work_hours': instance.workHours,
    };
