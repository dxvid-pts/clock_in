import 'package:collection/collection.dart';
import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/employee.dart';
import 'package:frontend/models/employee_request.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/models/vacation_entry.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/employee_service%20copy.dart';
import 'package:storage_engine/storage_box.dart';
import 'package:storage_engine/storage_engine.dart';
import 'package:storage_engine_hive_adapter/storage_engine_hive_adapter.dart';
//import firstwhereor null extension

final employeeRequestProvider = Provider<Set<EmployeeReqStruct>>((ref) {
  final user = ref.watch(authProvider).user;

  if (user == null) return {};

  final employees = ref.watch(employeeProvider(user)).employees;
  final requests = ref.watch(employeeRequestRawProvider(user)).requests;

  Set<EmployeeReqStruct> returnSet = {};

  for (var request in requests) {
    final employee = employees.firstWhereOrNull(
      (element) => element.id == request.employeeId,
    );

    if (employee != null) {
      returnSet.add(
        EmployeeReqStruct(
          request: request,
          employee: employee,
        ),
      );
    }
  }

  return returnSet;
});

class EmployeeReqStruct {
  final EmployeeRequest request;
  final Employee employee;

  const EmployeeReqStruct({required this.request, required this.employee});
}

final employeeRequestRawProvider =
    ChangeNotifierProvider.family<EmployeeRequestNotifier, User>(
  (ref, user) => EmployeeRequestNotifier(user),
);

class EmployeeRequestNotifier extends ChangeNotifier {
  final User _user;

  late List<EmployeeRequest> requests = [
    if (_user.isDemo)
      EmployeeRequest(
        employeeId: "0",
        id: Commons.generateId(),
        accepted: null,
        vacationEntry: VacationEntry(
          id: Commons.generateId(),
          start: DateTime.parse("2023-04-24 00:00:00").millisecondsSinceEpoch,
          end: DateTime.parse("2023-04-24 08:00:00").millisecondsSinceEpoch,
          comment: "I want to go to the beach",
          category: VacationCategory.pending,
        ),
      ),
    if (_user.isDemo)
      EmployeeRequest(
        employeeId: "1",
        id: Commons.generateId(),
        accepted: null,
        vacationEntry: VacationEntry(
          id: Commons.generateId(),
          start: DateTime.parse("2023-04-25 00:30:00").millisecondsSinceEpoch,
          end: DateTime.parse("2023-04-25 08:00:00").millisecondsSinceEpoch,
          comment: "I want to go mountain biking",
          category: VacationCategory.pending,
        ),
      ),
  ];

  //late final StorageBox<EmployeeRequest> _employeeRequestBox;

  EmployeeRequestNotifier(User user) : _user = user {
    //register storage adapter
    /*  StorageEngine.registerBoxAdapter<EmployeeRequest>(
      collectionKey: kEmployeeRequestCollectionKey,
      version: 1,
      adapter: HiveBoxAdapter<EmployeeRequest>(
        path: Commons.getApplicationDirectoryPath(),
        adapters: {
          EmployeeRequestAdapter(),
        },
      ),
    );

    _employeeRequestBox =
        StorageEngine.getBox<EmployeeRequest>(kEmployeeRequestCollectionKey);

    //load data from storage
    _employeeRequestBox.getAll().then(
      (entries) {
        requests.addAll(entries.values);
        notifyListeners();
      },
    );*/
  }

  void setAccepted(EmployeeRequest request, bool accepted) {
    final index = requests.indexWhere((element) => element.id == request.id);

    if (index != -1) {
      requests[index] = requests[index].copyWith(accepted: accepted);
      /* _employeeRequestBox.put(
          requests.elementAt(index).id, requests.elementAt(index));*/
      notifyListeners();
    }
  }
}
