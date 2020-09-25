import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepal_stock/screens/home_screen.dart';
import 'package:nepal_stock/screens/portfolio_screen.dart';
import 'package:nepal_stock/screens/search_screen.dart';
import 'package:nepal_stock/screens/tools_screen.dart';
import 'package:nepal_stock/screens/watchlist_screen.dart';
import 'package:nepal_stock/styles/theme.dart';
import 'package:nepal_stock/widgets/offline_status.dart';


void main() {
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
  int _bottomNavigationBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _bottomNavigationBarIndex,
            children: [
              HomeScreen(),
              SearchScreen(),
              PortfolioScreen(),
              WatchlistScreen(),
              ToolsScreen(),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: OfflineStatus(),
          ),
        ],
      ),
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
    );
  }
}

