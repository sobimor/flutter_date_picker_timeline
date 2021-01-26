import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/src/models/enums/calendar_mode.dart';
import 'package:flutter_date_picker_timeline/src/utils/ui/custom_scroll_behavior.dart';
import 'package:flutter_date_picker_timeline/src/widgets/item/date_picker_item_unselected.dart';
import 'package:flutter_date_picker_timeline/src/widgets/item/date_picker_item_selected.dart';
import 'package:flutter_date_picker_timeline/src/utils/date_helper_extension.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

/// Callback exposing currently selected date.
typedef DateChangeListener = Function(DateTime date);

/// Gregorian and Jalali customizable date picker as a horizontal timeline
class FlutterDatePickerTimeline extends StatefulWidget {
  FlutterDatePickerTimeline({
    Key key,
    this.calendarMode = CalendarMode.gregorian,
    this.textDirection,
    @required this.startDate,
    @required this.endDate,
    this.initialSelectedDate,
    this.initialFocusedDate,
    this.selectedItemWidth = 170,
    this.unselectedItemWidth = 38,
    this.itemHeight = 38,
    this.itemRadius = 10,
    this.listViewPadding = const EdgeInsets.only(right: 5.5, left: 5.5),
    this.selectedItemMargin = const EdgeInsets.only(right: 5.5, left: 5.5),
    this.unselectedItemMargin = const EdgeInsets.only(right: 5.5, left: 5.5),
    this.selectedItemBackgroundColor = const Color(0xFF2B2C30),
    this.unselectedItemBackgroundColor = Colors.white,
    this.selectedItemTextStyle,
    this.unselectedItemTextStyle,
    @required this.onSelectedDateChange,
  })  : assert(startDate != null),
        assert(endDate != null),
        assert(!startDate.isSameDate(endDate), "Start and end dates must not be the same!"),
        assert(endDate.isAfter(startDate), "End date must not be before start date!"),
        assert(initialSelectedDate == null || initialSelectedDate.isInRange(startDate, endDate),
            "The initialSelectedDate must be in the start and end date range!"),
        assert(initialFocusedDate == null || initialFocusedDate.isInRange(startDate, endDate),
            "The initialFocusedDate must be in the start and end date range!"),
        super(key: key);

  /// Determines the [FlutterDatePickerTimeline] mode.
  ///
  /// Defaults to [CalendarMode.gregorian]
  final CalendarMode calendarMode;

  // if null then will check the calendar mode
  // Need it in arabice language

  final TextDirection textDirection;

  /// The first date of [FlutterDatePickerTimeline].
  final DateTime startDate;

  /// The last date of [FlutterDatePickerTimeline].
  final DateTime endDate;

  /// Initially selected date. Usually it will be `DateTime.now()`.
  final DateTime initialSelectedDate;

  /// Initially focused date. Usually it will be `DateTime.now()`.
  ///
  /// If nothing is provided, a [initialSelectedDate] will be used.
  final DateTime initialFocusedDate;

  /// Used for setting the width of selected items.
  ///
  /// Defaults to 170
  final double selectedItemWidth;

  /// Used for setting the width of unselected items.
  ///
  /// Defaults to 38
  final double unselectedItemWidth;

  /// Used for setting the height of selected and unselected items.
  ///
  /// Defaults to 38
  final double itemHeight;

  /// Used for setting the radius of selected and unselected items background.
  ///
  /// Defaults to 10
  final double itemRadius;

  /// Used for setting the padding of [ListView].
  ///
  /// Defaults to [const EdgeInsets.only(right: 5.5, left: 5.5)]
  final EdgeInsets listViewPadding;

  /// Used for setting the margin of selected items.
  ///
  /// Defaults to [const EdgeInsets.only(right: 5.5, left: 5.5)]
  final EdgeInsets selectedItemMargin;

  /// Used for setting the margin of unselected items.
  ///
  /// Defaults to [const EdgeInsets.only(right: 5.5, left: 5.5)]
  final EdgeInsets unselectedItemMargin;

  /// Used for setting the color of selected items background.
  ///
  /// Defaults to [const Color(0xFF2B2C30)]
  final Color selectedItemBackgroundColor;

  /// Used for setting the color of unselected items background.
  ///
  /// Defaults to [Colors.white]
  final Color unselectedItemBackgroundColor;

