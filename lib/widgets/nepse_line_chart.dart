import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/material.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/models/time_value_model.dart';
import 'package:nepal_stock/reuseables/custom_linear_progress.dart';
import 'package:nepal_stock/reuseables/line_chart.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:provider/provider.dart';

class NepseLineChart extends StatefulWidget {
  @override
  _NepseLineChartState createState() => _NepseLineChartState();
}

class _NepseLineChartState extends State<NepseLineChart> {
  String selectedTimeFrame = 'D';
  int selectedSymbol = 58;

  List<dynamic> indexValue;
  Map<String, dynamic> selectedIndexValue;
  List<TimeValueModel> indexChart;

  @override
  Widget build(BuildContext context) {
    indexValue =
        context.select((StockModel stockModel) => stockModel.getIndexValue());
    indexChart = context.select((StockModel stockModel) => stockModel.getIndexChart());
    if (indexValue.length > 0) {
      selectedIndexValue =
          indexValue.firstWhere((element) => element['id'] == selectedSymbol);
    }
    return Column(
      children: [
        Container(
            height: 200,
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.only(left: 10.0),
            child:
            indexChart != null  ? CustomLineChart(
              data: indexChart,
            ) : SizedBox.shrink()
        ),
        indexValue.length <= 0 || indexChart.length <= 0
            ? CustomLinearProgress()
            : SizedBox.shrink(),
        Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            dense: true,
            title: Text(
              selectedIndexValue != null
                  ? selectedIndexValue['index']
                  : 'NEPSE Index',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.caption.color,
                  ),
              // style: ,
            ),
            subtitle: Builder(
              builder: (context) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(
                      selectedIndexValue != null
                          ? selectedIndexValue['currentValue']
                              .toString()
                              .toCurrencyString()
                          : '0000.0',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        selectedIndexValue != null
                            ? selectedIndexValue['change'] == 0
                                ? SizedBox.shrink()
                                : Icon(
                                    selectedIndexValue != null
                                        ? selectedIndexValue['change'] > 0
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down
                                        : Icons.remove,
                                    size: 15.0,
                                    color: selectedIndexValue != null
                                        ? selectedIndexValue['change'] < 0
                                            ? Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150)
                                            : kColorGreen
                                        : Theme.of(context).textTheme.caption.color,
                                  )
                            : SizedBox.shrink(),
                        Text(
                          selectedIndexValue == null
                              ? '0.0'.toCurrencyString()
                              : selectedIndexValue['change']
                                  .toString()
                                  .toCurrencyString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedIndexValue != null
                                ? selectedIndexValue['change'] < 0
                                    ? Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150)
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
                      selectedIndexValue == null
                          ? '(0.0)'
                          : '(' +
                              selectedIndexValue['perChange'].toString() +
                              '%)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.7,
                        color: selectedIndexValue != null
                            ? selectedIndexValue['change'] < 0
                                ? Theme.of(context).brightness == Brightness.light ? kColorRed2 : kColorRed1.withAlpha(150)
                                : kColorGreen
                            : kColorGrey2,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Container(
                color: Theme.of(context).canvasColor,
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButton(
                  iconEnabledColor: kColorWhite2.withAlpha(200),
                  dropdownColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).canvasColor : kColorBlack2,
                  isDense: true,
                  underline: SizedBox.shrink(),
                  onChanged: (value) {
                    setState(() {
                      selectedSymbol = value;
                    });
                    context.read<StockModel>().setId(selectedSymbol);
                    context.read<StockModel>().setIndexChart(selectedSymbol);
                  },
                  value: selectedSymbol,
                  items: indexValue.map((element) {
                    return DropdownMenuItem(
                      value: element['id'],
                      child: Text(element['index'].toString()),
                    );
                  }).toList(),
                ),
              ),
              Container(
                color: Theme.of(context).canvasColor,
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButton(
                  iconEnabledColor: kColorWhite2.withAlpha(200),
                  dropdownColor: Theme.of(context).brightness == Brightness.light ? Theme.of(context).canvasColor : kColorBlack2,
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      selectedTimeFrame = value;
                    });
                  },
                  underline: SizedBox.shrink(),
                  value: selectedTimeFrame,
                  items: [
                    DropdownMenuItem(
                      value: 'D',
                      child: Text('daily'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
