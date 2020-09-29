import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class PortfolioCalculation extends StatelessWidget {
  final int units;
  final double price;
  final double todayPrice;

  const PortfolioCalculation({
    Key key,
    @required this.units,
    @required this.price,
    @required this.todayPrice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                units.toString().toCurrencyString(mantissaLength: 0),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total Unit'.toUpperCase(),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                price.toCurrencyString(leadingSymbol: 'Rs '),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total Investment'.toUpperCase(),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).textTheme.subtitle1.color,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            width: double.maxFinite,
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                Text(
                  todayPrice.toCurrencyString(leadingSymbol: 'Rs '),
                  style: TextStyle(
                    fontSize: 12.7,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  width: 100.0,
                  child: Text(
                    'Today\'s Price'.toUpperCase(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            width: double.maxFinite,
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                Text(
                  '124566666'.toCurrencyString(leadingSymbol: 'Rs '),
                  style: TextStyle(
                    fontSize: 12.7,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  width: 100.0,
                  child: Text(
                    'Overall Profit'.toUpperCase(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
