import 'dart:math';
import 'package:intl/intl.dart';
import 'package:weather/utils/svgs.dart';

class AppHelpers {
  static String greetingMessage() {
    final timeNow = DateTime.now().hour;

    if (timeNow < 12) {
      return 'Good Morning';
    } else if ((timeNow >= 12) && (timeNow < 16)) {
      return 'Good Afternoon';
    } else if ((timeNow >= 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  // E.G 8:54 PM
  static String convertTimestampToDateTime(int? timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);
   // final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('E, MMM d');
    // final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(dateTime);
    return formatted;
  }

  // E.G 8:54 PM
  static String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('h:mm: a');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  // E.G 16-OCT-23
  static String convertNamedDateDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('E, MMM d');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String generateUniqueReference() {
    var dateFormatter = DateFormat('ddMMyykkmmssss');
    try {
      return 'A${dateFormatter.format(DateTime.now())}${Random.secure().nextInt(10000)}';
    } catch (e) {
      return 'A${dateFormatter.format(DateTime.now())}${Random().nextInt(10000)}';
    }
  }

  static String getWeatherImage({required int? group}) {
    String numberString = group.toString();
    if (numberString.startsWith('5')) {
      return rainIconSVG;
    }
    if (numberString.startsWith('8')) {
      return cloudyIconSVG;
    }
    if (numberString.startsWith('3')) {
      return drizzleRainIcon;
    }
    if (numberString.startsWith('2')) {
      return stormIconSVG;
    }
    if (numberString.startsWith('6')) {
      return snowIconSVG;
    }

    return sunIconSVG;
  }
}
