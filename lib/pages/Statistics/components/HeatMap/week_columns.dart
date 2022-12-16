import 'dart:io';
import 'package:flutter/material.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'heatmap_day.dart';
import 'month_label.dart';
import 'time_utils.dart';

class WeekColumns extends StatelessWidget {
  final double squareSize;

  final Color labelTextColor;

  final List<DateTime> input;

  final Map<int, Color> colorThresholds;

  final double currentOpacity;

  final List<String> monthLabels;

  final Color dayTextColor;

  final int columnsToCreate;

  final DateTime date;
  final int year;

  const WeekColumns(
      {Key? key,
      required this.squareSize,
      required this.year,
      required this.labelTextColor,
      required this.input,
      required this.colorThresholds,
      required this.currentOpacity,
      required this.monthLabels,
      required this.dayTextColor,
      required this.columnsToCreate,
      required this.date})
      : super(key: key);

  /// The main logic for generating a list of columns representing a week
  /// Each column is a week having a [MonthLabel] and 7 [HeatMapDay] widgets
  List<Widget> buildWeekItems() {
    List<DateTime> dateList = getCalendarDates(year);
    int totalDays = dateList.length;
    var daysPerWeek = DateTime.daysPerWeek;
    int totalWeeks = (totalDays / daysPerWeek).ceil();
    int amount = totalDays + totalWeeks;

    // The list of columns that will be returned
    List<Widget> columns = [];

    // The list of items that will be used to form a week
    List<Widget> columnItems = [];
    List<int> months = [];

    for (int i = 0; i < amount; i++) {
      // If true, it means that it should be a label,
      // if false, it should be a HeatMapDay
      if (i % 8 == 0) {
        String month = "";
        final DateTime first = dateList.first;
        final DateTime sevenDaysAfter = first.add(const Duration(days: 6));
        if ((dateList.isNotEmpty && !months.contains(sevenDaysAfter.month)) ||
            i == 0) {
          final int monthNum = first.year != year ? 1 : sevenDaysAfter.month;
          month = monthLabels[monthNum];
          months.add(monthNum);
        }

        columnItems.add(MonthLabel(
          size: squareSize,
          textColor: labelTextColor,
          text: month,
        ));
      } else {
        DateTime currentDate = dateList.first;
        dateList.removeAt(0);

        final int value = currentDate.day;
        final bool chcked = input.firstWhereOrNull(
                (element) => DateUtils.isSameDay(element, currentDate)) !=
            null;
        HeatMapDay heatMapDay = HeatMapDay(
          value: year == currentDate.year ? value : 0,
          thresholds: colorThresholds,
          size: squareSize,
          chcked: chcked,
          currentDay: currentDate.day,
          opacity: currentOpacity,
          textColor: dayTextColor,
        );
        columnItems.add(heatMapDay);

        // If the columnsItems has a length of 8, it means it should be ended.
        if (columnItems.length == 8) {
          columns.add(Column(children: columnItems));
          columnItems = [];
        }
      }
    }

    if (columnItems.isNotEmpty) {
      columns.add(Column(children: columnItems));
    }
    return columns;
  }

  /// Creates a list of all weeks based on given [columnsAmount]
  List<DateTime> getCalendarDates(int year) {
    List<DateTime> yearDays = TimeUtils.yearDays(year);
    final DateTime first = yearDays.first;
    if (first.weekday != 1) {
      final int sub = first.weekday - 1;
      final DateTime firstDayOfWeek = first.subtract(Duration(days: sub));
      List<DateTime> extra = [];
      for (int i = 1; i <= sub; i++) {
        extra.add(first.subtract(Duration(days: i)));
      }
      yearDays = [...extra.reversed, ...yearDays];
    }
    return yearDays;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: buildWeekItems(),
      ),
    );
  }
}
