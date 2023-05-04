import 'package:commons_flutter/commons_flutter.dart';

String getVacationDisplayString(int start, int end) {
  String startString = dayToDisplayString(
      Day.fromDateTime(DateTime.fromMillisecondsSinceEpoch(start)));
  String endString = dayToDisplayString(
      Day.fromDateTime(DateTime.fromMillisecondsSinceEpoch(end)));

  String weekDay = startString.split(" ")[0];
  startString = "${weekDay.substring(0, 3)}. ${startString.split(" ")[1]}";

  weekDay = endString.split(" ")[0];
  endString = "${weekDay.substring(0, 3)}. ${endString.split(" ")[1]}";

  return "$startString - $endString";
}

String dayToDisplayString(Day day) {
  String returnString = "";
  switch (day.weekday) {
    case 1:
      returnString = "Monday";
      break;
    case 2:
      returnString = "Tuesday";
      break;
    case 3:
      returnString = "Wednesday";
      break;
    case 4:
      returnString = "Thursday";
      break;
    case 5:
      returnString = "Friday";
      break;
    case 6:
      returnString = "Saturday";
      break;
    case 7:
      returnString = "Sunday";
      break;
  }

  return "$returnString ${day.day.twoDigits()}.${day.month.twoDigits()}";
}

extension on int {
  String twoDigits() => toString().padLeft(2, '0');
}
