import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepal_stock/reuseables/detail_header.dart';
import 'package:nepal_stock/reuseables/wrap_value.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class SecurityDetailDay extends StatelessWidget {
  final String securityName;
  final Map<String, dynamic> data;

  const SecurityDetailDay({
    Key key,
    @required this.securityName,
    @required this.data, 
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double changePrice = -(double.parse(data['previousClose'].toString()) - double.parse(data['lastTradedPrice'].toString()));
    double perChange = (changePrice / double.parse(data['previousClose'].toString())) * 100;
    if(changePrice == -0.0) changePrice = 0.0;
    if(perChange == -0.0) perChange = 0.0;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            securityName ?? '',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
        ),
        DetailHeader(
          header: 'Daily Trade Detail',
        ),
        Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          width: double.maxFinite,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              WrapValue(
                title: 'Updated Time',
                moreSpacing: -10.0,
                isBold: true,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                moreSpacing: -10.0,
                title: DateFormat("d MMMM, y | hh:mm a").format(
                    DateTime.parse(data['lastUpdatedDateTime'].toString())),
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: 'Last Traded Price',
                isBold: true,
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: data['lastTradedPrice'].toString().toCurrencyString(leadingSymbol: 'Rs ') + ' ' + (changePrice < 0 ? String.fromCharCode(8595) : changePrice != 0 ? String.fromCharCode(8593) : '') + ' ' + changePrice.toString().toCurrencyString() + ' (' + perChange.toString().toCurrencyString() + '%)',
                color: changePrice < 0 ? Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150) : kColorGreen,
                moreSpacing: -10.0,
              ),
              WrapValue(
                title: 'Total Traded Quantity',
                isBold: true,
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: data['totalTradeQuantity'].toString().toCurrencyString(mantissaLength: 0,),
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: 'Total Trades',
                moreSpacing: -10.0,
                isBold: true,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: data['totalTrades'].toString().toCurrencyString(mantissaLength: 0,),
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: 'Previous Day Closing Price',
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
                isBold: true,
              ),
              WrapValue(
                title: data['lastTradedPrice'].toString().toCurrencyString(leadingSymbol: 'Rs ',),
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: 'High | Low',
                moreSpacing: -10.0,
                isBold: true,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
                title: data['highPrice'].toString().toCurrencyString(leadingSymbol: 'Rs ',) + ' | ' + data['lowPrice'].toString().toCurrencyString(leadingSymbol: 'Rs ',),
              ),
              WrapValue(
                title: '52 week high',
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
                isBold: true,
              ),
              WrapValue(
                title: data['fiftyTwoWeekHigh'].toString().toCurrencyString(leadingSymbol: 'Rs ',),
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: '52 week low',
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
                isBold: true,
              ),
              WrapValue(
                title: data['fiftyTwoWeekLow'].toString().toCurrencyString(leadingSymbol: 'Rs ',),
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: 'Open Price',
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
                isBold: true,
              ),
              WrapValue(
                title: data['openPrice'].toString().toCurrencyString(leadingSymbol: 'Rs ',),
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
              WrapValue(
                title: 'Close Price',
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
                isBold: true,
              ),
              WrapValue(
                title: data['closePrice'].toString().toCurrencyString(leadingSymbol: 'Rs ',),
                moreSpacing: -10.0,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

