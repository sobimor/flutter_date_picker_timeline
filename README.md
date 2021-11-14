# Flutter Date Picker Timeline
![Flutter Date Picker Timeline Banner](https://raw.githubusercontent.com/sobimor/flutter_date_picker_timeline/master/repo_files/images/banner.png)
[![pub package](https://img.shields.io/pub/v/flutter_date_picker_timeline.svg)](https://pub.dartlang.org/packages/flutter_date_picker_timeline)

💥 Gregorian and Jalali customizable date picker as a horizontal timeline  💥

<p align="center">
<img src="https://raw.githubusercontent.com/sobimor/flutter_date_picker_timeline/master/repo_files/images/screenshot_ios.png" width="300" alt="Screenshot iOS">
&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://raw.githubusercontent.com/sobimor/flutter_date_picker_timeline/master/repo_files/images/screenshot_android.jpg" width="300" alt="Screenshot android">
</p><br>

# Let's get started

### 1 - Depend on it

##### Add it to your package's pubspec.yaml file

```yml
dependencies:
  flutter_date_picker_timeline: ^0.3.3
```


### 2 - Install it

##### Install packages from the command line
```sh
flutter pub get
```


### 3 - Import it

##### Import it to your project
```dart
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
```


## How to use?
##### Use the `FlutterDatePickerTimeline` Widget

```dart
FlutterDatePickerTimeline(
    startDate: DateTime(2020, 07, 01),
    endDate: DateTime(2020, 12, 30),
    initialSelectedDate: DateTime(2020, 07, 24),
    onSelectedDateChange: (DateTime dateTime) {
        print(dateTime);
      },
    )
```

##### Constructor:

```dart
FlutterDatePickerTimeline({
    Key key,
    // Determines the [FlutterDatePickerTimeline] mode.
    this.calendarMode = CalendarMode.gregorian,
    // The first date of [FlutterDatePickerTimeline].
    @required this.startDate,
    // The last date of [FlutterDatePickerTimeline].
    @required this.endDate,
    // Initially selected date.
    this.initialSelectedDate,
    // Initially focused date(If nothing is provided, a [initialSelectedDate] will be used).
    this.initialFocusedDate,
    // Used for setting the textDirection of [FlutterDatePickerTimeline].
    this.textDirection,
    // Used for setting the width of selected items.
    this.selectedItemWidth = 170,
    // Used for setting the width of unselected items.
    this.unselectedItemWidth = 38,
    // Used for setting the height of selected and unselected items.
    this.itemHeight = 38,
    // Used for setting the radius of selected and unselected items background.
    this.itemRadius = 10,
    // Used for setting the padding of [ListView].
    this.listViewPadding = const EdgeInsets.only(right: 5.5, left: 5.5),
    // Used for setting the margin of selected items.
    this.selectedItemMargin = const EdgeInsets.only(right: 5.5, left: 5.5),
    // Used for setting the margin of unselected items.
    this.unselectedItemMargin = const EdgeInsets.only(right: 5.5, left: 5.5),
    // Used for setting the color of selected items background.
    this.selectedItemBackgroundColor = const Color(0xFF2B2C30),
    // Used for setting the color of unselected items background.
    this.unselectedItemBackgroundColor = Colors.white,
    // Used for setting the style of selected items [Text].
    this.selectedItemTextStyle,
    // Used for setting the style of unselected items [Text].
    this.unselectedItemTextStyle,
    // Called whenever any date gets selected.
    @required this.onSelectedDateChange,
  }) : super(key: key);
```

## Props
| props                   | types           | defaultValues                                                                                                     |
| :---------------------- | :-------------: | :---------------------------------------------------------------------------------------------------------------: |
| calendarMode        | `CalendarMode`        | CalendarMode.gregorian |
| startDate       | `DateTime`     | |
| endDate           | `DateTime`     | |
| initialSelectedDate       | `DateTime?`     | |
| initialFocusedDate | `DateTime?`         | If nothing is provided, a [initialSelectedDate] will be used |
| textDirection       | `TextDirection?`     | If nothing is provided, a [calendarMode] will be used. (CalendarMode.gregorian -> TextDirection.ltr , CalendarMode.jalali -> TextDirection.rtl) |
| selectedItemWidth       | `double`     | 170 |
| unselectedItemWidth | `double`         | 38 |
| itemHeight       | `double`     | 38 |
| itemRadius | `double`         | 10 |
| listViewPadding       | `EdgeInsets`     | const EdgeInsets.only(right: 5.5, left: 5.5) |
| selectedItemMargin | `EdgeInsets`         | const EdgeInsets.only(right: 5.5, left: 5.5) |
| unselectedItemMargin       | `EdgeInsets`     | const EdgeInsets.only(right: 5.5, left: 5.5) |
| selectedItemBackgroundColor | `Color`         | const Color(0xFF2B2C30) |
| unselectedItemBackgroundColor       | `Color`     | Colors.white |
| selectedItemTextStyle | `TextStyle?`         | TextStyle(fontFamily: widget.calendarMode == CalendarMode.gregorian ? 'nunito' : 'dana', package: 'flutter_date_picker_timeline', color: widget.unselectedItemBackgroundColor) |
| unselectedItemTextStyle       | `TextStyle?`     | TextStyle(fontFamily: widget.calendarMode == CalendarMode.gregorian ? 'nunito' : 'dana', package: 'flutter_date_picker_timeline', color: widget.selectedItemBackgroundColor) |
| onSelectedDateChange | `DateChangeListener`         | |