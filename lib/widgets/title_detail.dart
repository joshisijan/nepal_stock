import 'package:flutter/material.dart';


class TitleDetail extends StatelessWidget {

  final EdgeInsets margin, padding;
  final String title, detail;
  final TextStyle titleStyle, detailStyle;

  const TitleDetail({
    Key key,
    this.margin,
    this.padding,
    @required this.title,
    @required this.detail,
    this.titleStyle,
    this.detailStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin ?? EdgeInsets.zero,
      padding: this.padding ?? EdgeInsets.zero,
      width: double.maxFinite,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            this.title,
            style: this.titleStyle ??  TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              wordSpacing: 0,
            ),
          ),
          Text(
            this.detail,
            style: this.detailStyle ?? Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
