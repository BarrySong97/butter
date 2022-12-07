import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipomo/models/Habit.dart';
import 'package:lipomo/pages/Home/components/Calendar.dart';
import 'package:lipomo/pages/Home/index.dart';

List<String> weekData = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

List<CheckedItem> getThisWeek(List<CheckedItem> list) {
  final DateTime d = DateTime.now();
  int weekDay = d.weekday;
  final DateTime firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));
  final DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
  final bool isb = list[6].date?.isBefore(lastDayOfWeek) ?? false;

  final List<CheckedItem> res = list
      .where((element) =>
          ((element.date?.isAfter(firstDayOfWeek) ?? false) &&
              (element.date?.isBefore(lastDayOfWeek) ?? false)) ||
          DateUtils.isSameDay(firstDayOfWeek, element.date) ||
          DateUtils.isSameDay(lastDayOfWeek, element.date))
      .toList();
  return res;
}

class WeekItem extends StatelessWidget {
  // final HabbitWeekItem item;
  final Habit item;
  late List<CheckedItem> dates;
  Function onToggle;

  WeekItem({Key? key, required this.item, required this.onToggle})
      : super(key: key) {
    if (item.dates != null) {
      dates = getThisWeek(item.dates ?? []);
    }
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
        children: weekData
            .asMap()
            .entries
            .map((e) => _buildWeekItem(e.value, 1, e.key))
            .toList());
  }

  Widget _buildWeekItem(String week, int date, int idx) {
    final CheckedItem item = dates[idx];
    final String day = item.date?.day.toString() ?? '';
    final bool isChecked = item.checked ?? false;

    return Container(
        child: Column(children: [
      Text(
        week.tr,
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
          item.checked = !(item.checked ?? false);
          onToggle();
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
              color: isChecked ? Color(0xff5666f0) : Color(0xff343434)),
        ),
      )
    ]));
  }
}
