import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lipomo/models/Habit.dart';

import '../../../db.dart';

void showAddHabitDialog(BuildContext context) {
  // List<String> data = AppConfig.languageSupports.keys.toList();
  showCupertinoModalPopup(context: context, builder: (context) => AddHabit());
}

class AddHabit extends StatefulWidget {
  AddHabit({Key? key}) : super(key: key);

  @override
  State<AddHabit> createState() => _AddHabit();
}

class _AddHabit extends State<AddHabit> {
  Habit habit = Habit()..color = Colors.blue.hex;

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
        onTap: () => {Navigator.pop(context)},
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
      color: Colors.blue,
      padding: EdgeInsets.all(0),

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
    final db = await DBManager.instance.database;
    final habitRep = db.collection<Habit>();
    await db.writeTxn(() async {
      await habitRep.put(habit);
    });
    Navigator.pop(context);
  }
}
