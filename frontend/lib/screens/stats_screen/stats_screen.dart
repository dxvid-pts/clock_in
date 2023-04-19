import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/tracking_entry.dart';
import 'package:frontend/services/current_week_stats_service.dart';

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
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 20),
            child: Text(
              "Submitted hours",
              style: titleStyle,
            ),
          ),
          const Expanded(
            flex: 2,
            child: SimpleBarChart(),
          ),
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
                        Theme.of(context).primaryColor.withOpacity(0.8),
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

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections(),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Indicator(
              color: Theme.of(context).primaryColor,
              text: 'Vacation available',
              isSquare: true,
            ),
            const SizedBox(height: 4),
            const Indicator(
              color: Color(0xFFE3954B),
              text: 'Vacation taken',
              isSquare: true,
            ),
            const SizedBox(height: 4),
            const Indicator(
              color: Color(0xFF5E3E1F),
              text: 'Vacation pending',
              isSquare: true,
            ),
            const SizedBox(height: 4),
            const Indicator(
              color: Color(0xFFAB5505),
              text: 'Vacation planned',
              isSquare: true,
            ),
            const SizedBox(height: 18),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black12, blurRadius: 1)];

      final titleStyle = TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: shadows,
      );
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Theme.of(context).primaryColor,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: titleStyle,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFE3954B),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: titleStyle,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFF5E3E1F),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: titleStyle,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xFFAB5505),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: titleStyle,
          );
        default:
          throw Error();
      }
    });
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
