import 'package:flutter/material.dart';

class EntryListTile extends StatelessWidget {
  const EntryListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.duration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final double duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( vertical: 5),
      //rounded corners
      decoration: const BoxDecoration(
        color: Color(0xFFf9f9f9),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text("${duration.toStringAsFixed(2)}h"),
      ),
    );
  }
}
