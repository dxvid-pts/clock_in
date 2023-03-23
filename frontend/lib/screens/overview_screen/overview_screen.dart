import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 17,
      color: Theme.of(context).textTheme.bodyMedium?.color,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Overview"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SfDateRangePicker(
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: titleStyle,
                ),
              ),
              Positioned(
                top: 6,
                right: 10,
                child: DropdownButton(
                  isDense: true,
                  value: null,
                  items: const [
                    DropdownMenuItem(
                      child: Text("Krankheit"),
                      value: "Krankheit",
                    ),
                    DropdownMenuItem(
                      child: Text("Homeoffice"),
                      value: "Homeoffice",
                    ),
                    DropdownMenuItem(
                      child: Text("Urlaub"),
                      value: "Urlaub",
                    ),
                  ],
                  onChanged: (value) {},
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Overview",
              style: titleStyle,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (var i = 0; i < 10; i++)
                  OverviewListTile(
                    text: i.toString(),
                  )
              ],
            ),
          )
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
      title: Text("Title $text"),
      subtitle: Text("Subtitle $text"),
    );
  }
}
