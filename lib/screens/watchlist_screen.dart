import 'package:flutter/material.dart';

class WatchlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 32.0,
          ),
          Text(
            'My Watchlist',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          //for offline status
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
