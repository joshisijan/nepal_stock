import 'package:flutter/material.dart';
import '../tabs/tabs.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                HomeTab(),
                SearchTab(),
                PortfolioTab(),
                WatchlistTab(),
                ToolsTab(),
              ],
            ),
          ),
          BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: Theme.of(context).textTheme.caption.fontSize,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business_center),
                title: Text('Portfolio'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                title: Text('Watchlist'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                title: Text('Tools'),
              ),
            ],
            onTap: (n){
              setState(() {
                _currentIndex = n;
              });
            },
          ),
        ],
      ),
    );
  }
}
