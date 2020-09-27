import 'package:flutter/material.dart';
import 'package:nepal_stock/widgets/market_status.dart';
import 'package:nepal_stock/widgets/market_summary.dart';
import 'package:nepal_stock/widgets/nepse_line_chart.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 32.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  greetingMessage(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){

                },
              ),
            ],
          ),
          MarketStatus(),
          NepseLineChart(),
          MarketSummary(),
          //for offline status
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
  String greetingMessage(){
    var timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Good Morning,';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon,';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening,';
    } else {
      return 'Good Night,';
    }
  }
}
