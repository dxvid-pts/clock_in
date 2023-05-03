import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/employee_request.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/models/vacation_entry.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';
//import firstwhereor null extension

final employeeRequestProvider = ChangeNotifierProvider<EmployeeRequestNotifier>(
    (ref) => EmployeeRequestNotifier());

class EmployeeRequestNotifier extends ChangeNotifier {
  Set<EmployeeRequest> requests = {
    EmployeeRequest(
      employeeName: "Lena",
      id: Commons.generateId(),
      vacationEntry: VacationEntry(
        id: Commons.generateId(),
        start: DateTime.parse("2023-04-24 00:00:00").millisecondsSinceEpoch,
        end: DateTime.parse("2023-04-24 08:00:00").millisecondsSinceEpoch,
        comment: "I want to go to the beach",
        category: VacationCategory.pending,
      ),
    ),
    EmployeeRequest(
      employeeName: "Marc",
      id: Commons.generateId(),
      vacationEntry: VacationEntry(
        id: Commons.generateId(),
        start: DateTime.parse("2023-04-25 00:30:00").millisecondsSinceEpoch,
        end: DateTime.parse("2023-04-25 08:00:00").millisecondsSinceEpoch,
        comment: "I want to go mountain biking",
        category: VacationCategory.pending,
      ),
    ),
  };

  late final StorageBox<EmployeeRequest> _employeeRequestBox;

  EmployeeRequestNotifier() {
    //register storage adapter
    StorageEngine.registerBoxAdapter<EmployeeRequest>(
      collectionKey: kEmployeeRequestCollectionKey,
      version: 1,
      adapter: HiveBoxAdapter<EmployeeRequest>(
        path: Commons.getApplicationDirectoryPath(),
        adapters: {
          EmployeeRequestAdapter(),
        },
      ),
    );

    _employeeRequestBox = StorageEngine.getBox<EmployeeRequest>(kEmployeeRequestCollectionKey);

    //load data from storage
    _employeeRequestBox.getAll().then(
      (entries) {
        requests.addAll(entries.values);
        notifyListeners();
      },
    );
  }
}
