import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lipomo/route.dart';

import 'locale.dart';
import 'pages/Home/index.dart';

class AppController extends GetxController {
  var thmeColor = 0xff2196f3;
  changeThemeColor(int color) => {thmeColor = color};
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xff1a1a1a)),
    translations: Lang(),
    locale: const Locale(
        'zh', 'CN'), // translations will be displayed in that locale
    fallbackLocale: const Locale('en',
        'US'), // specify the fallback locale in case an invalid locale is selected.
    getPages: routes,
    home: const HomePage(),
  ));
}
