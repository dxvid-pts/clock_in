import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerProvider =
    ChangeNotifierProvider.family<TimerNotifier, int>((ref, hoursPerDay) {
  return TimerNotifier(hoursPerDay);
});

class TimerNotifier extends ChangeNotifier {
  final int hoursPerDay;

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  Timer? _t;

  bool get wasRunningOnce => _t != null;
  bool get isRunning => _t?.isActive ?? false;
  bool hasReachedZero = false;

  DateTime? startTime;

  TimerNotifier(this.hoursPerDay) {
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
      //count down from the start time to 00:00:00; if the timer has reached 00:00:00, then count up

      if (!hasReachedZero) {
        if (seconds > 0) {
          seconds--;
        } else {
          if (minutes > 0) {
            minutes--;
            seconds = 59;
          } else {
            if (hours > 0) {
              hours--;
              minutes = 59;
              seconds = 59;
            } else {
              //timer has reached 00:00:00, now reverse and count up
              hasReachedZero = true;
              notifyListeners();
            }
          }
        }
      } else {
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
    hours = hoursPerDay;
    minutes = 0;
    seconds = 0;
    startTime = null;
    hasReachedZero = false;
    notifyListeners();
  }
}
