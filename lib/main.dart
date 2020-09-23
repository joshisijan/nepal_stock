import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepal_stock/screens/home_screen.dart';
import 'package:nepal_stock/screens/portfolio_screen.dart';
import 'package:nepal_stock/screens/search_screen.dart';
import 'package:nepal_stock/screens/tools_screen.dart';
import 'package:nepal_stock/screens/watchlist_screen.dart';
import 'package:nepal_stock/styles/theme.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Nepal Stock App',
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
      home: AppBase(),
    );
  }
}

class AppBase extends StatefulWidget {
  @override
  _AppBaseState createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  int _bottomNavigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: Scaffold(
          body: containerSelector(_bottomNavigationBarIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _bottomNavigationBarIndex,
            onTap: (n){
              setState(() {
                _bottomNavigationBarIndex = n;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.view_stream),
                title: Text('Portfolio'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                title: Text('Watchlist'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                title: Text('Tools'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget containerSelector(int n){
  if(n == 0)
    return HomeScreen();
  else if(n == 1)
    return SearchScreen();
  else if(n == 2)
    return PortfolioScreen();
  else if(n == 3)
    return WatchlistScreen();
  else if(n == 4)
    return ToolsScreen();
  else
    return HomeScreen();
}
