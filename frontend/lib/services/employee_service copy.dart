import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/employee.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';
//import firstwhereor null extension

final employeeProvider =
    ChangeNotifierProvider<EmployeeNotifier>((ref) => EmployeeNotifier());

class EmployeeNotifier extends ChangeNotifier {
  Set<Employee> employees = {
    const Employee(
      id: "0",
      employeeName: "John",
      vacationDays: 30,
      workHours: 40,
    ),
    const Employee(
      id: "1",
      employeeName: "Jane",
      vacationDays: 30,
      workHours: 40,
    ),
  };

  late final StorageBox<Employee> _employeeBox;

  EmployeeNotifier() {
    //register storage adapter
    StorageEngine.registerBoxAdapter<Employee>(
      collectionKey: kEmployeeCollectionKey,
      version: 1,
      adapter: HiveBoxAdapter<Employee>(
        path: Commons.getApplicationDirectoryPath(),
        adapters: {
          EmployeeAdapter(),
        },
      ),
    );

    _employeeBox = StorageEngine.getBox<Employee>(kEmployeeCollectionKey);

    //load data from storage
    _employeeBox.getAll().then(
      (entries) {
        employees.addAll(entries.values);
        notifyListeners();
      },
    );
  }
}
