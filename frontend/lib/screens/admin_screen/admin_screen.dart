import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/employee_request_service.dart';
import 'package:frontend/services/employee_service%20copy.dart';
import 'package:frontend/utils.dart';
import 'package:frontend/widgets/entry_list_tile.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        body: const TabBarView(
          children: [
            _EmployeeSection(),
            _RequestSection(),
          ],
        ),
      ),
    );
  }
}

class _EmployeeSection extends ConsumerWidget {
  const _EmployeeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeProvider).employees;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          for (final e in employees)
            EmployeeRequestListTile(
              title: e.employeeName,
              subtitle: "#${e.id.hashCode}",
              action: SizedBox(
                width: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text("Work days: 40"),
                          Text("Vacation days: 30"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RequestSection extends ConsumerWidget {
  const _RequestSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(employeeRequestProvider);

    return Padding(
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
                  if (item.request.accepted == null)
                    IconButton(
                      onPressed: () {
                        ref
                            .read(employeeRequestRawProvider)
                            .setAccepted(item.request, true);
                      },
                      icon: const Icon(Icons.check),
                    ),
                  if (item.request.accepted == null)
                    IconButton(
                      onPressed: () {
                        ref
                            .read(employeeRequestRawProvider)
                            .setAccepted(item.request, false);
                      },
                      icon: const Icon(Icons.close),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
