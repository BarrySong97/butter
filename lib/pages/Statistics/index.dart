import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:butter/pages/Home/components/Calendar.dart';
import 'package:butter/pages/Statistics/components/HeatMap.dart';
import 'package:butter/pages/Statistics/components/HeatMap/time_utils.dart';
import 'package:butter/pages/Statistics/components/InfoCard.dart';
import 'package:butter/services/HabitService.dart';

import '../../models/Habit.dart';
import '../Home/components/Add.dart';
import '../Home/index.dart';
import 'components/HeatMap/week_labels.dart';
import 'components/LineChart.dart';

final int thisYear = DateTime.now().year;
List<int> threeYears = [
  thisYear,
  thisYear - 1,
  thisYear - 2,
];
final yearProvider = StateProvider.autoDispose<int>((ref) {
  return thisYear;
});
final lineProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});

class Statistics extends HookConsumerWidget {
  final Color boxColor = const Color(0xff292929);
  late ScrollController controller;
  // ScrollController(initialScrollOffset: 100);
  Habit habit = Get.arguments;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int year = ref.watch(yearProvider);
    final int lineMode = ref.watch(lineProvider);

    final List<DateTime> dates = getDateByYear(habit, year);
    final List<int> yearLineData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    final List<int> weekLineData = [0, 0, 0, 0];
    dates.forEach((element) {
      yearLineData[element.month - 1]++;
    });
    dates.forEach((element) {
      if (element.month == today.month) {
        double week = element.day / 7;
        // print(element.day / 7);
        weekLineData[week.toInt() - 1]++;
      }
    });
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String firtTrackedDate =
        formatter.format(dates.isNotEmpty ? dates.first : today);
    final String createdDate = formatter.format(habit.createdDate ?? today);
    controller =
        ScrollController(initialScrollOffset: (80 * today.month).toDouble());
    // month
    final int thisMonthNum =
        dates.where((element) => element.month == today.month).length;
    final int monthAll = TimeUtils.getMonthDays(today);
    final double monthPercent = thisMonthNum / monthAll;
    // year
    final int thisYearNum = dates.length;
    final int yearAll = TimeUtils.getYearDays(today);
    final double yearPercent = thisYearNum / yearAll;

