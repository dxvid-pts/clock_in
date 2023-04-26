import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/screens/overview_screen/widgets/planning_dialog.dart';
import 'package:frontend/screens/timer_screen/timer_screen.dart';
import 'package:frontend/services/consolidated_tracking_service.dart';
import 'package:frontend/services/vacation_service.dart';
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: const [
                  _TitleWidget("Vacation"),
                  _PendingVacationWidget(),
                  SizedBox(height: 20),
                  _TitleWidget("Overview"),
                  _OverEntryListSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: titleStyle(context),
    );
  }
}

class _PendingVacationWidget extends ConsumerWidget {
  const _PendingVacationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        for (final vacationEntry in ref.watch(vacationOverviewProider))
          VacationListTile(
            title: _getVacationDisplayString(
                vacationEntry.start, vacationEntry.end),
            subtitle: "Request to Manager",
            category: vacationEntry.category,
          ),
      ],
    );
  }
}

String _getVacationDisplayString(int start, int end) {
  String startString = dayToDisplayString(
      Day.fromDateTime(DateTime.fromMillisecondsSinceEpoch(start)));
  String endString = dayToDisplayString(
      Day.fromDateTime(DateTime.fromMillisecondsSinceEpoch(end)));

  String weekDay = startString.split(" ")[0];
  startString = "${weekDay.substring(0, 3)}. ${startString.split(" ")[1]}";

  weekDay = endString.split(" ")[0];
  endString = "${weekDay.substring(0, 3)}. ${endString.split(" ")[1]}";

  return "$startString - $endString";
}

class _OverEntryListSection extends ConsumerWidget {
  const _OverEntryListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        for (final trackingEntry in ref.watch(consolidatedTrackingProvider))
          EntryListTile(
            title: dayToDisplayString(trackingEntry.day),
            subtitle: (trackingEntry.category ?? DateRangeCategory.office).name,
            color: (trackingEntry.category ?? DateRangeCategory.office).color,
            duration: trackingEntry.duration,
          ),
      ],
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
        Consumer(builder: (context, ref, child) {
          return SfDateRangePicker(
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: titleStyle(context),
            ),
            cellBuilder: (context, dateDetails) {
              final vacationDays = ref.watch(vacationCalendarProider);

              final currentDay = Day.fromDateTime(dateDetails.date);

              const colorOpacity = 0.12;
              const double borderRadius = 20;
              

              final base = Center(
                child: Text(
                  dateDetails.date.day.toString(),
                  style: TextStyle(
                    color: currentDay == Day.fromDateTime(DateTime.now())
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              );
              if (vacationDays.startDays.containsKey(currentDay)) {
                return Container(
                  decoration: BoxDecoration(
                    color: vacationDays.startDays[currentDay]!.color
                        .withOpacity(colorOpacity),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  child: base,
                );
              } 
              else if (vacationDays.endDays.containsKey(currentDay)) {
                return Container(
                  decoration: BoxDecoration(
                    color: vacationDays.endDays[currentDay]!.color
                        .withOpacity(colorOpacity),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius),
                    ),
                  ),
                  child: base,
                );
              }
              else if (vacationDays.betweenDays.containsKey(currentDay)) {
                return Container(
                  decoration: BoxDecoration(
                    color: vacationDays.betweenDays[currentDay]!.color
                        .withOpacity(colorOpacity),
                  ),
                  child: base,
                );
              } else if (currentDay == Day.fromDateTime(DateTime.now())) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: base,
                  ),
                );
              }

              return base;
            },
          );
        }),
        Positioned(
          top: 6,
          right: 10,
          child: TextButton(
            onPressed: () {
              showPlanningDialog(context);
            },
            child: Row(
              children: const [
                Text("Plan now"),
                Icon(
                  Icons.play_arrow,
                  size: 14,
                )
              ],
            ),
          ),

          /*DropdownButton<DateRangeCategory>(
            isDense: true,
            items: [
              for (final item in DateRangeCategory.values)
                DropdownMenuItem(
                  value: item,
                  child: Text(item.name),
                ),
            ],
            onChanged: (value) {},
          )*/
        )
      ],
    );
  }
}
