import 'package:intl/intl.dart';

class DateTImeUtils {
  /// Formats the given [date] using the specified [pattern].
  ///
  /// If the [date] is null, it returns an empty string.
  /// Otherwise, it formats the date using the specified [pattern]
  /// and returns the formatted string.
  static String dateTimeCustomFormat(DateTime? date, String pattern) {
    if (date == null) {
      return "";
    }
    final format = DateFormat(pattern);
    return format.format(date);
  }
}
