import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:frontend/models/user.dart';
import 'package:hive/hive.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';
//import firstwhereor null extension
import 'package:http/http.dart' as http;

final trackingProvider = ChangeNotifierProvider.family<TrackingNotifier, User>(
    (ref, user) => TrackingNotifier(user));

class TrackingNotifier extends ChangeNotifier {
  final User _user;

  late Set<TrackingEntry> trackingEntries = {
    if (_user.isDemo)
      TrackingEntry(
        id: Commons.generateId(),
        start: DateTime.parse("${_dateWeekStartToParsableString(0)} 00:00:00")
            .millisecondsSinceEpoch,
        end: DateTime.parse("${_dateWeekStartToParsableString(0)} 08:00:00")
            .millisecondsSinceEpoch,
        category: DateRangeCategory.remote,
      ),
    if (_user.isDemo)
      TrackingEntry(
        id: Commons.generateId(),
        start: DateTime.parse("${_dateWeekStartToParsableString(1)} 00:30:00")
            .millisecondsSinceEpoch,
        end: DateTime.parse("${_dateWeekStartToParsableString(1)} 08:00:00")
            .millisecondsSinceEpoch,
        category: DateRangeCategory.remote,
      ),
    if (_user.isDemo)
      TrackingEntry(
        id: Commons.generateId(),
        start: DateTime.parse("${_dateWeekStartToParsableString(2)} 02:00:00")
            .millisecondsSinceEpoch,
        end: DateTime.parse("${_dateWeekStartToParsableString(2)} 12:00:00")
            .millisecondsSinceEpoch,
        category: DateRangeCategory.remote,
      ),
  };
  late final StorageBox<TrackingEntry> _trackingBox;

  TrackingNotifier(User user) : _user = user {
    //register storage adapter
    Hive.registerAdapter<DateRangeCategory>(DateRangeCategoryAdapter());

    StorageEngine.registerBoxAdapter<TrackingEntry>(
      collectionKey: kTrackingCollectionKey,
      version: 1,
      adapter: HiveBoxAdapter<TrackingEntry>(
        path: Commons.getApplicationDirectoryPath(),
        adapters: {
          TrackingEntryAdapter(),
        },
      ),
    );

    _trackingBox = StorageEngine.getBox<TrackingEntry>(kTrackingCollectionKey);

    //load data from storage
    _trackingBox.getAll().then(
      (entries) {
        trackingEntries.addAll(entries.values);
        notifyListeners();
      },
    );
  }

  void addTrackingEntry({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final trackingEntry = TrackingEntry(
      id: Commons.generateId(),
      start: startTime.millisecondsSinceEpoch,
      end: endTime.millisecondsSinceEpoch,
      category: DateRangeCategory.office,
    );

    trackingEntries.add(trackingEntry);
    _trackingBox.put(trackingEntry.id, trackingEntry);
    notifyListeners();

    //notify api
    await http.post(
      Uri.parse('http://localhost:3001/api/work'),
      headers: {"Authorization": "Bearer ${_user.token}"},
      body: {
        "begin": DateTime.fromMillisecondsSinceEpoch(trackingEntry.start)
            .toIso8601String(),
        "end": DateTime.fromMillisecondsSinceEpoch(trackingEntry.end)
            .toIso8601String(),
      },
    );
  }
}

String _dateWeekStartToParsableString(int addedDays) {
  //get date of fist day of week
  final weekStartDate =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));

  //add days to week start date
  final now = weekStartDate.add(Duration(days: addedDays));

  final year = now.year;
  final month = now.month.toString().padLeft(2, '0');
  final day = now.day.toString().padLeft(2, '0');

  return "$year-$month-$day";
}
