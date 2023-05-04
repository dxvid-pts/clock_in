// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VacationEntryAdapter extends TypeAdapter<_$_VacationEntry> {
  @override
  final int typeId = 7;

  @override
  _$_VacationEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_VacationEntry(
      id: fields[0] as String,
      start: fields[1] as int,
      end: fields[2] as int,
      category: fields[3] as VacationCategory,
      comment: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_VacationEntry obj) {
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
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VacationEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VacationEntry _$$_VacationEntryFromJson(Map<String, dynamic> json) =>
    _$_VacationEntry(
      id: json['id'] as String,
      start: json['start'] as int,
      end: json['end'] as int,
      category: $enumDecode(_$VacationCategoryEnumMap, json['category']),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$_VacationEntryToJson(_$_VacationEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start,
      'end': instance.end,
      'category': _$VacationCategoryEnumMap[instance.category]!,
      'comment': instance.comment,
    };

const _$VacationCategoryEnumMap = {
  VacationCategory.available: 'available',
  VacationCategory.taken: 'taken',
  VacationCategory.pending: 'pending',
  VacationCategory.approved: 'approved',
};
