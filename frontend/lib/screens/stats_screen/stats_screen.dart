import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:frontend/models/vacation_category.dart';
import 'package:frontend/screens/stats_screen/stats_utils_csv.dart';
import 'package:frontend/screens/stats_screen/stats_utils_pdf.dart';
import 'package:frontend/services/current_week_stats_service.dart';
import 'package:frontend/services/vacation_service.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 17,
      color: Theme.of(context).textTheme.bodyMedium?.color,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer(builder: (context, ref, _) {
                return ElevatedButton.icon(
                  onPressed: () {
                    exportAndShowPdf(ref, context);
                  },
                  label: const Text("Export as PDF"),
                  icon: const Icon(Icons.file_download),
                );
              }),
              Consumer(builder: (context, ref, _) {
                return ElevatedButton.icon(
                  onPressed: () {
                    exportAndShowCsv(ref, context);
                  },
                  label: const Text("Export as CSV"),
                  icon: const Icon(Icons.file_download),
                );
              }),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 20),
            child: Text(
              "Stats",
              style: titleStyle,
            ),
          ),
          const Expanded(
            flex: 2,
            child: PieChartSample2(),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 20),
            child: Text(
              "Submitted hours",
              style: titleStyle,
            ),
          ),
          const Expanded(
            flex: 4,
            child: SimpleBarChart(),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class SimpleBarChart extends ConsumerWidget {
  const SimpleBarChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeekStats = ref.watch(currentWeekStatsProvider);

    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          borderData:
              //only show the left border
              FlBorderData(
            border: const Border(
              bottom: BorderSide(color: Colors.black45, width: 1.7),
              left: BorderSide(color: Colors.black45, width: 1.7),
            ),
          ),
          barGroups: [
            for (final statsEntry in currentWeekStats.entries)
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: statsEntry.value.duration.inHours.toDouble(),
                    gradient: LinearGradient(
                      colors: [
                        //dummy
                        if (statsEntry.value.isDummy ?? false)
                          Colors.grey.withOpacity(0.05),
                        if (statsEntry.value.isDummy ?? false)
                          Colors.grey.withOpacity(0.3),

                        //no dummy
                        if (!(statsEntry.value.isDummy ?? false))
                          Theme.of(context).primaryColor.withOpacity(0.8),
                        if (!(statsEntry.value.isDummy ?? false))
                          Theme.of(context).primaryColor,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.2, 1],
                    ),
                    width: 30,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class PieChartSample2 extends ConsumerWidget {
  const PieChartSample2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vacationChartService = ref.watch(vacationChartProider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: [
                for (final chartEntry in vacationChartService.entries)
                  PieChartSectionData(
                    color: chartEntry.key.color,
                    value: chartEntry.value.toDouble(),
                    title: '${chartEntry.value}',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black12, blurRadius: 1)],
                    ),
                  ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final cat in VacationCategory.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Indicator(
                  color: cat.color,
                  text: cat.name,
                  isSquare: true,
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        )
      ],
    );
  }
}
