import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lipomo/pages/Settings/index.dart';
import 'package:lipomo/route.dart';

import 'pages/Home/index.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    locale: Locale('zh', 'CN'), // translations will be displayed in that locale
    fallbackLocale: Locale('en',
        'US'), // specify the fallback locale in case an invalid locale is selected.
    getPages: routes,
    home: const HomePage(),
  ));
}
