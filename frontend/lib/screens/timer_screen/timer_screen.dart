import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/timer_service.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerService = ref.watch(timerProvider);

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Timer',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 20),
                //hour:minute:second timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timerService.hours.twoDigits(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      ':',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      timerService.minutes.twoDigits(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      ':',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      timerService.seconds.twoDigits(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    ));
  }
}

extension on int {
  String twoDigits() => toString().padLeft(2, '0');
}
