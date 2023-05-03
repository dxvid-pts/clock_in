import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/employee_request_service.dart';
import 'package:frontend/utils.dart';
import 'package:frontend/widgets/entry_list_tile.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(employeeRequestProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Employee Overview"),
              Tab(text: "Pending Requests"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.abc),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  for (final item in requests)
                    EmployeeRequestListTile(
                      title: "Vaction Request from ${item.employee.employeeName}",
                      subtitle: getVacationDisplayString(
                        item.request.vacationEntry.start,
                        item.request.vacationEntry.end,
                      ),
                      action: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.check),
                            //  color: Theme.of(context).primaryColor,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
