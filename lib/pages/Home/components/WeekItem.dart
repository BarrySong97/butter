import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipomo/models/Habit.dart';
import 'package:lipomo/pages/Home/components/Calendar.dart';
import 'package:lipomo/pages/Home/index.dart';

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
    final DateTime? checkDate =
        checkedDates.isNotEmpty ? checkedDates[idx] : null;
    final String day = date.day.toString();
    final bool checked = DateUtils.isSameDay(date, checkDate);

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
          onToggle(date, checked);
        },
        child: Container(
          width: 18,
          height: 18,
          alignment: Alignment.center,
          child: Text(
            day,
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: checked ? Color(0xff5666f0) : Color(0xff343434)),
        ),
      )
    ]));
  }
}
