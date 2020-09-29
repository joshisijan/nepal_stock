import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/reuseables/custom_linear_progress.dart';
import 'package:nepal_stock/reuseables/wrap_value.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MarketSummary extends StatelessWidget {
  double totalTurnover = 0.0;
  int totalTransactions = 0;
  int totalScrips = 0;
  int totalShares = 0;
  double totalCapital = 0.0;
  double totalFloatCapital = 0.0;
  List<dynamic> marketSummary;

  @override
  Widget build(BuildContext context) {

    marketSummary = context.select((StockModel stockModel) => stockModel.getMarketSummary());

    if(marketSummary.length > 0){
      totalTurnover = double.parse(marketSummary[0]['value'].toString());
      if(marketSummary.length > 1) totalShares = marketSummary[1]['value'];
      if(marketSummary.length > 2) totalTransactions = marketSummary[2]['value'];
      if(marketSummary.length > 3) totalScrips = marketSummary[3]['value'];
      if(marketSummary.length > 4) totalCapital = double.parse(marketSummary[4]['value'].toString());
      if(marketSummary.length > 5) totalFloatCapital = double.parse(marketSummary[5]['value'].toString());
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: [
          Container(
            color: Theme.of(context).cardColor,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market Summary',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
          SizedBox(
            height: 1.0,
          ),
          marketSummary.length <= 0
              ? CustomLinearProgress()
              : SizedBox.shrink(),
          marketSummary.length > 4 ? Container(
            color: Theme.of(context).cardColor,
            width: double.maxFinite,
            padding: EdgeInsets.all(10.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                WrapValue(
                  title: 'Total Turnover (Rs)',
                  moreSpacing: 10.0,
                  isBold: true,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalTurnover.toString().toCurrencyString(leadingSymbol: 'Rs. '),
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  title: 'Total Traded Shares',
                  moreSpacing: 10.0,
                  isBold: true,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalShares.toString().toCurrencyString(mantissaLength: 0),
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  title: 'Total Transactions',
                  moreSpacing: 10.0,
                  isBold: true,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalTransactions.toString().toCurrencyString(mantissaLength: 0),
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  title: 'Total Scrips Traded',
                  moreSpacing: 10.0,
                  isBold: true,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalScrips.toString().toCurrencyString(mantissaLength: 0),
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  title: 'Total Market Capitalization (Rs)',
                  moreSpacing: 10.0,
                  isBold: true,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalCapital.toString().toCurrencyString(leadingSymbol: 'Rs. '),
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  title: 'Total Float Market Capitalization (Rs)',
                  color: Theme.of(context).textTheme.caption.color,
                  moreSpacing: 10.0,
                  isBold: true,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalFloatCapital.toString().toCurrencyString(leadingSymbol: 'Rs. '),
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ],
            ),
          ) : Container(
            color: Theme.of(context).cardColor,
            width: double.maxFinite,
            padding: EdgeInsets.all(10.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                WrapValue(
                  title: 'Total Turnover (Rs)',
                  color: Theme.of(context).textTheme.caption.color,
                  moreSpacing: 10.0,
                  isBold: true,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalTurnover.toString().toCurrencyString(leadingSymbol: 'Rs. '),
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  title: 'Total Traded Shares',
                  moreSpacing: 10.0,
                  color: Theme.of(context).textTheme.caption.color,
                  isBold: true,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalShares.toString().toCurrencyString(mantissaLength: 0),
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  title: 'Total Transactions',
                  moreSpacing: 10.0,
                  isBold: true,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalTransactions.toString().toCurrencyString(mantissaLength: 0),
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  title: 'Total Scrips Traded',
                  moreSpacing: 10.0,
                  isBold: true,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                WrapValue(
                  moreSpacing: 10.0,
                  title: totalScrips.toString().toCurrencyString(mantissaLength: 0),
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
