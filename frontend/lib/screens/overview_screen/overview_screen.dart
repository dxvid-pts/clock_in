import 'package:commons_flutter/commons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/models/date_range_category.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/screens/overview_screen/widgets/planning_dialog.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/consolidated_tracking_service.dart';
import 'package:frontend/services/vacation_service.dart';
import 'package:frontend/utils.dart';
import 'package:frontend/widgets/entry_list_tile.dart';
import 'package:frontend/widgets/title_widget.dart';
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
          DatePicker(),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: _PendingVacationWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingVacationWidget extends ConsumerWidget {
  const _PendingVacationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider).user;
    final vacatinoEntries = ref.watch(vacationOverviewProider);

    if (vacatinoEntries.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TitleWidget("Vacation"),
          const SizedBox(height: 3),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 130,
                    child: Image.asset(
                        //https://i.ibb.co/qD2q2Cz/168312588290589803.webp, https://i.ibb.co/gdQZyS0/employee-unable-to-access-data-3391065-2829991-1.png
                        "assets/not-found.webp"),
                  ),
                  const SizedBox(height: 10),
                  Text("No pending vacation requests",
                      style: titleStyle(context)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return ListView(
      children: [
        const TitleWidget("Vacation"),
        const SizedBox(height: 3),
        for (final vacationEntry in vacatinoEntries)
          Slidable(
            key: ValueKey(vacationEntry.id),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    if (user == null) return;

                    ref
                        .read(vacationProvider(user))
                        .deleteVacation(vacationEntry);
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  icon: Icons.history,
                  label: 'Revert request',
                ),
              ],
            ),
            child: VacationListTile(
              title: getVacationDisplayString(
                  vacationEntry.start, vacationEntry.end),
              subtitle: "Request to Manager",
              category: vacationEntry.category,
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
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

class DatePicker extends StatelessWidget {
  DatePicker({super.key});

  final DateRangePickerController _controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer(builder: (context, ref, child) {
          return SfDateRangePicker(
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: titleStyle(context),
            ),
            controller: _controller,
            cellBuilder: (context, dateDetails) {
              if (_controller.view == DateRangePickerView.month) {
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
                } else if (vacationDays.endDays.containsKey(currentDay)) {
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
                } else if (vacationDays.betweenDays.containsKey(currentDay)) {
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
              } else if (_controller.view == DateRangePickerView.year) {
                return Container(
                  width: dateDetails.bounds.width,
                  height: dateDetails.bounds.height,
                  alignment: Alignment.center,
                  child: Text(_monthString(dateDetails.date.month)),
                );
              } else if (_controller.view == DateRangePickerView.decade) {
                return Container(
                  width: dateDetails.bounds.width,
                  height: dateDetails.bounds.height,
                  alignment: Alignment.center,
                  child: Text(dateDetails.date.year.toString()),
                );
              } else {
                final int yearValue = (dateDetails.date.year ~/ 10) * 10;
                return Container(
                  width: dateDetails.bounds.width,
                  height: dateDetails.bounds.height,
                  alignment: Alignment.center,
                  child: Text('$yearValue - ${yearValue + 9}'),
                );
              }
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
            child: const Row(
              children: [
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

String _monthString(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "Oktober";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "Unknown";
  }
}
