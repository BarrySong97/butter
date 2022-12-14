import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/Habit.dart';
import '../../../services/HabitService.dart';
import '../index.dart';

void showRankView(BuildContext context, List<Habit?> habitList) {
  // List<String> data = AppConfig.languageSupports.keys.toList();
  showCupertinoModalPopup(
      context: context,
      builder: (context) => Rank(
            habitList: habitList,
          ));
}

class Rank extends ConsumerStatefulWidget {
  final List<Habit?> habitList;

  Rank({required this.habitList});
  @override
  ConsumerState<Rank> createState() => RankState();
}

class RankState extends ConsumerState<Rank> {
  late List<DragAndDropList> _contents;

  @override
  void initState() {
    super.initState();

    _contents = List.generate(1, (index) {
      return DragAndDropList(
        children: widget.habitList
            .map(
              (e) => DragAndDropItem(
                child: Container(
                  height: 50,
                  key: Key(e?.name! ?? ''),
                  margin: EdgeInsets.only(bottom: 16),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e?.name ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.menu,
                        color: Colors.white,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 104, 98, 98),
                      borderRadius: BorderRadius.circular(6)),
                ),
              ),
            )
            .toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 435,
        color: Color(0xff292929),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
        child: Column(
          children: [
            _buildHeader(context),
            // SizedBox(
            //   height: 16,
            // ),
            Expanded(child: _buildDragList()),
          ],
        ),
      ),
    );
  }

  Widget _buildDragList() {
    return DragAndDropLists(
      children: _contents,
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        child: Text(
          'cancel'.tr,
          style: TextStyle(
              fontSize: 16, color: Color.fromARGB(255, 184, 180, 184)),
        ),
        onTap: () => {Navigator.of(context).pop(false)},
      ),
      Text(
        'rankTitle'.tr,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      GestureDetector(
          onTap: () => {rankHabits(context)},
          child: Text('done'.tr,
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 184, 180, 184))))
    ]);
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      var habitItem = widget.habitList.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
      widget.habitList.insert(newItemIndex, habitItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }

  Future<void> rankHabits(BuildContext context) async {
    widget.habitList.asMap().keys.forEach((index) {
      widget.habitList[index]!.rank = index;
    });
    await HabitService.rankHabits(widget.habitList as List<Habit>);
    ref.invalidate(habitProvider);
    await Future.microtask(() => Navigator.of(context).pop(true));
  }
}
