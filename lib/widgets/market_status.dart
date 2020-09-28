import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/reuseables/custom_linear_progress.dart';
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
      margin: EdgeInsets.only(bottom: 15.0),
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
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
                      style: Theme.of(context).textTheme.subtitle1,
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
                                            ? Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150)
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
                                    ? Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150)
                                    : nepseIndexValue['change'] == 0
                                        ? Theme.of(context).textTheme.subtitle1.color
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
                            ? Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150)
                            : nepseIndexValue['change'] == 0
                            ? Theme.of(context).textTheme.subtitle1.color
                            : kColorGreen
                            : Theme.of(context).textTheme.subtitle1.color,
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
                    color: Theme.of(context).textTheme.subtitle1.color,
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: marketStatus == null
                    ? Theme.of(context).canvasColor
                    : marketStatus['isOpen'] == "CLOSE"
                        ? Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150)
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
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          marketStatus == null || nepseIndexValue == null
              ? CustomLinearProgress()
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
