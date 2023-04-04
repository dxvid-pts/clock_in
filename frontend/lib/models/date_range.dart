import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:hive/hive.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'date_range.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'date_range.g.dart';

@freezed
class DateRange with _$DateRange {
  @HiveType(typeId: 2, adapterName: 'DateRangeAdapter')
  const factory DateRange({
    @JsonKey(name: "id") @HiveField(0) required String id,
    @JsonKey(name: "start") @HiveField(1) required int start,
    @JsonKey(name: "end") @HiveField(2) required int end,
    @JsonKey(name: "category")
    @HiveField(3)
        required DateRangeCategory category,
  }) = _DateRange;

  factory DateRange.fromJson(Map<String, Object?> json) =>
      _$DateRangeFromJson(json);
}

extension DateRangeExtension on DateRange {
  DateTime get startDate => DateTime.fromMillisecondsSinceEpoch(start);
  DateTime get endDate => DateTime.fromMillisecondsSinceEpoch(end);
}