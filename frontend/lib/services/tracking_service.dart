import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:frontend/models/tracking_entry.dart';
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
      start: DateTime.parse("2021-09-01 08:00:00").millisecondsSinceEpoch,
      end: DateTime.parse("2021-09-01 12:00:00").millisecondsSinceEpoch,
      category: DateRangeCategory.remote,
    ),
  };

  Set<TrackingEntry> get getConsolidatedTrackingEntries {
    final consolidatedEntries = <TrackingEntry>{};

    for (final entry in trackingEntries) {
      //check if there is already an entry for the same day
      final existingEntry = consolidatedEntries.firstWhereOrNull(
        (e) => e.day == entry.day,
      );

      //no entry for the same day found
      if (existingEntry == null) {
        consolidatedEntries.add(entry);
      } else {
        //entry for the same day found
        //create new entry with one of both start times; add both durations; end time = start time + duration
        final combinedDuration = entry.duration + existingEntry.duration;
        //remove old entry
        consolidatedEntries.remove(existingEntry);

        //add new combined entry
        consolidatedEntries.add(
          TrackingEntry(
            id: Commons.generateId(),
            start: entry.start,
            end: entry.start + combinedDuration.inMilliseconds,
            category: entry.category,
          ),
        );
      }
    }

    return consolidatedEntries;
  }

  late final StorageBox<TrackingEntry> _trackingBox;

  TrackingNotifier() {
    //register storage adapter
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