    // all
    final int allNum = habit.dates?.length ?? 0;
    final DateTime diff = habit.dates != null && habit.dates!.isEmpty
        ? today
        : habit.dates!.first;
    final int allDays = TimeUtils.removeTime(diff)
            .difference(TimeUtils.removeTime(today))
            .inDays
            .abs() +
        1;
    final double allPercent = allNum / (allDays);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1a1a1a),
        elevation: 0,
        centerTitle: true,
        title: Text(
          habit.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 4),
        ),
        actions: buildAction(context, year, ref),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              buildDateInfoCard(firtTrackedDate, createdDate),
              const SizedBox(height: 12),
              buildMonthInfoCard(thisMonthNum, monthAll, monthPercent),
              const SizedBox(height: 12),
              buildYearInfoCard(thisYearNum, yearAll, yearPercent),
              const SizedBox(height: 12),
              buildAllInfoCard(allNum, allDays, allPercent),
              const SizedBox(height: 12),
              buildLineCard(
                  ref, lineMode == 1 ? yearLineData : weekLineData, lineMode),
              const SizedBox(height: 12),
              buildHeatMapCalendarCard(year, dates, ref),
              const SizedBox(height: 8),
              buildDeleteBtn(context, ref),
              // buildHeatMapCalendarCard()
              const SizedBox(height: 8),
            ],
          )),
    );
  }

  Widget buildDeleteBtn(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: const Color(0xff292929),
          content: Text(
            'questionDeleteHabit'.tr,
            style: const TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'.tr),
              child: Text('Cancel'.tr),
            ),
            TextButton(
              onPressed: () async {
                await HabitService.remove(habit.id);
                Get.offAllNamed("/NextScreen");
                ref.invalidate(habitProvider);
              },
              child: Text('OK'.tr),
            ),
          ],
        ),
      ),
      child: Text("Delete".tr),
    );
  }

  Widget buildDateInfoCard(String trackedDate, String createdDate) {
    return Row(
      children: [
        Expanded(
          child:
              InfoCard(content: buildInfoItem(createdDate, 'createStartFrom')),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child:
                InfoCard(content: buildInfoItem(trackedDate, 'trackStartFrom')))
      ],
    );
  }

  Widget buildMonthInfoCard(
      int thisMonthNum, int monthAll, double monthPercent) {
    return InfoCard(
        title: 'thisMonth'.tr,
        content: buildNumberInfo(thisMonthNum, monthAll, monthPercent));
  }

  Widget buildYearInfoCard(
      int thisMonthNum, int monthAll, double monthPercent) {
    return InfoCard(
        title: 'thisYear'.tr,
        content: buildNumberInfo(thisMonthNum, monthAll, monthPercent));
  }

  Widget buildAllInfoCard(int thisMonthNum, int monthAll, double monthPercent) {
    return InfoCard(
        title: 'thisAll'.tr,
        content: buildNumberInfo(thisMonthNum, monthAll, monthPercent));
  }

  Widget buildInfoItem(String value, String title) {
    return (Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            title.tr,
            style: const TextStyle(color: Color(0xff898989), fontSize: 11),
          )
        ],
      ),
    ));
  }

  Widget buildNumberInfo(int thisMonthNum, int monthAll, double monthPercent) {
    return Row(
      children: [
        Expanded(child: buildInfoItem(thisMonthNum.toString(), 'trackDays')),
        const SizedBox(
            width: 1, height: 24, child: ColoredBox(color: Color(0xff3a3a3a))),
        Expanded(child: buildInfoItem(monthAll.toString(), 'allDays')),
        const SizedBox(
            width: 1, height: 24, child: ColoredBox(color: Color(0xff3a3a3a))),
        Expanded(
            child: buildInfoItem(
                '${(monthPercent * 100).toStringAsFixed(1)}%', 'percent'))
      ],
    );
  }

  Widget buildLineCard(WidgetRef ref, List<int> data, int lineMode) {
    return InfoCard(
      content: LineChartSample2(data: data),
      title: 'trend'.tr,
      extra: CustomSlidingSegmentedControl<int>(
        initialValue: 1,
        height: 16,
        children: {
          1: Text(
            'Year'.tr,
            style: const TextStyle(fontSize: 10),
          ),
          2: Text(
            'Month'.tr,
            style: const TextStyle(fontSize: 10),
          ),
        },
        decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: BorderRadius.circular(8),
        ),
        thumbDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: const Offset(
                0.0,
                2.0,
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        onValueChanged: (v) {
          ref.read(lineProvider.notifier).state = v;
        },
      ),
    );
  }

  Widget buildHeatMapCalendarCard(
      int year, List<DateTime> dates, WidgetRef ref) {
    return InfoCard(
      title: '日历图',
      extra: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: Icon(
              Icons.chevron_left_outlined,
              size: 20,
              color: Colors.white,
            ),
            onTap: () => {ref.read(yearProvider.notifier).state = year - 1},
          ),
          Text(
            year.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          GestureDetector(
            child: Icon(
              Icons.chevron_right_outlined,
              size: 20,
              color: year < today.year ? Colors.white : Color(0xff5f5f5f),
            ),
            onTap: () {
              if (year < today.year) {
                ref.read(yearProvider.notifier).state = year + 1;
              }
            },
          ),
        ],
      ),
      content: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeekLabels(
                weekDaysLabels: const [
                  'M',
                  'T',
                  'W',
                  'T',
                  'F',
                  'S',
                  'S',
                ],
                squareSize: 14,
                labelTextColor: Colors.blueGrey,
              ),
              Expanded(
                  child: SingleChildScrollView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 960,
                  height: 150,
                  child: HeatMap(year: year, dates: dates),
                ),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'dragToSeeMore'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> buildAction(BuildContext context, int year, WidgetRef ref) {
    return [
      IconButton(
          icon: const Icon(Icons.edit),
          tooltip: 'edit habit info',
          onPressed: () => showAddHabitDialog(context, true, habit)),
    ];
  }
}

List<DateTime> getDateByYear(Habit habit, int year) {
  final List<DateTime> dateList = habit.dates != null
      ? habit.dates!.where((element) => element.year == year).toList()
      : [];
  dateList.sort(((a, b) => a.isBefore(b) ? -1 : 1));
  return dateList;
}
