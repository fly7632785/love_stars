import 'package:intl/intl.dart';

class TimeUtil {
  static String timeFormatter = "yyy-MM-dd HH:mm";

  static String dateFormatter = "yyy-MM-dd";


  static String formatDate(int time) {
    return DateFormat(dateFormatter).format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String formatTime(int time) {
    return DateFormat(timeFormatter).format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String format(DateTime date) {
    return DateFormat(dateFormatter).format(date);
  }

}
