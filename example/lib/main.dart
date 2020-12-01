import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter date picker timeline example',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 11, bottom: 11),
                decoration: BoxDecoration(color: const Color(0xFFF5F5F5)),
                child: FlutterDatePickerTimeline(
                  startDate: DateTime(2020, 07, 01),
                  endDate: DateTime(2020, 12, 30),
                  initialSelectedDate: DateTime(2020, 07, 24),
                  onSelectedDateChange: (DateTime dateTime) {
                    print(dateTime);
                  },
                )),
          )),
    );
  }
}
