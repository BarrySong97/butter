import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipomo/components/Timer.dart';
import 'package:lipomo/pages/Home/components/WeekItem.dart';

import '../../components/ButtonTools.dart';

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
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: buildList(),
      ),
    );
  }

  Widget buildList() {
    return WeekItem();
  }

  Widget buildItem(HabbitWeekItem item) {
    return WeekItem();
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
