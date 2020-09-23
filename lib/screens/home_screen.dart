import 'package:flutter/material.dart';
import 'package:nepal_stock/widgets/market_status.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey('HomeScreen'),
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 32.0,
          ),
          Text(
            'Good Morning,',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          MarketStatus(),
        ],
      ),
    );
  }
}
