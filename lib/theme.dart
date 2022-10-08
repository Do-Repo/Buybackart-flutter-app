import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData() {
    return ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Color(0XFF002E5A), elevation: 0),
        primaryColor: const Color(0XFF002E5A),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0XFF002E5A),
            secondary: const Color(0XFFFDE21C),
            background: Colors.white,
            brightness: Brightness.light));
  }
}
