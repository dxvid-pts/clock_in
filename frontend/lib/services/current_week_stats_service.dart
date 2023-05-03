import 'package:collection/collection.dart';
import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/consolidated_tracking_service.dart';

final currentWeekStatsProvider = Provider<Map<Day, TrackingEntry>>((ref) {
  final user = ref.watch(authProvider).user;

  final Map<Day, TrackingEntry> weekStats = {};

  final consolidated = ref.watch(consolidatedTrackingProvider);

  final List<Day> thisWeeksDays = [];

  final currentDay = Day.today();
  for (int i = 1; i < 8; i++) {
    if (currentDay.weekday == i) {
      thisWeeksDays.add(currentDay);
    } else if (currentDay.weekday > i) {
      thisWeeksDays.add(currentDay.subtract(days: currentDay.weekday - i));
    } else {
      thisWeeksDays.add(currentDay.add(days: i - currentDay.weekday));
    }
  }

  for (final day in thisWeeksDays) {
    final entry = consolidated.firstWhereOrNull((e) => e.day == day);
    if (entry != null) {
      weekStats[day] = entry;
    } else {
      //if there is no entry for the day, create a dummy entry with zero duration

      final startTime = day.toDateTime().millisecondsSinceEpoch;

      //add 8 hours to get end time
      final endTime = startTime + (Duration(hours: user?.hoursPerDay??8).inMilliseconds);

      weekStats[day] = TrackingEntry(
        isDummy: true,
        id: Commons.generateId(),
        start: startTime,
        end: endTime,
        category: DateRangeCategory.office,
      );
    }
  }

  return weekStats;
});
