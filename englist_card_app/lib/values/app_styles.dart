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
      TextStyle(fontFamily: FontFamily.sen, fontSize: 16, color: Colors.white);
  static TextStyle h6 = TextStyle(
      fontFamily: FontFamily.sen, fontSize: 9.89, color: Colors.white);

  static TextStyle getSize(BuildContext context, double? size) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scale = screenWidth / 375;
    return TextStyle(
        fontFamily: FontFamily.sen,
        fontSize: size != null ? size * scale : 0,
        color: Colors.white);
  }
}
