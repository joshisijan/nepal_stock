import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              children: [
                ListView(
                  children: [
                    Text('home'),
                  ],
                ),
                ListView(
                  children: [
                    Text('search'),
                  ],
                ),
                ListView(
                  children: [
                    Text('portfolio'),
                  ],
                ),
              ],
            ),
          ),
          BottomNavigationBar(
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
            ],
          ),
        ],
      ),
    );
  }
}
