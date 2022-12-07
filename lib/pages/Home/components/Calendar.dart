import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import '../../../models/Habit.dart';
import '../index.dart';

void showCalendarView(BuildContext context, Habit item) {
  // List<String> data = AppConfig.languageSupports.keys.toList();
  showCupertinoModalPopup(
      context: context, builder: (context) => CalendarView(habit: item));
}

class CalendarView extends ConsumerStatefulWidget {
  final Habit habit;
  CalendarView({Key? key, required this.habit}) : super(key: key);

  @override
  ConsumerState<CalendarView> createState() => _CalendarView(habit: habit);
}

class _CalendarView extends ConsumerState<CalendarView> {
  final Habit habit;

  _CalendarView({required this.habit});
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(habitProvider);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      child: Container(
        height: 400,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
        color: Color(0xff292929),
        child: CalendarCarousel<Event>(
          weekendTextStyle: TextStyle(
            color: Colors.white,
          ),
          daysTextStyle: TextStyle(color: Colors.white),
          weekdayTextStyle: TextStyle(color: Colors.white),
          // weekFormat: true,
          height: 600.0,
          // pageScrollPhysics: ScrollPhysics(),
          showOnlyCurrentMonthDate: true,
          // onDayPressed: () {},
          // showIconBehindDayText: true,
          firstDayOfWeek: 1,
          // selectedDateTime: DateTime.now(),
          maxSelectedDate: DateTime.now(),
          locale: 'zh',
          // prevMonthDayBorderColor: Colors.white,
          // weekFormat: false,
          todayButtonColor: Colors.transparent,
        ),
      ),
    );
  }
}
