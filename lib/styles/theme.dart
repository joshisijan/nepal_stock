import 'package:flutter/material.dart';
import 'package:nepal_stock/styles/colors.dart';


ThemeData kAppTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kColorBlack1,
  cursorColor: kColorGreen,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kColorBlack2,
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
);