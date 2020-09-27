import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepal_stock/models/stock_model.dart';
import '../styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class MarketStatus extends StatefulWidget {
  @override
  _MarketStatusState createState() => _MarketStatusState();
}

class _MarketStatusState extends State<MarketStatus> {
  Map<String, dynamic> marketStatus, nepseIndexValue;
  @override
  Widget build(BuildContext context) {
    marketStatus =
        context.select((StockModel stockModel) => stockModel.getMarketStatus());
    nepseIndexValue = context
        .select((StockModel stockModel) => stockModel.getNepseIndexValue());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      color: kColorBlack1.withAlpha(150),
      child: Column(
        children: [
          marketStatus == null || nepseIndexValue == null
              ? Container(height: 1.0, child: LinearProgressIndicator())
              : SizedBox.shrink(),
          ListTile(
            isThreeLine: true,
            dense: true,
            title: Text(
              'NEPSE',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(
                      nepseIndexValue == null
                          ? '0000.00'.toCurrencyString()
                          : nepseIndexValue['currentValue']
                              .toString()
                              .toCurrencyString(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: kColorGrey2,
                          ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        nepseIndexValue != null
                            ? nepseIndexValue['change'] == 0
                                ? SizedBox.shrink()
                                : Icon(
                                    nepseIndexValue != null
                                        ? nepseIndexValue['change'] > 0
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down
                                        : Icons.remove,
                                    size: 15.0,
                                    color: nepseIndexValue != null
                                        ? nepseIndexValue['change'] < 0
                                            ? kColorRed.withAlpha(150)
                                            : kColorGreen
                                        : kColorGrey2,
                                  )
                            : SizedBox.shrink(),
                        Text(
                          nepseIndexValue == null
                              ? '0.0'.toCurrencyString()
                              : nepseIndexValue['change']
                                  .toString()
                                  .toCurrencyString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: nepseIndexValue != null
                                ? nepseIndexValue['change'] < 0
                                    ? kColorRed.withAlpha(150)
                                    : nepseIndexValue['change'] == 0
                                        ? kColorGrey2
                                        : kColorGreen
                                : kColorGrey2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      nepseIndexValue == null
                          ? '(0.0)'
                          : '(' + nepseIndexValue['perChange'].toString() + '%)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.7,
                        color: nepseIndexValue != null
                            ? nepseIndexValue['change'] < 0
                            ? kColorRed.withAlpha(150)
                            : nepseIndexValue['change'] == 0
                            ? kColorGrey2
                            : kColorGreen
                            : kColorGrey2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  marketStatus != null && marketStatus['asOf'] != ''
                      ? DateFormat("d MMMM, y | hh:mm a")
                          .format(DateTime.parse(marketStatus['asOf']))
                      : '',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: kColorGrey2,
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: marketStatus == null
                    ? kColorBlack1
                    : marketStatus['isOpen'] == "CLOSE"
                        ? kColorRed.withAlpha(150)
                        : kColorGreen,
              ),
              child: Text(
                marketStatus == null
                    ? 'Loading...'
                    : marketStatus['isOpen'] == 'CLOSE'
                        ? 'Market Closed'
                        : 'Market Open',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
