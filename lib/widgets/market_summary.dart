import 'dart:async';
import 'dart:convert';

import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nepal_stock/api/api_url.dart';
import 'package:nepal_stock/styles/colors.dart';

class MarketSummary extends StatefulWidget {
  @override
  _MarketSummaryState createState() => _MarketSummaryState();
}

class _MarketSummaryState extends State<MarketSummary> {
  Timer timer;
  double totalTurnover;
  double totalTransactions;
  double totalScrips;
  double totalShares;
  double totalCapital;
  double totalFloatCapital;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarketSummary();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      getMarketSummary();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Container(
            color: kColorBlack2,
            width: double.maxFinite,
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market Summary',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            color: kColorBlack2,
            width: double.maxFinite,
            padding: EdgeInsets.all(10.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                MarketColumn(
                  title: 'Total Turnover (Rs)',
                  value: totalTurnover,
                ),
                MarketColumn(
                  title: 'Total Traded Shares',
                  value: totalShares,
                ),
                MarketColumn(
                  title: 'Total Transactions',
                  value: totalTransactions,
                ),
                MarketColumn(
                  title: 'Total Scrips Traded',
                  value: totalScrips,
                ),
                MarketColumn(
                  title: 'Total Market Capitalization (Rs)',
                  value: totalCapital,
                ),
                MarketColumn(
                  title: 'Total Float Market Capitalization (Rs)',
                  value: totalFloatCapital,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getMarketSummary() async {
    try {
      var marketSummary = await http.get(kMarketSummary);
      var jsonData = jsonDecode(marketSummary.body);
      if (totalTurnover != double.parse(jsonData[0]['value'].toString()) ||
          totalShares != double.parse(jsonData[1]['value'].toString()) ||
          totalTransactions != double.parse(jsonData[2]['value'].toString()) ||
          totalScrips != double.parse(jsonData[3]['value'].toString()) ||
          totalCapital != double.parse(jsonData[4]['value'].toString()) ||
          totalFloatCapital != double.parse(jsonData[5]['value'].toString())) {
        setState(() {
          totalTurnover = double.parse(jsonData[0]['value'].toString());
          totalShares = double.parse(jsonData[1]['value'].toString());
          totalTransactions = double.parse(jsonData[2]['value'].toString());
          totalScrips = double.parse(jsonData[3]['value'].toString());
          totalCapital = double.parse(jsonData[4]['value'].toString());
          totalFloatCapital = double.parse(jsonData[5]['value'].toString());
        });
      }
    } catch (e) {}
  }
}

class MarketColumn extends StatelessWidget {
  final String title;
  final double value;

  const MarketColumn({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 11.7),
          ),
          Text(
            value != null ? value.toString().toCurrencyString() : '...',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorGrey2,
                fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}
