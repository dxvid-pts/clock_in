import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerProvider =
    ChangeNotifierProvider.family<TimerNotifier, int>((ref, hoursPerDay) {
  return TimerNotifier(hoursPerDay);
});

class TimerNotifier extends ChangeNotifier {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  Timer? _t;

  bool get wasRunningOnce => _t != null;
  bool get isRunning => _t?.isActive ?? false;

  DateTime? startTime;

  TimerNotifier(int hoursPerDay) {
    hours = hoursPerDay;
  }

  void startTimer() {
    //check if currently running
    if (isRunning) {
      return;
    }

    //set start time
    startTime = DateTime.now();

    //periodically update the timer every second
    _t = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds < 59) {
        seconds++;
      } else {
        seconds = 0;
        if (minutes < 59) {
          minutes++;
        } else {
          minutes = 0;
          hours++;
        }
      }
      notifyListeners();
    });

    //notify listeners to update that the timer has started
    notifyListeners();
  }

  void pauseTimer() {
    _t?.cancel();
    startTime = null;
    notifyListeners();
  }

  void resetTimer() {
    _t?.cancel();
    _t = null;
    hours = 0;
    minutes = 0;
    seconds = 0;
    startTime = null;
    notifyListeners();
  }
}
