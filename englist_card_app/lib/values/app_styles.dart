import 'package:flutter/material.dart';

/**
 * *Style of Text, Button...
 */

class FontFamily {
  static final sen = 'Sen';
}

class AppStyle {
  static TextStyle h1 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 109.9, color: Colors.white);
  static TextStyle h2 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 67.77, color: Colors.white);
  static TextStyle h3 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 41.89, color: Colors.white);
  static TextStyle h4 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 25.89, color: Colors.white);
  static TextStyle h5 =
      TextStyle(fontFamily: FontFamily.sen, fontSize: 13, color: Colors.white);
  static TextStyle h6 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 9.89, color: Colors.white);
  static TextStyle h7 =
      TextStyle(fontFamily: FontFamily.sen, fontSize: 18, color: Colors.white);
  static TextStyle englishToday =
      TextStyle(fontFamily: FontFamily.sen, fontSize: 40, color: Colors.white);
  static TextStyle h150 =
      TextStyle(fontFamily: FontFamily.sen, fontSize: 150, color: Colors.white);

  static TextStyle getSize(BuildContext context, double? size) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scale = screenWidth / 375;
    return TextStyle(
        fontFamily: FontFamily.sen,
        fontSize: size != null ? size * scale : 0,
        color: Colors.white);
  }

  static double scaleRatio(BuildContext context, double size) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scale = screenWidth / 375;
    return scale * size;
  }
}
