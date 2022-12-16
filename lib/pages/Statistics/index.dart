import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lipomo/pages/Statistics/components/HeatMap.dart';
import 'package:lipomo/pages/Statistics/components/InfoCard.dart';
import 'package:lipomo/services/HabitService.dart';

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

class Statistics extends HookConsumerWidget {
  final Color boxColor = Color(0xff292929);
  final ScrollController controller =
      ScrollController(initialScrollOffset: 100);
  Habit habit = Get.arguments;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int year = ref.watch(yearProvider);
    final List<DateTime> dates = getDateByYear(habit, year);
    final String firtTractDate = dates.first.toString();
    // month
    final int thisMonthNum = 0;
    final int monthAll = 0;
    final double monthPercent = thisMonthNum / monthAll;
    // year
    final int thisYearNum = 0;
    final int yearAll = 0;
    final double yearPercent = thisYearNum / yearAll;

    // all
    final int allNum = 0;
    final int allDays = 0;
    final double allPercent = allNum / allDays;

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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              buildDateInfoCard(),
              const SizedBox(height: 12),
              buildMonthInfoCard(),
              const SizedBox(height: 12),
              buildYearInfoCard(),
              const SizedBox(height: 12),
              buildAllInfoCard(),
              const SizedBox(height: 12),
              buildLineCard(),
              const SizedBox(height: 12),
              buildHeatMapCalendarCard(year),
              const SizedBox(height: 4),
              buildDeleteBtn(context, ref),
              // buildHeatMapCalendarCard()
            ],
          )),
    );
  }

  Widget buildDeleteBtn(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      child: Text("Delete".tr),
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Color(0xff292929),
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
    );
  }

  Widget buildDateInfoCard() {
    return Row(
      children: [
        Expanded(
          child:
              InfoCard(content: buildInfoItem('2022-10-17', 'createStartFrom')),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: InfoCard(
                content: buildInfoItem('2022-10-17', 'trackStartFrom')))
      ],
    );
  }

  Widget buildMonthInfoCard() {
    return InfoCard(title: 'thisMonth'.tr, content: buildNumberInfo());
  }

  Widget buildYearInfoCard() {
    return InfoCard(title: 'thisYear'.tr, content: buildNumberInfo());
  }

  Widget buildAllInfoCard() {
    return InfoCard(title: 'thisAll'.tr, content: buildNumberInfo());
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
            style: TextStyle(color: Color(0xff898989), fontSize: 11),
          )
        ],
      ),
    ));
  }

  Widget buildNumberInfo() {
    return Row(
      children: [
        Expanded(child: buildInfoItem('24', 'trackDays')),
        SizedBox(
            width: 1, height: 24, child: ColoredBox(color: Color(0xff3a3a3a))),
        Expanded(child: buildInfoItem('120', 'allDays')),
        SizedBox(
            width: 1, height: 24, child: ColoredBox(color: Color(0xff3a3a3a))),
        Expanded(child: buildInfoItem('20%', 'percent'))
      ],
    );
  }

  Widget buildLineCard() {
    return InfoCard(
      content: LineChartSample2(),
      title: 'trend'.tr,
      extra: CustomSlidingSegmentedControl<int>(
        initialValue: 3,
        height: 16,
        children: {
          1: Text(
            'Week'.tr,
            style: TextStyle(fontSize: 10),
          ),
          3: Text(
            'Year'.tr,
            style: TextStyle(fontSize: 10),
          ),
          2: Text(
            'Month'.tr,
            style: TextStyle(fontSize: 10),
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
              offset: Offset(
                0.0,
                2.0,
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        onValueChanged: (v) {
          print(v);
        },
      ),
    );
  }

  Widget buildHeatMapCalendarCard(int year) {
    return InfoCard(
      title: '日历图',
      extra: Row(
        children: [
          Text(
            year.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ),
      content: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeekLabels(
                weekDaysLabels: [
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
                child: Container(
                  width: 960,
                  height: 150,
                  child: HeatMap(year: year),
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
              SizedBox(
                width: 8,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildAllDays() {
    return ColoredBox(
      color: boxColor,
      child: Text('1'),
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
