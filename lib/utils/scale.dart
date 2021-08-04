
import 'package:flutter/cupertino.dart';

class Scale {
  static late double px;
  static late double screenWidth;
  static late double screenHeight;

  static void initialize(BuildContext context, {double standarWidth = 375}) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    Scale.screenWidth = _mediaQuery.size.width;
    Scale.screenHeight = _mediaQuery.size.height;
    Scale.px = screenWidth / standarWidth;
    print(screenWidth);
  }

  static setPx(double size) {
    return size * Scale.px;
  }
}