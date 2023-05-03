import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:hive/hive.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';
//import firstwhereor null extension
import 'package:collection/collection.dart';

final trackingProvider =
    ChangeNotifierProvider<TrackingNotifier>((ref) => TrackingNotifier());

class TrackingNotifier extends ChangeNotifier {
  Set<TrackingEntry> trackingEntries = {
    TrackingEntry(
      id: Commons.generateId(),
      start: DateTime.parse("2023-04-24 00:00:00").millisecondsSinceEpoch,
      end: DateTime.parse("2023-04-24 08:00:00").millisecondsSinceEpoch,
      category: DateRangeCategory.remote,
    ),
    TrackingEntry(
      id: Commons.generateId(),
      start: DateTime.parse("2023-04-25 00:30:00").millisecondsSinceEpoch,
      end: DateTime.parse("2023-04-25 08:00:00").millisecondsSinceEpoch,
      category: DateRangeCategory.remote,
    ),
    TrackingEntry(
      id: Commons.generateId(),
      start: DateTime.parse("2023-04-26 02:00:00").millisecondsSinceEpoch,
      end: DateTime.parse("2023-04-26 12:00:00").millisecondsSinceEpoch,
      category: DateRangeCategory.remote,
    ),
  };

  late final StorageBox<TrackingEntry> _trackingBox;

  TrackingNotifier() {
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
  }) {
    final trackingEntry = TrackingEntry(
      id: Commons.generateId(),
      start: startTime.millisecondsSinceEpoch,
      end: endTime.millisecondsSinceEpoch,
      category: DateRangeCategory.office,
    );

    trackingEntries.add(trackingEntry);
    _trackingBox.put(trackingEntry.id, trackingEntry);
    notifyListeners();
  }
}
