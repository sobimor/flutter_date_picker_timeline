import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/src/utils/date_helper_extension.dart';
import 'package:flutter_date_picker_timeline/src/models/enums/calendar_mode.dart';

class DatePickerItemSelected extends StatelessWidget {
  const DatePickerItemSelected(
      {required this.date,
      required this.calendarMode,
      required this.width,
      required this.itemRadius,
      required this.itemMargin,
      required this.itemBackgroundColor,
      required this.textStyle});

  final DateTime date;
  final CalendarMode calendarMode;
  final double width;
  final double itemRadius;
  final EdgeInsets itemMargin;
  final Color itemBackgroundColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        margin: itemMargin,
        decoration: new BoxDecoration(
            color: itemBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(itemRadius))),
        child: Center(
            child: Text(
          calendarMode == CalendarMode.gregorian
              ? date.getGregorianWeekDayAndDate()
              : date.getJalaliWeekDayAndDate(),
          style: textStyle,
        )));
  }
}
