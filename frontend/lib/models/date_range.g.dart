// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_range.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateRangeAdapter extends TypeAdapter<_$_DateRange> {
  @override
  final int typeId = 2;

  @override
  _$_DateRange read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_DateRange(
      id: fields[0] as String,
      start: fields[1] as int,
      end: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_DateRange obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.end);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateRangeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DateRange _$$_DateRangeFromJson(Map<String, dynamic> json) => _$_DateRange(
      id: json['id'] as String,
      start: json['start'] as int,
      end: json['end'] as int,
    );

Map<String, dynamic> _$$_DateRangeToJson(_$_DateRange instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start,
      'end': instance.end,
    };
