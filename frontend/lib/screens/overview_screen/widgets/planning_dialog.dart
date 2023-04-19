import 'package:flutter/material.dart';
import 'package:frontend/models/date_range_category.dart';

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

          //dropdown in the style of a textfield
          const SizedBox(height: 10),

          DropdownButtonFormField<DateRangeCategory>(
            value: _category,
            items: [
              for (final item in DateRangeCategory.values)
                DropdownMenuItem(
                  value: item,
                  child: Text(item.name),
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
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}