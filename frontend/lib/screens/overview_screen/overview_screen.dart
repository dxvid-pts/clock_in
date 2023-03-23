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
          SfDateRangePicker(
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: titleStyle,
            ),
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
                  ListTile(
                    title: Text("Title $i"),
                    subtitle: Text("Subtitle $i"),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
