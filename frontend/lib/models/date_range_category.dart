enum DateRangeCategory {
  vacation,
  sick,
  remote,
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
    }
  }
}