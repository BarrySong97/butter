import 'package:flutter/material.dart';

import 'HeatMap/heatmap_calendar.dart';
import 'HeatMap/time_utils.dart';

class HeatMap extends StatelessWidget {
  const HeatMap();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HeatMapCalendar(
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
