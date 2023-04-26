// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeRequestAdapter extends TypeAdapter<_$_EmployeeRequest> {
  @override
  final int typeId = 10;

  @override
  _$_EmployeeRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_EmployeeRequest(
      id: fields[0] as String,
      employeeName: fields[1] as String,
      vacationEntry: fields[2] as VacationEntry,
    );
  }

  @override
  void write(BinaryWriter writer, _$_EmployeeRequest obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.employeeName)
      ..writeByte(2)
      ..write(obj.vacationEntry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EmployeeRequest _$$_EmployeeRequestFromJson(Map<String, dynamic> json) =>
    _$_EmployeeRequest(
      id: json['id'] as String,
      employeeName: json['employee_name'] as String,
      vacationEntry: VacationEntry.fromJson(
          json['vacation_entry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EmployeeRequestToJson(_$_EmployeeRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_name': instance.employeeName,
      'vacation_entry': instance.vacationEntry,
    };
