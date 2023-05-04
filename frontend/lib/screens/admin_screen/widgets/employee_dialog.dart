import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/employee.dart';
import 'package:frontend/services/employee_service%20copy.dart';

void showEmployeeDialog(BuildContext context, Employee employee) {
  showDialog(
    context: context,
    builder: (context) => EmployeeDialog(employee: employee),
  );
}

class EmployeeDialog extends StatefulWidget {
  const EmployeeDialog({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  State<EmployeeDialog> createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<EmployeeDialog> {
  late String? vacationDays = widget.employee.vacationDays.toString();
  late String? workDays = widget.employee.workHours.toString();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Employee: ${widget.employee.employeeName}",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 10),

          //comment
          TextFormField(
            initialValue: widget.employee.workHours.toString(),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Work hours",
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  workDays = null;
                } else {
                  workDays = value;
                }
              });
            },
          ),

          //dropdown in the style of a textfield
          const SizedBox(height: 10),

          TextFormField(
            initialValue: widget.employee.vacationDays.toString(),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Vacation Days",
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  vacationDays = null;
                } else {
                  vacationDays = value;
                }
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        Consumer(builder: (context, ref, _) {
          return TextButton(
            onPressed: workDays == null ||
                    vacationDays == null ||
                    int.tryParse(workDays.toString()) == null ||
                    int.tryParse(vacationDays.toString()) == null
                ? null
                : () {
                    final employee = widget.employee.copyWith(
                      workHours: int.parse(workDays!),
                      vacationDays: int.parse(vacationDays!),
                    );

                    ref.read(employeeProvider).updateEmployee(employee);
                    Navigator.of(context).pop();
                  },
            child: const Text("Save"),
          );
        }),
      ],
    );
  }
}
