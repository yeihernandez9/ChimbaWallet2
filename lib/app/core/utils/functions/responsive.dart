import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  final double width;
  final double height;
  final double inch;

  Responsive({
    required this.width,
    required this.height,
    required this.inch,
  });

  static Responsive on(BuildContext context) {
    final size = getSize(context);
    return Responsive(
        width: size.width,
        height: size.height,
        inch: getInch(size.width, size.height));
  }

  static dynamic getSize(context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size;
  }

  static double getInch(double width, double height) {
    final inch = math.sqrt(math.pow(width, 2)) + math.sqrt(math.pow(height, 2));
    return inch;
  }

  double widthPercent(double percent) {
    return this.width * percent / 100;
  }

  double heightPercent(double percent) {
    return this.height * percent / 100;
  }

  double inchPercent(double percent) {
    return this.inch * percent / 100;
  }
}
