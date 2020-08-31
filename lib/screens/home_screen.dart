import 'package:flutter/material.dart';
import '../tabs/tabs.dart';
import '../config/palette.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: pageStorageBucket,
        child: Column(
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
              backgroundColor: Palette.lightBlack,
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
                  icon: Icon(Icons.card_travel),
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
      ),
    );
  }
}