  /// Used for setting the style of selected items [Text].
  ///
  /// Defaults to [TextStyle(
  ///       fontFamily: widget.calendarMode == CalendarMode.gregorian ? 'nunito' : 'dana',
  ///       package: 'flutter_date_picker_timeline',
  ///       color: widget.unselectedItemBackgroundColor)]
  final TextStyle selectedItemTextStyle;

  /// Used for setting the style of unselected items [Text].
  ///
  /// Defaults to [TextStyle(
  ///       fontFamily: widget.calendarMode == CalendarMode.gregorian ? 'nunito' : 'dana',
  ///       package: 'flutter_date_picker_timeline',
  ///       color: widget.selectedItemBackgroundColor)]
  final TextStyle unselectedItemTextStyle;

  /// Called whenever any date gets selected.
  final DateChangeListener onSelectedDateChange;

  @override
  _FlutterDatePickerTimelineState createState() => _FlutterDatePickerTimelineState();
}

class _FlutterDatePickerTimelineState extends State<FlutterDatePickerTimeline> {
  AutoScrollController _scrollController;
  ValueNotifier<DateTime> _selectedDateValueNotifier;

  get _defaultSelectedItemTextStyle => TextStyle(
      fontFamily: widget.calendarMode == CalendarMode.gregorian ? 'nunito' : 'dana',
      package: 'flutter_date_picker_timeline',
      color: widget.unselectedItemBackgroundColor);

  get _defaultUnselectedItemTextStyle => TextStyle(
      fontFamily: widget.calendarMode == CalendarMode.gregorian ? 'nunito' : 'dana',
      package: 'flutter_date_picker_timeline',
      color: widget.selectedItemBackgroundColor);

  @override
  void initState() {
    _scrollController = AutoScrollController(
      axis: Axis.horizontal,
    );
    _selectedDateValueNotifier = ValueNotifier<DateTime>(widget.initialSelectedDate);
    if (widget.initialFocusedDate != null || widget.initialSelectedDate != null) {
      _scrollToInitialFocusedDate();
    }
    super.initState();
  }

  @override
  void dispose() {
    _selectedDateValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection == null
          ? widget.calendarMode == CalendarMode.jalali
              ? TextDirection.rtl
              : TextDirection.ltr
          : widget.textDirection,
      child: Container(
        height: widget.itemHeight,
        child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: ValueListenableBuilder<DateTime>(
                valueListenable: _selectedDateValueNotifier,
                builder: (BuildContext context, DateTime selectedDate, Widget child) {
                  return ListView.builder(
                      padding: widget.listViewPadding,
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: widget.endDate.dateDifference(widget.startDate) + 1,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime itemDate = widget.startDate.add(Duration(days: index));
                        return AutoScrollTag(
                            key: ValueKey(index),
                            controller: _scrollController,
                            index: index,
                            child: (_isDatePickerItemSelected(itemDate, selectedDate))
                                ? DatePickerItemSelected(
                                    date: itemDate,
                                    calendarMode: widget.calendarMode,
                                    width: widget.selectedItemWidth,
                                    itemRadius: widget.itemRadius,
                                    itemMargin: widget.selectedItemMargin,
                                    itemBackgroundColor: widget.selectedItemBackgroundColor,
                                    textStyle: widget.selectedItemTextStyle ??
                                        _defaultSelectedItemTextStyle,
                                  )
                                : DatePickerItemUnselected(
                                    date: itemDate,
                                    calendarMode: widget.calendarMode,
                                    width: widget.unselectedItemWidth,
                                    itemRadius: widget.itemRadius,
                                    itemMargin: widget.unselectedItemMargin,
                                    itemBackgroundColor: widget.unselectedItemBackgroundColor,
                                    textStyle: widget.unselectedItemTextStyle ??
                                        _defaultUnselectedItemTextStyle,
                                    onPressed: () {
                                      _setSelectedDate(itemDate);
                                      _scrollToIndex(index);
                                    },
                                  ));
                      });
                })),
      ),
    );
  }

  bool _isDatePickerItemSelected(DateTime itemDate, DateTime selectedDate) {
    if (selectedDate == null) return false;
    return itemDate.dateDifference(selectedDate) == 0;
  }

  _setSelectedDate(DateTime date) {
    _selectedDateValueNotifier.value = date;
    widget.onSelectedDateChange(date);
  }

  _scrollToIndex(index) async {
    await _scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
  }

  _scrollToInitialFocusedDate() async {
    final DateTime initialFocusedDate = widget.initialFocusedDate ?? widget.initialSelectedDate;
    _scrollToIndex(initialFocusedDate.dateDifference(widget.startDate));
  }
}
