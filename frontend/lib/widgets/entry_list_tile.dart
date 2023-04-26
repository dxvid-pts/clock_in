import 'package:flutter/material.dart';
import 'package:frontend/models/vacation_category.dart';

class EntryListTile extends StatelessWidget {
  const EntryListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.duration,
    this.color,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Duration duration;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      //rounded corners
      decoration: const BoxDecoration(
        color: Color(0xFFf9f9f9),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        leading: color == null
            ? null
            : Container(
                width: 2,
                alignment: Alignment.topLeft,
                child: Text(
                  "•",
                  style: TextStyle(
                    fontSize: 30,
                    color: color!,
                  ),
                ),
              ),
        minLeadingWidth: 0,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.access_time,
              size: 15,
            ),
            const SizedBox(width: 6),
            Text(
              "${duration.inHours.toString().padLeft(2, "0")}:${(duration.inMinutes - duration.inHours * 60).toString().padLeft(2, "0")}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            IconButton(
              onPressed: () {},
              iconSize: 27,
              icon: const Icon(
                Icons.play_arrow,
                color: Color(0xFF7c7c7c),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VacationListTile extends StatelessWidget {
  const VacationListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.category,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final VacationCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      //rounded corners
      decoration: const BoxDecoration(
        color: Color(0xFFf9f9f9),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 2,
          alignment: Alignment.topLeft,
          child: Text(
            "•",
            style: TextStyle(
              fontSize: 30,
              color: category.color,
            ),
          ),
        ),
        minLeadingWidth: 0,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              category == VacationCategory.pending
                  ? Icons.access_time
                  : Icons.check,
              size: 15,
            ),
            const SizedBox(width: 6),
            Text(
              category.shortName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeRequestListTile extends StatelessWidget {
  const EmployeeRequestListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.action,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      //rounded corners
      decoration: const BoxDecoration(
        color: Color(0xFFf9f9f9),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: action,
      ),
    );
  }
}
