import 'package:flutter/services.dart';

enum VacationCategory {
  available,
  taken,
  pending,
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
