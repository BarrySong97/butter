import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:lipomo/services/HabitService.dart';
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
          onDayPressed: (DateTime date, List<Event> events) async {
            habit.dates?.add(date);
            await HabitService.update(habit);
            ref.invalidate(habitProvider);
            // this.setState(() => _currentDate = date);
          },
          // weekFormat: true,
          height: 600.0,
          // pageScrollPhysics: ScrollPhysics(),
          showOnlyCurrentMonthDate: true,
          // onDayPressed: () {},
          // showIconBehindDayText: true,
          firstDayOfWeek: 1,
          // selectedDateTime: DateTime.now(),
          maxSelectedDate: DateTime.now(),
          customDayBuilder: (
            /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
          ) {
            /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
            /// This way you can build custom containers for specific days only, leaving rest as default.

            // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
            final DateTime? checkItem = habit.dates
                ?.where((element) => DateUtils.isSameDay(element, day))
                .first;
            return buildCheckItem(habit, day, checkItem != null);
          },
          locale: 'zh',
          // prevMonthDayBorderColor: Colors.white,
          // weekFormat: false,
          todayButtonColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget buildCheckItem(
    Habit habit,
    DateTime day,
    bool checked,
  ) {
    return GestureDetector(
      onTap: () {
        HabitService.check(habit, checked, day);
        ref.invalidate(habitProvider);
      },
      child: Center(
          child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          day.day.toString(),
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: checked ? Color(0xff4552c0) : Colors.transparent,
            borderRadius: BorderRadius.circular(50)),
      )),
    );
  }
}
