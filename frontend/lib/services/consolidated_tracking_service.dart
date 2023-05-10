import 'package:collection/collection.dart';
import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/tracking_service.dart';

final consolidatedTrackingProvider = Provider<Set<TrackingEntry>>((ref) {
  final user = ref.watch(authProvider).user;

  if(user == null) {
    return {};
  }

  final consolidatedEntries = <TrackingEntry>{};

  final trackingEntries = ref.watch(trackingProvider(user)).trackingEntries;

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
});
