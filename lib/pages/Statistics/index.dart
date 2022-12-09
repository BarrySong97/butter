import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lipomo/pages/Statistics/components/HeatMap.dart';

import '../../models/Habit.dart';
import '../Home/index.dart';
import 'components/LineChart.dart';

class Statistics extends HookConsumerWidget {
  final Color boxColor = Color(0xff292929);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Habit?>> habitList = ref.watch(habitProvider);
    print(Get.parameters['id']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1a1a1a),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'trs',
          style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 4),
        ),
        actions: buildAction(),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              buildInfoCard(),
              const SizedBox(height: 16),
              buildLineCard(),
              const SizedBox(height: 16),
              buildHeatMapCalendarCard(),
              // buildHeatMapCalendarCard()
            ],
          )),
    );
  }

  Widget buildInfoCard() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      decoration: BoxDecoration(
          color: const Color(0xff292929),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          Expanded(child: buildInfoItem('1', 'startFrom')),
          SizedBox(
              width: 1,
              height: 24,
              child: ColoredBox(color: Color(0xff3a3a3a))),
          Expanded(child: buildInfoItem('24', 'monthDays')),
          SizedBox(
              width: 1,
              height: 24,
              child: ColoredBox(color: Color(0xff3a3a3a))),
          Expanded(child: buildInfoItem('120', 'yearDays')),
          SizedBox(
              width: 1,
              height: 24,
              child: ColoredBox(color: Color(0xff3a3a3a))),
          Expanded(child: buildInfoItem('20%', 'percent'))
        ],
      ),
    );
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

  Widget buildLineCard() {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff292929),
          borderRadius: BorderRadius.circular(6)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      child: Column(
        children: [
          buildLineCardHeader(),
          LineChartSample2(),
          SizedBox(height: 12)
        ],
      ),
    );
  }

  Widget buildLineCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'statistic'.tr,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        DropdownButtonExample()
      ],
    );
  }

  Widget buildHeatMapCalendarCard() {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff292929),
          borderRadius: BorderRadius.circular(6)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: HeatMap(),
    );
  }

  Widget buildAllDays() {
    return ColoredBox(
      color: boxColor,
      child: Text('1'),
    );
  }

  List<Widget> buildAction() {
    return [
      IconButton(
        icon: const Icon(Icons.edit),
        tooltip: 'edit habit info',
        onPressed: () {},
      ),
    ];
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

List<String> list = <String>['All'.tr, 'Year'.tr, 'Month'.tr];

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        dropdownWidth: 100,
        items: list
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                        fontSize: 12,
                        color: dropdownValue == item
                            ? Colors.white
                            : Colors.black),
                  ),
                ))
            .toList(),
        value: dropdownValue,
        onChanged: (value) {
          setState(() {
            dropdownValue = value as String;
          });
        },
        buttonHeight: 40,
        itemHeight: 40,
      ),
    );
  }
}
