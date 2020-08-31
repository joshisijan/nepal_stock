import 'package:flutter/material.dart';

class WatchlistTab extends StatelessWidget {

  final PageStorageKey watchlistStorageKey = PageStorageKey('watchlist');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: watchlistStorageKey,
      child: Text('watch list'),
    );
  }
}
