import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:butter/models/Habit.dart';
import 'package:butter/services/HabitService.dart';
import 'package:butter/utils/Color.dart';

import '../index.dart';

void showAddHabitDialog(BuildContext context, bool edit, Habit habit,
    [Function? refresh]) async {
  // List<String> data = AppConfig.languageSupports.keys.toList();
  final bool? back = await showCupertinoModalPopup<bool?>(
      context: context,
      builder: (context) => AddHabit(edit: edit, editHabit: habit));
  // print(back);
  if ((back ?? false) && refresh != null) {
    refresh();
  }
}

class AddHabit extends ConsumerStatefulWidget {
  final bool edit;
  final Habit editHabit;

  AddHabit({Key? key, required this.edit, required this.editHabit})
      : super(key: key);

  @override
  ConsumerState<AddHabit> createState() =>
      _AddHabit(editHabit: editHabit, edit: edit);
}

class _AddHabit extends ConsumerState<AddHabit> {
  late TextEditingController _controller;
  late Habit habit;
  final Habit editHabit;
  final bool edit;
  _AddHabit({required this.editHabit, required this.edit}) {
    habit = editHabit;
    _controller = TextEditingController(text: edit ? habit.name : '');
  }
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(habitProvider);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      child: Container(
        height: 600,
        // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Color(0xff292929),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: Column(
                children: [
                  buildTitle(context),
                  SizedBox(
                    height: 20,
                  ),
                  buildNameInput(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
          buildColorPicker()
        ]),
      ),
    );
  }

  Widget buildTitle(
    BuildContext context,
  ) {
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
        'addNewHabbit'.tr,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      GestureDetector(
          onTap: () => {
                if (habit.name != null) {addHabit(context)}
              },
          child: Text(
            'done'.tr,
            style: TextStyle(
                fontSize: 16,
                color: habit.name == "" || habit.name == null
                    ? Color.fromARGB(255, 92, 90, 90)
                    : Color.fromARGB(255, 184, 180, 184)),
          ))
    ]);
  }

  Widget buildNameInput() {
    return TextField(
      cursorColor: Colors.white,
      controller: _controller,
      style: TextStyle(color: Colors.white),
      onChanged: (value) => {
        setState(() {
          habit.name = value;
        })
      },
      decoration: InputDecoration(
          // fillColor: Colors.white,
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xff343434),
          hintText: 'habbitTitlePlaceHolder'.tr,
          hintStyle: TextStyle(color: Color(0XFF555555))),
    );
  }

  Widget buildColorPicker() {
    return ColorPicker(
      // Use the screenPickerColor as start color.
      color: habit.color != null
          ? Color(HexColor.getColorFromHex(habit.color))
          : Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 5),

      // // Update the screenPickerColor using the callback.
      onColorChanged: (Color color) => {
        setState(() {
          habit.color = color.hex;
        })
      },

      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.accent: false
      },
      width: 30,
      height: 30,
      borderRadius: 22,
      heading: Text(
        'addSelectColorTitle'.tr,
        style: TextStyle(color: Colors.white),
      ),
      subheading: Text(
        'addSelectColorSubTitle'.tr,
        style: TextStyle(color: Colors.white),
        // style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Future<void> addHabit(BuildContext context) async {
    if (edit) {
      await HabitService.update(habit);
    } else {
      await HabitService.addHabit(habit);
      ref.invalidate(habitProvider);
    }
    await Future.microtask(() => Navigator.of(context).pop(true));
  }
}
