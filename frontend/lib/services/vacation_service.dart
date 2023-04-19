import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/models/vacation_entry.dart';
import 'package:hive/hive.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';

final vacationChartProider = Provider<Map<VacationCategory, int>>((ref) {
  final vacationService = ref.watch(vacationProvider);
  final vacationEntries = vacationService.vacationData;

  if (vacationEntries.isEmpty) return {};

  final Map<VacationCategory, int> vacationChart = {
    VacationCategory.available: vacationEntries
        .where((element) => element.category == VacationCategory.available)
        .length,
    VacationCategory.pending: vacationEntries
        .where((element) => element.category == VacationCategory.pending)
        .length,
    VacationCategory.approved: vacationEntries
        .where((element) => element.category == VacationCategory.approved)
        .length,
    VacationCategory.taken: vacationEntries
        .where((element) => element.category == VacationCategory.taken)
        .length,
  };

  return vacationChart;
});

final vacationProvider =
    ChangeNotifierProvider<VacationNotifier>((ref) => VacationNotifier());

class VacationNotifier extends ChangeNotifier {
  Set<VacationEntry> vacationData = {};

  late final StorageBox<VacationEntry> _vacationBox;

  Future<void>? _initFuture;

  VacationNotifier() {
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

    print("init");

    Future<void> load() async {
      final entries = await _vacationBox.getAll();

      print("loaded");
      vacationData = entries.values.toSet();

      final availableVacationDays = kMaxVacationDays - vacationData.length;

      //fill rest up with available entries
      for (int i = 0; i < (availableVacationDays); i++) {
        final date = DateTime.now().add(Duration(days: i));
        vacationData.add(
          VacationEntry(
            id: Commons.generateId(),
            start: date.millisecondsSinceEpoch,
            end: date.millisecondsSinceEpoch,
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
    print(vacationData);
    for (VacationEntry entry in vacationData) {
      if (entry.category == VacationCategory.available) {
        print("contains");
        contains = true;
        break;
      }
    }

    if (!contains) {
      print("return");
      return;
    } else {
      print("vacationEntry");
      //get one available entry and remove it
      final availableEntry = vacationData.firstWhere(
        (element) => element.category == VacationCategory.available,
      );
      vacationData.remove(availableEntry);
      vacationData.add(vacationEntry);

      //add new entry to storage
      _vacationBox.put(vacationEntry.id, vacationEntry);

      notifyListeners();
    }
  }
}
