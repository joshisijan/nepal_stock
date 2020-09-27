import 'package:flutter/material.dart';
import 'package:nepal_stock/styles/colors.dart';

class DetailHeader extends StatelessWidget {
  final String header;

  const DetailHeader({Key key, @required this.header}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 1.0),
      padding: EdgeInsets.all(10.0),
      color: kColorBlack1.withAlpha(150),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.header,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}
