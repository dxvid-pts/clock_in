import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/timer_service.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerService = ref.watch(timerProvider);

    final timerTextTheme = Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: 64,
          color: const Color(0xFFfefdfd),
        );

    const reducedFontColor = Color(0xFFf5ddaf);

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Porsche AG',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: reducedFontColor,
                      ),
                ),
                const SizedBox(height: 10),
                //hour:minute:second timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timerService.hours.twoDigits(),
                      style: timerTextTheme,
                    ),
                    Text(
                      ':',
                      style: timerTextTheme,
                    ),
                    Text(
                      timerService.minutes.twoDigits(),
                      style: timerTextTheme,
                    ),
                    Text(
                      ':',
                      style: timerTextTheme,
                    ),
                    Text(
                      timerService.seconds.twoDigits(),
                      style: timerTextTheme?.copyWith(
                        color: const Color(0xFFe7b480),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Work time 40 hours • Your daily rate 145€',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: reducedFontColor,
                      ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(),
        ),
      ],
    ));
  }
}

extension on int {
  String twoDigits() => toString().padLeft(2, '0');
}
