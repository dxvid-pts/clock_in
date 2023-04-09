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
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(duration.toStringAsFixed(2) + "h"),
    );
  }
}
