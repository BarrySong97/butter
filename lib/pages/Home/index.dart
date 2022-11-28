import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipomo/components/Timer.dart';
import 'package:lipomo/pages/Home/components/WeekItem.dart';

import '../../components/ButtonTools.dart';
import 'components/Add.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class HabbitWeekItem {
  final String name;
  final List<int> checked;

  const HabbitWeekItem({required this.name, required this.checked});
}

class _HomePageState extends State<HomePage> {
  StopWatchType _type = StopWatchType.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1a1a1a),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'habbitsTitle'.tr,
          style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 4),
        ),
        actions: buildAction(),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: buildList(context),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      // padding: const EdgeInsets.all(20.0),
      // children: [buildList(), buildList()],
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        if (index == 5) {
          return Column(children: [
            WeekItem(),
            SizedBox(
              height: 16,
            ),
            buildAddButton(context),
            SizedBox(
              height: 8,
            ),
          ]);
        }
        return WeekItem();
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 16,
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return GestureDetector(
        child: Row(
          children: [
            Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'addHabit'.tr,
              style: TextStyle(color: Colors.white),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        onTap: () => showAddHabitDialog(context));
  }

  List<Widget> buildAction() {
    return [
      GestureDetector(
        onTap: () => {Get.toNamed("/settings")},
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(Icons.settings, color: Colors.white),
        ),
      )
    ];
  }
}
