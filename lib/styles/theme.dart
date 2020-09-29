import 'package:flutter/material.dart';
import 'package:nepal_stock/styles/colors.dart';


ThemeData kAppLightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: kColorWhite2,
  primaryColor: kColorBlue,
  cardColor: kColorWhite1,
  canvasColor: kColorBlue,
  splashColor: kColorBlue,
  colorScheme: ColorScheme.light().copyWith(
    primary: kColorBlue,
  ),
  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.light().copyWith(
      primary: kColorBlue,
    ),
  ),
  buttonColor: kColorBlue,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: kColorWhite1,
    unselectedItemColor: kColorWhite2.withAlpha(180),
    selectedLabelStyle: TextStyle(
      fontSize: 11.0,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 11.0,
    ),
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
      color: kColorWhite2.withAlpha(200),
    ),
    caption: TextStyle(
      color: kColorGrey1,
    ),
  ),
  accentColor: kColorRed2,
);

ThemeData kAppDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kColorBlack2,
  cursorColor: kColorGreen,
  canvasColor: kColorBlack1,
  colorScheme: ColorScheme.dark().copyWith(
    primary: kColorGreen,
    onPrimary: ColorScheme.light().onPrimary,
  ),
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
  textTheme: TextTheme(
    subtitle1: TextStyle(
      color: kColorWhite2.withAlpha(200),
    ),
    caption: TextStyle(
      color: kColorWhite2,
    ),
  ),
  accentColor: kColorGreen,
  cardColor: kColorBlack1.withAlpha(150),
);
