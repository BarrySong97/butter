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
    getPages: routes,
    home: const HomePage(title: 'Flutter Demo Home Page'),
  ));
}
