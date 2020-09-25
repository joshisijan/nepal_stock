import 'package:flutter/material.dart';

class WrapValue extends StatelessWidget {
  final bool isBold;
  final String title;
  final double moreSpacing;
  final Color color;
  const WrapValue({
    Key key,
    this.isBold = false,
    this.moreSpacing = 0.0,
    this.color = Colors.white,
    @required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 2.0,),
      width: MediaQuery.of(context).size.width * 0.5 - 20 - moreSpacing,
      child: Text(title,
          textAlign: TextAlign.left,
          style: isBold
              ? TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 12.7,
          )
              : TextStyle(
            fontSize: 12.5,
            color: color,
          )),
    );
  }
}
