import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerProvider =
    ChangeNotifierProvider<TimerNotifier>((ref) => TimerNotifier());

class TimerNotifier extends ChangeNotifier {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  Timer? _t;

  TimerNotifier() {}

  void startTimer() {
    if (_t != null) {
      return;
    }

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
  }

  void stopTimer() {
    _t?.cancel();
    _t = null;
  }
}
