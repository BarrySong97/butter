import 'package:flutter/material.dart';

import 'HeatMap/heatmap_calendar.dart';
import 'HeatMap/time_utils.dart';

class HeatMap extends StatelessWidget {
  final int year;
  final List<DateTime> dates;
  final Color color;
  const HeatMap({required this.year, required this.dates, required this.color});
  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      year: year,
      input: dates,
      colorThresholds: {
        1: color,
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
