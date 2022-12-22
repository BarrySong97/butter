import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:butter/models/Habit.dart';
import 'package:butter/pages/Home/components/Calendar.dart';
import 'package:butter/pages/Home/index.dart';

import '../../../utils/Color.dart';

List<String> weekData = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

List<DateTime> getThisWeek(List<DateTime> list) {
  final DateTime d = DateTime.now();
  int weekDay = d.weekday;
  final DateTime firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));
  final DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

  final List<DateTime> res = list
      .where((element) =>
          element.isAfter(firstDayOfWeek) && element.isBefore(lastDayOfWeek) ||
          DateUtils.isSameDay(firstDayOfWeek, element) ||
          DateUtils.isSameDay(lastDayOfWeek, element))
      .toList();
  return res;
}

List<DateTime> getThisWeekDays() {
  final DateTime d = DateTime.now();
  int weekDay = d.weekday;
  final DateTime firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));
  final DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
  final List<DateTime> dateList = [firstDayOfWeek];
  for (int i = 1; i <= 6; i++) {
    dateList.add(firstDayOfWeek.add(Duration(days: i)));
  }
  return dateList;
}

class WeekItem extends StatelessWidget {
  // final HabbitWeekItem item;
  final Habit item;
  late List<DateTime> checkedDates;
  List<DateTime> weekDays = getThisWeekDays();
  Function(DateTime date, bool checked) onToggle;

  WeekItem({Key? key, required this.item, required this.onToggle})
      : super(key: key) {
    checkedDates = getThisWeek(item.dates ?? []);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => {showCalendarView(context, item)},
      onTap: () => {Get.toNamed("/detail/${item.id}", arguments: item)},
      child: Container(
        height: 105,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_buildInfo(), _buildWeek()],
        ),
        decoration: BoxDecoration(
            color: const Color(0xff292929),
            borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              item.name ?? '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ));
  }

  Widget _buildWeek() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekDays
            .asMap()
            .entries
            .map((e) => _buildWeekItem(e.value, e.key))
            .toList());
  }

  Widget _buildWeekItem(DateTime date, int idx) {
    final String day = date.day.toString();
    final bool checked = checkedDates
        .where((element) => DateUtils.isSameDay(date, element))
        .isNotEmpty;

    final Color checkedColor = HexColor.getHabitColor(item, checked);

    return Container(
        child: Column(children: [
      Text(
        weekData[idx].tr,
        style: const TextStyle(
            color: Color(0xff686868),
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 8,
      ),
      GestureDetector(
        onTap: () {
          if (date.day <= DateTime.now().day) {
            onToggle(date, checked);
          } else {
            Fluttertoast.showToast(
                msg: "checkAfterToday".tr,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: checkedColor,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: checkedColor),
          child: Text(
            day,
            style: const TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ),
      )
    ]));
  }
}
