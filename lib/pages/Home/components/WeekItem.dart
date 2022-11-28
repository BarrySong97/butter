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
      height: 105,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buildInfo(), _buildWeek()],
      ),
      decoration: BoxDecoration(
          color: const Color(0xff292929),
          borderRadius: BorderRadius.circular(6)),
    );
  }

  Widget _buildInfo() {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              'Meditation',
              style: TextStyle(
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
        children: weekData.map((e) => _buildWeekItem(e, 1)).toList());
  }

  Widget _buildWeekItem(String week, int date) {
    return Container(
        child: Column(children: [
      Text(
        week.tr,
        style: TextStyle(
            color: Color(0xff686868),
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 8,
      ),
      Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        child: Text(
          date.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Color(0xff5666f0)),
      )
    ]));
  }
}
