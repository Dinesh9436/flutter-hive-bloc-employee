// ignore_for_file: unnecessary_new

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/select_date_cubit.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/select_to_date_cubit.dart';

import 'package:flutter_employee_hive_bloc/widgets/button.dart';
import 'package:intl/intl.dart' show DateFormat;

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({Key? key, required this.isFromDate}) : super(key: key);
  final bool isFromDate;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _CustomDatePickerState createState() => new _CustomDatePickerState();
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return this.add(
      Duration(
        days: (day - this.weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();

  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  String selectedDate = "today";
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    /// Example with custom icon

    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      headerTextStyle:
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      selectedDayButtonColor: Colors.blue,
      iconColor: Colors.black,
      todayBorderColor: Colors.blue,
      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      weekdayTextStyle: TextStyle(
        color: Colors.black,
      ),
      // thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      // markedDatesMap: _markedDateMap,
      height: width * 0.9,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: true,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.white,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      nextDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CancelSaveButton(
                onTap: () {
                  _currentDate2 = DateTime.now();
                  selectedDate = "today";
                  setState(() {});
                  print(selectedDate);
                },
                title: "Today",
                buttonColor: selectedDate == "today"
                    ? Theme.of(context).primaryColor
                    : Color(0xFFEDF8FF),
                titleColor: selectedDate == "today"
                    ? Color(0xFFEDF8FF)
                    : Theme.of(context).primaryColor,
                width: width * 0.4,
              ),
              CancelSaveButton(
                onTap: () {
                  DateTime today = DateTime.now();

                  _currentDate2 = today.next(DateTime.monday);
                  selectedDate = "nextMonday";
                  setState(() {});
                  print(selectedDate);
                },
                title: "Next Monday",
                buttonColor: selectedDate == "nextMonday"
                    ? Theme.of(context).primaryColor
                    : Color(0xFFEDF8FF),
                titleColor: selectedDate == "nextMonday"
                    ? Color(0xFFEDF8FF)
                    : Theme.of(context).primaryColor,
                width: width * 0.4,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CancelSaveButton(
                onTap: () {
                  DateTime today = DateTime.now();
                  _currentDate2 = today.next(DateTime.tuesday);

                  selectedDate = "nextTuesday";
                  setState(() {});
                  print(selectedDate);
                },
                title: "Next Tuesday",
                buttonColor: selectedDate == "nextTuesday"
                    ? Theme.of(context).primaryColor
                    : Color(0xFFEDF8FF),
                titleColor: selectedDate == "nextTuesday"
                    ? Color(0xFFEDF8FF)
                    : Theme.of(context).primaryColor,
                width: width * 0.4,
              ),
              CancelSaveButton(
                onTap: () {
                  DateTime today = DateTime.now();

                  DateTime nextWeekDay = today.add(Duration(days: 7));

                  _currentDate2 = nextWeekDay;
                  selectedDate = "nextWeekDay";
                  setState(() {});
                  print(selectedDate);
                },
                title: "After 1 Week",
                buttonColor: selectedDate == "nextWeekDay"
                    ? Theme.of(context).primaryColor
                    : Color(0xFFEDF8FF),
                titleColor: selectedDate == "nextWeekDay"
                    ? Color(0xFFEDF8FF)
                    : Theme.of(context).primaryColor,
                width: width * 0.4,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: _calendarCarouselNoHeader,
          ), //
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd().format(_currentDate2),
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: CancelSaveButton(
                      onTap: () => Navigator.of(context).pop(),
                      title: "Cancel",
                      buttonColor: Color(0xFFEDF8FF),
                      titleColor: Theme.of(context).primaryColor,
                      width: width * 0.15,
                    ),
                  ),
                  CancelSaveButton(
                    onTap: () {
                      if (widget.isFromDate)
                        BlocProvider.of<SelectDateCubit>(context)
                            .selectDate(_currentDate2)
                            .then((value) => Navigator.of(context).pop());
                      else
                        BlocProvider.of<SelectToDateCubit>(context)
                            .selectToDate(_currentDate2)
                            .then((value) => Navigator.of(context).pop());
                    },
                    title: "Save",
                    buttonColor: Theme.of(context).primaryColor,
                    titleColor: Colors.white,
                    width: width * 0.15,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
