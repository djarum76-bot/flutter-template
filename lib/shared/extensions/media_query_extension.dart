import 'package:flutter/material.dart';
import 'package:my_template/main.dart';

extension CustomMediaQuery on num {
  double get h => MediaQuery.of(navigatorKey.currentContext!).size.height * this / 100;
  double get w => MediaQuery.of(navigatorKey.currentContext!).size.width * this / 100;
  double get size => MediaQuery.of(navigatorKey.currentContext!).size.shortestSide * this / 100;
  double get radius => MediaQuery.of(navigatorKey.currentContext!).size.shortestSide * this / 200;
}