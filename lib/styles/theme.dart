import 'package:flutter/material.dart';
import 'package:nepal_stock/styles/colors.dart';


ThemeData kAppLightTheme = ThemeData.light();

ThemeData kAppDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kColorBlack2,
  cursorColor: kColorGreen,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kColorBlack1,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: kColorGreen,
    unselectedItemColor: kColorGrey2,
    selectedLabelStyle: TextStyle(
      fontSize: 11.0,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 11.0,
    ),
  ),
  accentColor: kColorGreen,
);
