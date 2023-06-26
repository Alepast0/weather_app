import 'package:flutter/widgets.dart';

extension PercentSized on double {
  double get hp => (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * (this / 100));
  double get wp => (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width * (this / 100));
}