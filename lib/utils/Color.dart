import 'dart:ui';

import '../models/Habit.dart';

class HexColor {
  static int getColorFromHex(String? hexColor) {
    if (hexColor == null) {
      return 0;
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  static Color getHabitColor(Habit habit, bool checked) {
    final Color habitColor = habit.color != null
        ? Color(getColorFromHex(habit.color))
        : const Color(0xff5666f0);
    final Color checkedColor = checked ? habitColor : const Color(0xff343434);
    return checkedColor;
  }

  HexColor(final String hexColor);
}
