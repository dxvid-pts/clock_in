import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'date_range_category.g.dart';

@HiveType(typeId: 14, adapterName: 'DateRangeCategoryAdapter')
enum DateRangeCategory {
  @HiveField(0)
  vacation,
  @HiveField(1)
  sick,
  @HiveField(2)
  remote,
  @HiveField(3)
  office,
}

extension DateRangeCategoryExtension on DateRangeCategory {
  String get name {
    switch (this) {
      case DateRangeCategory.vacation:
        return 'Vacation';
      case DateRangeCategory.sick:
        return 'Sick';
      case DateRangeCategory.remote:
        return 'Remote';
      case DateRangeCategory.office:
        return 'Office';
    }
  }

  Color get color {
    switch (this) {
      case DateRangeCategory.vacation:
        return const Color(0xFFd399f1);
      case DateRangeCategory.sick:
        return const Color(0xFFd26a07);
      case DateRangeCategory.remote:
        return const Color(0xFFd399f1);
      case DateRangeCategory.office:
        return const Color(0xFFd26a07);
    }
  }
}
