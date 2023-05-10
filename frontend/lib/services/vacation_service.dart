import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/models/vacation_entry.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:hive/hive.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';
import 'package:http/http.dart' as http;

final vacationChartProider = Provider<Map<VacationCategory, int>>((ref) {
  final user = ref.watch(authProvider).user;
  assert(user != null);
  if (user == null) return {};

  final vacationService = ref.watch(vacationProvider(user));
  final vacationEntries = vacationService.vacationData;

  if (vacationEntries.isEmpty) return {};

  final Map<VacationCategory, int> vacationChart = {
    VacationCategory.available: vacationEntries
        .where((element) => element.category == VacationCategory.available)
        .length,
    VacationCategory.pending: vacationEntries
            .where((element) => element.category == VacationCategory.pending)
            .isEmpty
        ? 0
        : vacationEntries
            .where((element) => element.category == VacationCategory.pending)
            .map((e) => e.durationDays)
            .reduce((v, e) => v + e),
    VacationCategory.approved: vacationEntries
            .where((element) => element.category == VacationCategory.approved)
            .isEmpty
        ? 0
        : vacationEntries
            .where((element) => element.category == VacationCategory.approved)
            .map((e) => e.durationDays)
            .reduce((v, e) => v + e),
    VacationCategory.taken: vacationEntries
            .where((element) => element.category == VacationCategory.taken)
            .isEmpty
        ? 0
        : vacationEntries
            .where((element) => element.category == VacationCategory.taken)
            .map((e) => e.durationDays)
            .reduce((v, e) => v + e),
  };

  return vacationChart;
});

final vacationOverviewProider = Provider<List<VacationEntry>>((ref) {
  final user = ref.watch(authProvider).user;
  assert(user != null);

  final vacationService = ref.watch(vacationProvider(user!));
  final vacationEntries = vacationService.vacationData;

  if (vacationEntries.isEmpty) return [];

  return [
    ...vacationEntries
        .where((element) => element.category == VacationCategory.pending),
    ...vacationEntries
        .where((element) => element.category == VacationCategory.approved),
  ];
});

class _VacationCalendarScheme {
  final Map<Day, VacationCategory> startDays;
  final Map<Day, VacationCategory> betweenDays;
  final Map<Day, VacationCategory> endDays;

  const _VacationCalendarScheme({
    required this.startDays,
    required this.betweenDays,
    required this.endDays,
  });
}

final vacationCalendarProider = Provider<_VacationCalendarScheme>((ref) {
  final user = ref.watch(authProvider).user;
  assert(user != null);

  final vacationService = ref.watch(vacationProvider(user!));
  final vacationEntries = vacationService.vacationData
      .where((e) => e.category != VacationCategory.available);

  final Map<Day, VacationCategory> startDays = {};
  final Map<Day, VacationCategory> betweenDays = {};
  final Map<Day, VacationCategory> endDays = {};

  for (VacationEntry entry in vacationEntries) {
    final start = DateTime.fromMillisecondsSinceEpoch(entry.start);
    final end = DateTime.fromMillisecondsSinceEpoch(entry.end);

    final days = end.difference(start).inDays;

    for (int i = 0; i <= days; i++) {
      final date = Day.fromDateTime(start.add(Duration(days: i)));
      if (i == 0) {
        startDays[date] = entry.category;
      } else if (i == days) {
        endDays[date] = entry.category;
      } else {
        betweenDays[date] = entry.category;
      }
    }
  }

  return _VacationCalendarScheme(
    startDays: startDays,
    betweenDays: betweenDays,
    endDays: endDays,
  );
});

final vacationProvider = ChangeNotifierProvider.family<VacationNotifier, User>(
    (ref, user) => VacationNotifier(user));

class VacationNotifier extends ChangeNotifier {
  final User _user;
  Set<VacationEntry> vacationData = {};

  late final StorageBox<VacationEntry> _vacationBox;

  Future<void>? _initFuture;

  VacationNotifier(User user) : _user = user {
    //register storage adapter
    StorageEngine.registerBoxAdapter<VacationEntry>(
      collectionKey: kVacationCollectionKey,
      version: 1,
      adapter: HiveBoxAdapter<VacationEntry>(
        path: Commons.getApplicationDirectoryPath(),
        adapters: {
          VacationEntryAdapter(),
        },
      ),
    );
    Hive.registerAdapter(VacationCategoryAdapter());

    _vacationBox = StorageEngine.getBox<VacationEntry>(kVacationCollectionKey);

    Future<void> load() async {
      final entries = await _vacationBox.getAll();

      vacationData = entries.values.toSet();

      final availableVacationDays = kMaxVacationDays -
          (vacationData.isEmpty
              ? 0
              : vacationData
                  .map((e) => e.durationDays)
                  .reduce((v, e) => v + e));

      //fill rest up with available entries
      for (int i = 0; i < (availableVacationDays); i++) {
        final date = DateTime.now().add(Duration(days: i));
        vacationData.add(
          VacationEntry(
            id: Commons.generateId(),
            start: date.millisecondsSinceEpoch,
            end: date.millisecondsSinceEpoch,
            comment: null,
            category: VacationCategory.available,
          ),
        );
      }

      notifyListeners();
    }

    //load data from storage
    _initFuture = load();
  }

  Future<void> requestNewVacation(VacationEntry vacationEntry) async {
    //await initFuture;
    if (_initFuture != null) await _initFuture;

    //check if available entry exists and remove it, otherwise return and do nothing
    bool contains = false;
    for (VacationEntry entry in vacationData) {
      if (entry.category == VacationCategory.available) {
        contains = true;
        break;
      }
    }

    if (!contains) {
      return;
    } else {
      final duration = vacationEntry.durationDays;
      for (int i = 0; i < duration; i++) {
        //get one available entry and remove it
        final availableEntry = vacationData.firstWhere(
          (element) => element.category == VacationCategory.available,
        );
        vacationData.remove(availableEntry);
      }

      vacationData.add(vacationEntry);

      //add new entry to storage
      _vacationBox.put(vacationEntry.id, vacationEntry);

      notifyListeners();

      //notify api
      await http.post(
        Uri.parse('http://localhost:3001/api/vacation'),
        headers: {"Authorization": "Bearer ${_user.token}"},
        body: {
          "begin": DateTime.fromMillisecondsSinceEpoch(vacationEntry.start)
              .toIso8601String(),
          "end": DateTime.fromMillisecondsSinceEpoch(vacationEntry.end)
              .toIso8601String(),
        },
      );
    }
  }

  Future<void> deleteVacation(VacationEntry vacationEntry) async {
    //await initFuture;
    if (_initFuture != null) await _initFuture;

    vacationData.remove(vacationEntry);

    //add new entry to storage
    _vacationBox.remove(vacationEntry.id);

    //add available entries
    final duration = vacationEntry.durationDays;
    for (int i = 0; i < duration; i++) {
      final date = DateTime.now().add(Duration(days: i));
      vacationData.add(
        VacationEntry(
          id: Commons.generateId(),
          start: date.millisecondsSinceEpoch,
          end: date.millisecondsSinceEpoch,
          comment: null,
          category: VacationCategory.available,
        ),
      );
    }

    notifyListeners();
  }
}
