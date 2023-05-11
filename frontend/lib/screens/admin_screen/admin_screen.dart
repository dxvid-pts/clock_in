import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/employee.dart';
import 'package:frontend/screens/admin_screen/widgets/employee_dialog.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/employee_request_service.dart';
import 'package:frontend/services/employee_service.dart';
import 'package:frontend/utils.dart';
import 'package:frontend/widgets/entry_list_tile.dart';
import 'package:frontend/widgets/title_widget.dart';

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
    final user = ref.read(authProvider).user;

    final employees = user == null
        ? <Employee>{}
        : ref.watch(employeeProvider(user)).employees;

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
                        children: [
                          Text("Work days: ${e.workHours}"),
                          Text("Vacation days: ${e.vacationDays}"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      tooltip: "Edit employee details",
                      onPressed: () {
                        showEmployeeDialog(context, e);
                      },
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
          //pending
          if (requests.where((e) => e.request.accepted == null).isNotEmpty)
            const TitleWidget("Pending"),
          for (final item in requests.where((e) => e.request.accepted == null))
            _EmployeeRequestListTile(item: item, ref: ref),

          //accepted
          if (requests.where((e) => e.request.accepted == true).isNotEmpty)
            const TitleWidget("Accepted"),
          for (final item in requests.where((e) => e.request.accepted == true))
            _EmployeeRequestListTile(item: item, ref: ref),

          //rejected
          if (requests.where((e) => e.request.accepted == false).isNotEmpty)
            const TitleWidget("Rejected"),
          for (final item in requests.where((e) => e.request.accepted == false))
            _EmployeeRequestListTile(item: item, ref: ref),
        ],
      ),
    );
  }
}

class _EmployeeRequestListTile extends StatelessWidget {
  const _EmployeeRequestListTile({
    super.key,
    required this.item,
    required this.ref,
  });

  final EmployeeReqStruct item;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return EmployeeRequestListTile(
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
                final user = ref.read(authProvider).user;
                if (user == null) return;

                ref
                    .read(employeeRequestRawProvider(user))
                    .setAccepted(item.request, true);
              },
              icon: const Icon(Icons.check),
            ),
          if (item.request.accepted == null)
            IconButton(
              onPressed: () {
                final user = ref.read(authProvider).user;
                if (user == null) return;

                ref
                    .read(employeeRequestRawProvider(user))
                    .setAccepted(item.request, false);
              },
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }
}
