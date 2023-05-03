// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_range_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateRangeCategoryAdapter extends TypeAdapter<DateRangeCategory> {
  @override
  final int typeId = 14;

  @override
  DateRangeCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DateRangeCategory.vacation;
      case 1:
        return DateRangeCategory.sick;
      case 2:
        return DateRangeCategory.remote;
      case 3:
        return DateRangeCategory.office;
      default:
        return DateRangeCategory.vacation;
    }
  }

  @override
  void write(BinaryWriter writer, DateRangeCategory obj) {
    switch (obj) {
      case DateRangeCategory.vacation:
        writer.writeByte(0);
        break;
      case DateRangeCategory.sick:
        writer.writeByte(1);
        break;
      case DateRangeCategory.remote:
        writer.writeByte(2);
        break;
      case DateRangeCategory.office:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateRangeCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
