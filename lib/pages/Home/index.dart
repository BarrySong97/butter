import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lipomo/components/Timer.dart';
import 'package:lipomo/db.dart';
import 'package:lipomo/pages/Home/components/WeekItem.dart';
import 'package:lipomo/services/HabitService.dart';

import '../../components/ButtonTools.dart';
import '../../models/Habit.dart';
import 'components/Add.dart';

final habitProvider = FutureProvider<List<Habit?>>((ref) async {
  return HabitService.getAll();
});

class HabbitWeekItem {
  final String name;
  final List<int> checked;

  const HabbitWeekItem({required this.name, required this.checked});
}

class HomePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Habit?>> habitList = ref.watch(habitProvider);
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
        child: habitList.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (list) {
            return buildList(context, list, ref);
          },
        ),
      ),
    );
  }

  Widget buildList(
      BuildContext context, List<Habit?> habitList, WidgetRef ref) {
    if (habitList.isEmpty) {
      return Center(
        child: buildAddButton(context),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: habitList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = habitList[index];
        if (item == null) {
          return buildAddButton(context);
        }
        // if (item ==)
        if (index == habitList.length - 1) {
          return Column(children: [
            WeekItem(
              item: item,
              onToggle: (DateTime date, bool checked) async {
                await HabitService.update(item);
                ref.invalidate(habitProvider);
              },
            ),
            SizedBox(
              height: 16,
            ),
            buildAddButton(context),
            SizedBox(
              height: 8,
            ),
          ]);
        }
        return WeekItem(
          item: item,
          onToggle: (DateTime date, bool checked) async {
            await HabitService.update(item);
          },
        );
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
