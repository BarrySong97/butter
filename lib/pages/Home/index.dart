import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipomo/components/Timer.dart';

import '../../components/ButtonTools.dart';
import '../Settings/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StopWatchType _type = StopWatchType.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: buildAction(),
      ),
      body: Column(
          children: [buildStopwatchPanel(), buildTools(StopWatchType.stopped)]),
    );
  }

  List<Widget> buildAction() {
    return [
      GestureDetector(
        onTap: () => {Get.toNamed("/settings")},
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(Icons.settings, color: Color(0xff262626)),
        ),
      )
    ];
  }

  List<PopupMenuEntry<String>> _buildItem(BuildContext context) {
    return const [
      PopupMenuItem<String>(
        value: "设置",
        child: Center(child: Text("设置")),
      )
    ];
  }

  void _onSelectItem(String value) {}

  Widget buildStopwatchPanel() {
    double radius = MediaQuery.of(context).size.width / 2 * 0.75;
    return Container(
      height: radius * 2,
      width: MediaQuery.of(context).size.height,
      // color: Colors.blue,
      child: Timer(),
    );
  }

  Widget buildRecordPanel() {
    return Expanded(
      child: Container(
        color: Colors.red,
      ),
    );
  }

  Widget buildTools(StopWatchType state) {
    return ButtonTools(
      state: _type,
      onRecoder: onRecoder,
      onReset: onReset,
      toggle: toggle,
    );
  }

  void onReset() {
    setState(() {
      _type = StopWatchType.none;
    });
  }

  void onRecoder() {}
  void toggle() {
    bool running = _type == StopWatchType.running;
    setState(() {
      _type = running ? StopWatchType.stopped : StopWatchType.running;
    });
  }
}
