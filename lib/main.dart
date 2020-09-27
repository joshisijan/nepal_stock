import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/models/watchlist_model.dart';
import 'package:nepal_stock/reuseables/offline_status.dart';
import 'package:nepal_stock/screens/home_screen.dart';
import 'package:nepal_stock/screens/portfolio_screen.dart';
import 'package:nepal_stock/screens/search_screen.dart';
import 'package:nepal_stock/screens/tools_screen.dart';
import 'package:nepal_stock/screens/watchlist_screen.dart';
import 'package:nepal_stock/styles/theme.dart';
import 'package:provider/provider.dart';

import 'models/portfolio_model.dart';

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
    return DynamicTheme(
      defaultBrightness: kAppDarkTheme.brightness,
      data: (brightness) => kAppDarkTheme,
      themedWidgetBuilder: (context, theme){
        return MaterialApp(
          title: 'Nepal Stock App',
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: kAppDarkTheme,
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => StockModel()
              ),
              ChangeNotifierProvider(
                  create: (_) => WatchlistModel()
              ),
              ChangeNotifierProvider(
                  create: (_) => PortfolioModel()
              ),
            ],
            child: AppBase(),
          ),
        );
      },
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
  void initState() {
    super.initState();
    context.read<StockModel>().setEverything();
  }

  @override
  void dispose() {
    context.read<StockModel>().dispose();
    super.dispose();
  }

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
        onTap: (n) {
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
