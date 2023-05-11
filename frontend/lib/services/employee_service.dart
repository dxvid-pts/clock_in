import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/employee.dart';
import 'package:frontend/models/user.dart';

final employeeProvider = ChangeNotifierProvider.family<EmployeeNotifier, User>(
    (ref, user) => EmployeeNotifier(user));

class EmployeeNotifier extends ChangeNotifier {
  final User _user;

  late Set<Employee> employees = {
    if (_user.isDemo)
      const Employee(
        id: "0",
        employeeName: "John",
        vacationDays: 30,
        workHours: 40,
      ),
    if (_user.isDemo)
      const Employee(
        id: "1",
        employeeName: "Jane",
        vacationDays: 30,
        workHours: 40,
      ),
  };

  //late final StorageBox<Employee> _employeeBox;

  EmployeeNotifier(User user) : _user = user {
    //register storage adapter
    /* StorageEngine.registerBoxAdapter<Employee>(
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
    );*/
  }

  void updateEmployee(Employee employee) {
    employees.removeWhere((e) => e.id == employee.id);
    employees.add(employee);

    notifyListeners();
  }
}
