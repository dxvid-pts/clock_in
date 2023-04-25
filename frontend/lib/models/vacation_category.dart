import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'vacation_category.g.dart';

@HiveType(typeId: 8, adapterName: 'VacationCategoryAdapter')
enum VacationCategory {
  @HiveField(0)
  available,
  @HiveField(1)
  taken,
  @HiveField(2)
  pending,
  @HiveField(3)
  approved,
}

extension DateRangeCategoryExtension on VacationCategory {
  String get name {
    switch (this) {
      case VacationCategory.available:
        return 'Vacation available';
      case VacationCategory.taken:
        return 'Vacation taken';
      case VacationCategory.pending:
        return 'Vacation pending';
      case VacationCategory.approved:
        return 'Vacation approved';
    }
  }

   String get shortName {
    switch (this) {
      case VacationCategory.available:
        return 'Available';
      case VacationCategory.taken:
        return 'Taken';
      case VacationCategory.pending:
        return 'Pending';
      case VacationCategory.approved:
        return 'Approved';
    }
  }

  Color get color {
    switch (this) {
      case VacationCategory.available:
        return const Color(0xFFD26A07);
      case VacationCategory.taken:
        return const Color(0xFFE3954B);
      case VacationCategory.pending:
        return const Color(0xFF5E3E1F);
      case VacationCategory.approved:
        return const Color(0xFFAB5505);
    }
  }
}
