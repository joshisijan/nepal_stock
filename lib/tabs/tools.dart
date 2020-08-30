import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../config/palette.dart';

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
              title: 'Profit Calculator',
              onPressed: (){

              },
            ),
            DoubledListItem(
              icon: Icons.attach_money,
              iconBackgroundColor: Colors.blue,
              iconColor: Palette.white,
              title: 'WAAC Calculator',
              onPressed: (){

              },
            ),
          ],
        ),
      ],
    );
  }
}
