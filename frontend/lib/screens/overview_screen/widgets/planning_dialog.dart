import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/models/vacation_entry.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/vacation_service.dart';

void showPlanningDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const PlanningDialog(),
  );
}

class PlanningDialog extends StatefulWidget {
  const PlanningDialog({super.key});

  @override
  State<PlanningDialog> createState() => _PlanningDialogState();
}

class _PlanningDialogState extends State<PlanningDialog> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateRangeCategory? _category;
  String? comment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Title: "Planning"
          Text("Planning", style: Theme.of(context).textTheme.titleMedium),

          const SizedBox(height: 10),

          //button in the style of a textfield
          TextField(
            controller: TextEditingController(
              text: _startDate?.toIso8601String() ?? "",
            ),
            onTap: () {
              //show date picker
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ).then((value) {
                setState(() {
                  if (value != null) _startDate = value;
                });
              });
            },
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Start",
            ),
          ),

          const SizedBox(height: 10),

          //end date
          TextField(
            controller: TextEditingController(
              text: _endDate?.toIso8601String() ?? "",
            ),
            onTap: () {
              //show date picker
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ).then((value) {
                setState(() {
                  if (value != null) _endDate = value;
                });
              });
            },
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "End",
            ),
          ),
          const SizedBox(height: 10),

          //comment
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Comment (optional)",
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  comment = null;
                } else {
                  comment = value;
                }
              });
            },
          ),

          //dropdown in the style of a textfield
          const SizedBox(height: 10),

          DropdownButtonFormField<DateRangeCategory>(
            value: _category,
            items: [
              DropdownMenuItem(
                value: DateRangeCategory.vacation,
                child: Text(DateRangeCategory.vacation.name),
              ),
            ],
            onChanged: (newValue) {
              setState(() {
                _category = newValue;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
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
            onPressed:
                _startDate == null || _endDate == null || _category == null
                    ? null
                    : () {
                        final user = ref.read(authProvider).user;
                        if (user == null) return;
                        
                        ref.read(vacationProvider(user)).requestNewVacation(
                              VacationEntry(
                                id: Commons.generateId(),
                                start: _startDate!.millisecondsSinceEpoch,
                                end: _endDate!.millisecondsSinceEpoch,
                                category: VacationCategory.pending,
                                comment: comment,
                              ),
                            );
                        Navigator.of(context).pop();
                      },
            child: const Text("Save"),
          );
        }),
      ],
    );
  }
}
