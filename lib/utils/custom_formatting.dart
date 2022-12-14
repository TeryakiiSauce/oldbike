///
/// This file includes extra globally accessible functions that might be useful when trying to format dates, numbers, etc.
/// === === === === ===

import 'package:intl/intl.dart';

class CustomFormat {
  /// Returns a string number in *one* decimal place if the passed number is between 0 & 10 (0-9). Numbers after `9.9` are formatted to have no decimal places. If the number passed is greater than `99.9`, '99+' will be returned.
  static String getShortNumber(double num) {
    String result = '';

    if (num > 99.9) {
      result = '99+';
    } else if (num > 9.9) {
      result = num.toStringAsFixed(0);
    } else if (num < 0.0) {
      result = '0.0';
    } else {
      result = num.toStringAsFixed(1);
    }

    return result;
  }

  /// Returns a string number with a custom decimal place (default is zero).
  static String getFormattedNumber(double num, {int decimalPlace = 0}) {
    return num.toStringAsFixed(decimalPlace);
  }

  /// Formats the date passed & returns a `String` date in the following format: `MMM dd, yyyy - HH:mm`
  ///
  /// Example: `Nov 16, 2022 - 02:07`.
  static String getFormattedDate(DateTime date) {
    // Reference: https://stackoverflow.com/a/16126580
    DateFormat formatter = DateFormat('MMM dd, yyyy - HH:mm');
    return formatter.format(date);
  }
}
