import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/src/models/enums/calendar_mode.dart';
import 'package:flutter_date_picker_timeline/src/utils/date_helper_extension.dart';

class DatePickerItemUnselected extends StatelessWidget {
  const DatePickerItemUnselected(
      {required this.date,
      required this.calendarMode,
      required this.width,
      required this.itemRadius,
      required this.itemMargin,
      required this.itemBackgroundColor,
      required this.textStyle,
      required this.onPressed});

  final DateTime date;
  final CalendarMode calendarMode;
  final double width;
  final double itemRadius;
  final EdgeInsets itemMargin;
  final Color itemBackgroundColor;
  final TextStyle textStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          margin: itemMargin,
          decoration: new BoxDecoration(
              color: itemBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(itemRadius))),
          child: Center(
              child: Text(
            calendarMode == CalendarMode.gregorian
                ? date.day.toString()
                : date.getJalaliDay(),
            style: textStyle,
          ))),
    );
  }
}
