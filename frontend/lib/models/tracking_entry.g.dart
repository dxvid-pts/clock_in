// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackingEntryAdapter extends TypeAdapter<_$_TrackingEntry> {
  @override
  final int typeId = 3;

  @override
  _$_TrackingEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_TrackingEntry(
      id: fields[0] as String,
      start: fields[1] as int,
      end: fields[2] as int,
      category: fields[3] as DateRangeCategory?,
      isDummy: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$_TrackingEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.end)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.isDummy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackingEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrackingEntry _$$_TrackingEntryFromJson(Map<String, dynamic> json) =>
    _$_TrackingEntry(
      id: json['id'] as String,
      start: json['start'] as int,
      end: json['end'] as int,
      category:
          $enumDecodeNullable(_$DateRangeCategoryEnumMap, json['category']) ??
              DateRangeCategory.office,
      isDummy: json['dummy'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TrackingEntryToJson(_$_TrackingEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start,
      'end': instance.end,
      'category': _$DateRangeCategoryEnumMap[instance.category],
      'dummy': instance.isDummy,
    };

const _$DateRangeCategoryEnumMap = {
  DateRangeCategory.vacation: 'vacation',
  DateRangeCategory.sick: 'sick',
  DateRangeCategory.remote: 'remote',
  DateRangeCategory.office: 'office',
};
