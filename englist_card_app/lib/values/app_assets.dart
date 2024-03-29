/*
* define path of assets (images)
*/

import 'package:flutter/material.dart';

class AppAssets {
  static final String imagePath = 'assets/images/';
  static final String exchange = imagePath + 'exchange.png';
  static final String heart = imagePath + 'heart.png';
  static final String leftArrow = imagePath + 'left_arrow.png';
  static final String menu = imagePath + 'menu.png';
  static final String rightArrow = imagePath + 'right_arrow.png';

  static double getSize(BuildContext context, double? size) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scale = screenWidth / 375;
    return scale;
  }
}
