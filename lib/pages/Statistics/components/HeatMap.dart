import 'package:flutter/material.dart';

import 'HeatMap/heatmap_calendar.dart';
import 'HeatMap/time_utils.dart';

class HeatMap extends StatelessWidget {
  final int year;
  const HeatMap({required this.year});
  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      year: year,
      input: [
        TimeUtils.removeTime(DateTime.now()),
      ],
      colorThresholds: {
        1: Colors.blue,
      },
      weekDaysLabels: [
        'M',
        'T',
        'W',
        'T',
        'F',
        'S',
        'S',
      ],
      monthsLabels: [
        "",
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ],
      squareSize: 14.0,
      textOpacity: 1,
      labelTextColor: Colors.blueGrey,
      dayTextColor: Colors.blue,
    );
  }
}
