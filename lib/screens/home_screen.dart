import 'package:flutter/material.dart';
import 'package:nepal_stock/screens/settings_screen.dart';
import 'package:nepal_stock/widgets/market_status.dart';
import 'package:nepal_stock/widgets/market_summary.dart';
import 'package:nepal_stock/widgets/nepse_line_chart.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      key: PageStorageKey('HomePageStorageKey'),
      children: [
        Container(
          color: Theme.of(context).canvasColor,
          height: MediaQuery.of(context).padding.top + 24.0,
        ),
        Container(
          color: Theme.of(context).canvasColor,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  greetingMessage(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Theme.of(context).textTheme.subtitle1.color,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.0),
                child: IconButton(
                  icon: Icon(Icons.menu, color: Theme.of(context).textTheme.subtitle1.color,),
                  onPressed: (){
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SettingsScreen(),
                        transitionDuration: Duration(milliseconds: 250),
                        transitionsBuilder: (_, animation, ___, child){
                          animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
                          return SlideTransition(
                            position: Tween(
                              begin: Offset(1.0, 0.0),
                              end: Offset(0.0, 0.0),
                            ).animate(animation),
                            child: child,
                          );
                        }
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
        MarketStatus(),
        NepseLineChart(),
        MarketSummary(),
        //for offline status
        SizedBox(
          height: 40.0,
        ),
      ],
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
