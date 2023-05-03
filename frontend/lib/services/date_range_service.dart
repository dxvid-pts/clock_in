import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/date_range.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:hive/hive.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';

final dateRangeProvider =
    ChangeNotifierProvider<DateRangeNotifier>((ref) => DateRangeNotifier());

class DateRangeNotifier extends ChangeNotifier {
  Set<DateRange> selectedDates = {};

  late final StorageBox<DateRange> _dateRangeBox;

  DateRangeNotifier() {
    Hive.registerAdapter<DateRangeCategory>(DateRangeCategoryAdapter());

    //register storage adapter
    StorageEngine.registerBoxAdapter<DateRange>(
      collectionKey: kDateRangeCollectionKey,
      version: 1,
      adapter: HiveBoxAdapter<DateRange>(
        path: Commons.getApplicationDirectoryPath(),
        adapters: {
          DateRangeAdapter(),
        },
      ),
    );

    _dateRangeBox = StorageEngine.getBox<DateRange>(kDateRangeCollectionKey);

    //load data from storage
    _dateRangeBox.getAll().then(
          (entries) => selectedDates = entries.values.toSet(),
        );
  }

  //add and update
  void setNewDateRange(DateRange dateRange) {
    _dateRangeBox.put(dateRange.id, dateRange);

    //remove old date range if it exists and add new one
    selectedDates.removeWhere((element) => element.id == dateRange.id);
    selectedDates.add(dateRange);

    notifyListeners();
  }

  void removeDateRange(String id) {
    _dateRangeBox.remove(id);
    selectedDates.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
