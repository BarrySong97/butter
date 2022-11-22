import 'package:get/get.dart';
import 'package:lipomo/pages/Home/index.dart';

import 'pages/Settings/index.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/settings', page: () => Settings()),
  GetPage(name: '/', page: () => HomePage())
];
