import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:butter/services/HabitService.dart';
import 'package:butter/utils/Color.dart';
import '../../../models/Habit.dart';
import '../index.dart';

void showCalendarView(BuildContext context, Habit item) {
  // List<String> data = AppConfig.languageSupports.keys.toList();
  showCupertinoModalPopup(
      context: context, builder: (context) => CalendarView(habit: item));
}

class CalendarView extends ConsumerStatefulWidget {
  final Habit habit;
  const CalendarView({Key? key, required this.habit}) : super(key: key);

  @override
  ConsumerState<CalendarView> createState() => _CalendarView(habit: habit);
}

final DateTime today = DateTime.now();

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
    Locale? l = Get.locale;
    return Material(
      child: Container(
        height: 435,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
        color: Color(0xff292929),
        child: CalendarCarousel<Event>(
          weekendTextStyle: TextStyle(
            color: Colors.white,
          ),
          daysTextStyle: TextStyle(color: Colors.white),
          weekdayTextStyle: TextStyle(color: Colors.white),
          onDayPressed: (DateTime date, List<Event> events) async {
            if (date.isBefore(today)) {
              final Iterable<DateTime>? checkItem = habit.dates
                  ?.where((element) => DateUtils.isSameDay(element, date));
              final bool exsixted = checkItem?.isNotEmpty ?? false;

              await HabitService.check(habit, exsixted, date);
              ref.invalidate(habitProvider);
            } else {
              Fluttertoast.showToast(
                  msg: "checkAfterToday".tr,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color(0xff343434),
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          // weekFormat: true,
          height: 600.0,
          // pageScrollPhysics: ScrollPhysics(),
          showOnlyCurrentMonthDate: true,
          // onDayPressed: () {},
          // showIconBehindDayText: true,
          firstDayOfWeek: 1,
          // selectedDateTime: DateTime.now(),
          // maxSelectedDate: DateTime.now(),
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
            final Iterable<DateTime>? checkItem = habit.dates
                ?.where((element) => DateUtils.isSameDay(element, day));
            final bool exsixted = checkItem?.isNotEmpty ?? false;
            return buildCheckItem(habit, day, exsixted);
          },
          locale: l?.languageCode ?? 'zh',
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
    final Color checkedColor = !day.isAfter(today)
        ? HexColor.getHabitColor(habit, checked)
        : Colors.transparent;
    return Center(
        child: Column(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          child: Text(
            day.day.toString(),
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: checkedColor, borderRadius: BorderRadius.circular(50)),
        ),
        SizedBox(
          height: 6,
        ),
        DateUtils.isSameDay(today, day)
            ? Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
              )
            : SizedBox(
                width: 2,
                height: 1,
              )
      ],
    ));
  }
}
