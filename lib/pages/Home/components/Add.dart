import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void showAddHabitDialog(BuildContext context) {
  // List<String> data = AppConfig.languageSupports.keys.toList();
  showCupertinoModalPopup(context: context, builder: (context) => AddHabit());
}

class AddHabit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 500,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Color(0xff292929),
        child: Column(children: [
          buildTitle(),
          SizedBox(
            height: 20,
          ),
          buildNameInput(),
          SizedBox(
            height: 20,
          ),
          buildColorPicker()
        ]),
      ),
    );
  }

  Widget buildTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        'cancel'.tr,
        style:
            TextStyle(fontSize: 16, color: Color.fromARGB(255, 137, 134, 137)),
      ),
      Text(
        'addNewHabbit'.tr,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      Text(
        'done'.tr,
        style:
            TextStyle(fontSize: 16, color: Color.fromARGB(255, 137, 134, 137)),
      )
    ]);
  }

  Widget buildNameInput() {
    return TextField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
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
    return Row(
      children: [],
    );
  }
}
