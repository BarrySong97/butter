import 'package:get/get.dart';
import 'package:butter/pages/Home/index.dart';
import 'package:butter/pages/Statistics/index.dart';

import 'pages/Settings/index.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
      name: '/settings',
      page: () => Settings(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/', page: () => HomePage(), transition: Transition.rightToLeft),
  GetPage(
      name: '/detail/:id',
      page: () => Statistics(),
      transition: Transition.rightToLeft),
];
