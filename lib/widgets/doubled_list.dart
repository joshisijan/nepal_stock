import 'package:flutter/material.dart';



class DoubledList extends StatelessWidget {

  final bool noSecond;
  final String title1;
  final Function onPressed1;
  final IconData icon1;
  final String title2;
  final Function onPressed2;
  final IconData icon2;

  const DoubledList({
    Key key,
    this.noSecond = true,
    @required this.title1,
    @required this.onPressed1,
    @required this.icon1,
    this.title2,
    this.onPressed2,
    this.icon2,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
