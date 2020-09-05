import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'config/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nepal Stock App',
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
      home: HomeScreen(),
    );
  }
}
