import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:butter/route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'locale.dart';
import 'pages/Home/index.dart';

void main() {
  runApp(
    ProviderScope(
        child: GetMaterialApp(
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
      home: HomePage(),
    )),
  );
}
