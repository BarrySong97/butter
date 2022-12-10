import 'package:flutter/material.dart';

import 'HeatMap/heatmap_calendar.dart';
import 'HeatMap/time_utils.dart';

class HeatMap extends StatelessWidget {
  const HeatMap();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HeatMapCalendar(
      input: {
        TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 2))): 5,
        TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 1))): 35,
        TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 0))): 14,
        TimeUtils.removeTime(DateTime.now()): 4,
      },
      colorThresholds: {
        1: Colors.blue,
      },
      weekDaysLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
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
