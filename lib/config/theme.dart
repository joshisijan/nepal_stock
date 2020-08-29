import 'package:flutter/material.dart';
import 'palette.dart';

ThemeData kAppTheme = ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Palette.black,
      accentColor: Palette.darkGreen,
);