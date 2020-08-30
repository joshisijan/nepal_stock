import 'package:flutter/material.dart';
import '../config/palette.dart';


class CustomButton extends StatelessWidget {

  final EdgeInsets padding, margin;
  final String title;
  final Function onPressed;

  const CustomButton({
    Key key,
    this.padding,
    this.margin,
    @required this.title,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding ?? EdgeInsets.zero,
      margin: this.margin ?? EdgeInsets.zero,
      child: MaterialButton(
        child: Text(this.title),
        onPressed: this.onPressed,
        minWidth: double.maxFinite,
        color: Palette.darkGreen.withAlpha(200),
      ),
    );
  }
}
