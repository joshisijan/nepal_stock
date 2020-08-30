import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../config/palette.dart';
import '../screens/screens.dart';

class ToolsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 20.0,
          ),
          child: Text(
            'Tools',
            style: Theme.of(context).textTheme.headline2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DoubledList(
          children: [
            DoubledListItem(
              icon: Icons.monetization_on,
              iconBackgroundColor: Colors.green,
              iconColor: Palette.white,
              title: 'Buy Calculator',
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context){
                    return BuyCalculator();
                  }
                ));
              },
            ),
            DoubledListItem(
              icon: Icons.monetization_on,
              iconBackgroundColor: Colors.red,
              iconColor: Palette.white,
              title: 'Sell (profit/loss)\nCalculator',
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return SellCalculator();
                    }
                ));
              },
            ),
            DoubledListItem(
              icon: Icons.note,
              iconBackgroundColor: Colors.blue,
              iconColor: Palette.white,
              title: 'My Notes',
              onPressed: (){

              },
            ),
          ],
        ),
      ],
    );
  }
}
