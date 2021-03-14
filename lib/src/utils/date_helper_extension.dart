import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension DateHelperExtension on DateTime {
  int dateDifference(DateTime secondDate) {
    return DateTime(this.year, this.month, this.day)
        .difference(DateTime(secondDate.year, secondDate.month, secondDate.day))
        .inDays;
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  bool isInRange(DateTime startDate, DateTime endDate) {
    return (this.isAfter(startDate) || this.isSameDate(startDate)) &&
        (this.isBefore(endDate) || this.isSameDate(endDate));
  }

  String getGregorianWeekDayAndDate() {
    final f = DateFormat('EEEE, MMM d');

    return f.format(this);
  }

  String getJalaliDay() {
    final f = Jalali.fromDateTime(this).formatter;

    return '${f.d}';
  }

  String getJalaliWeekDayAndDate() {
    final f = Jalali.fromDateTime(this).formatter;

    return '${f.wN}، ${f.d} ${f.mN}';
  }
}
