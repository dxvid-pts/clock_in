// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VacationCategoryAdapter extends TypeAdapter<VacationCategory> {
  @override
  final int typeId = 8;

  @override
  VacationCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VacationCategory.available;
      case 1:
        return VacationCategory.taken;
      case 2:
        return VacationCategory.pending;
      case 3:
        return VacationCategory.approved;
      default:
        return VacationCategory.available;
    }
  }

  @override
  void write(BinaryWriter writer, VacationCategory obj) {
    switch (obj) {
      case VacationCategory.available:
        writer.writeByte(0);
        break;
      case VacationCategory.taken:
        writer.writeByte(1);
        break;
      case VacationCategory.pending:
        writer.writeByte(2);
        break;
      case VacationCategory.approved:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VacationCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
