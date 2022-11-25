import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipomo/pages/Home/index.dart';

List<String> weekData = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class WeekItem extends StatelessWidget {
  // final HabbitWeekItem item;
  const WeekItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [_buildInfo(), _buildWeek()],
      ),
      decoration: BoxDecoration(
          color: const Color(0xff292929),
          borderRadius: BorderRadius.circular(2)),
    );
  }

  Widget _buildInfo() {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: const [
            Text(
              '学习',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )
          ],
        ));
  }

  Widget _buildWeek() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: weekData.map((e) => _buildWeekItem(e, 1)).toList());
  }

  Widget _buildWeekItem(String week, int date) {
    return Container(
        child: Column(children: [
      Text(
        week.tr,
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
      ),
      Text(
        date.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
      )
    ]));
  }
}
