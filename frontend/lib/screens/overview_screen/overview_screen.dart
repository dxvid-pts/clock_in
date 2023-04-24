import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:frontend/screens/timer_screen/timer_screen.dart';
import 'package:frontend/services/tracking_service.dart';
import 'package:frontend/widgets/entry_list_tile.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

TextStyle titleStyle(BuildContext context) => TextStyle(
      fontSize: 17,
      color: Theme.of(context).textTheme.bodyMedium?.color,
    );

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Overview"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DatePicker(),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Overview",
              style: titleStyle(context),
            ),
          ),
          const Expanded(child: _OverEntryListSection()),
        ],
      ),
    );
  }
}

class _OverEntryListSection extends ConsumerWidget {
  const _OverEntryListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          //sample
          const EntryListTile(
            title: "Monday 10.04",
            subtitle: "Remote",
            color: Color(0xFFd399f1),
            duration: 2.4,
          ),

          for (final trackingEntry in ref
              .watch(trackingProvider)
              .getConsolidatedTrackingEntries)
            EntryListTile(
              title: dayToDisplayString(trackingEntry.day),
              subtitle: "Office",
              color: const Color(0xFFd26a07),
              duration: trackingEntry.duration.inHours +
                  (trackingEntry.duration.inMinutes / 60),
            ),
        ],
      ),
    );
  }
}

class OverviewListTile extends StatelessWidget {
  const OverviewListTile({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Week $text"),
      subtitle: Text("Subtitle $text"),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  Day? _startDay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfDateRangePicker(
          headerStyle: DateRangePickerHeaderStyle(
            textStyle: titleStyle(context),
          ),
          cellBuilder: (context, dateDetails) {
            final base = Center(
              child: Text(
                dateDetails.date.day.toString(),
              ),
            );
            if (dateDetails.date.day == DateTime.now().day) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    dateDetails.date.day.toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              );
            }

            return base;
          },
          selectionMode: DateRangePickerSelectionMode.single,
          onSelectionChanged: (value) {
            /*   if (_multiRangeSelectionCount < 2 && _selectedCategory != null) {
              print("object");
              _multiRangeSelectionCount = _multiRangeSelectionCount + 1;
            } else {
              print("object1");
              setState(() {
                _selectedCategory = null;
              });
            }
            /**/

            print(dateController.selectedRanges);

            //create new date range
            PickerDateRange newDateRange = PickerDateRange(
              DateTime.now().subtract(const Duration(days: 1)),
              DateTime.now(),
            );

            //yesterday and today
            // dateController.selectedRanges = [newDateRange];
            // print(value.value);*/
          },
        ),
        Positioned(
          top: 6,
          right: 10,
          child: DropdownButton<DateRangeCategory>(
            isDense: true,
            //  value: _selectedCategory,
            items: [
              for (final item in DateRangeCategory.values)
                DropdownMenuItem(
                  value: item,
                  child: Text(item.name),
                ),
            ],
            onChanged: (value) {
              /* setState(() {
                _selectedCategory = value;
                _multiRangeSelectionCount = 0;
              });*/
            },
          ),
        )
      ],
    );
  }
}
