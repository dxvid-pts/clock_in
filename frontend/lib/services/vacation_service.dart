import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/models/vacation_entry.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';

final vacationChartProider = Provider<Map<VacationCategory, int>>((ref) {
  final vacationEntries = ref.watch(vacationProvider).vacationData;

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

    _vacationBox = StorageEngine.getBox<VacationEntry>(kVacationCollectionKey);

    //load data from storage
    _vacationBox.getAll().then(
      (entries) {
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
      },
    );
  }

  void requestNewVacation(VacationEntry vacationEntry) {
    _vacationBox.put(vacationEntry.id, vacationEntry);

    //check if available entry exists and remove it, otherwise return and do nothing
    if (!vacationData
        .any((element) => element.category == VacationCategory.available)) {
      return;
    } else {
      vacationData.removeWhere(
          (element) => element.category == VacationCategory.available);
    }

    //remove old date range if it exists and add new one
    vacationData.removeWhere((element) => element.id == vacationEntry.id);
    vacationData.add(vacationEntry);

    notifyListeners();
  }
}
