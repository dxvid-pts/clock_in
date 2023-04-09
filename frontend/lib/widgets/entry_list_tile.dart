import 'package:flutter/material.dart';

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
  final double duration;
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
        trailing: Text("${duration.toStringAsFixed(2)}h"),
      ),
    );
  }
}
