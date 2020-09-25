import 'dart:async';
import 'dart:convert';

import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/material.dart';
import 'package:nepal_stock/api/api_url.dart';
import 'package:nepal_stock/models/time_value_model.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:nepal_stock/widgets/line_chart.dart';
import 'package:http/http.dart' as http;

class NepseLineChart extends StatefulWidget {
  @override
  _NepseLineChartState createState() => _NepseLineChartState();
}

class _NepseLineChartState extends State<NepseLineChart> {
  List<TimeValueModel> data = [];
  double min = 0.0;
  double max = 2000.0;
  var symbolValue;
  var totalIndex;

  String selectedTimeFrame = 'D';
  int selectedSymbol = 58;
  bool progressShown = true;

  List<DropdownMenuItem> dropDownMenuListIndex = [];

  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIndex();
    getTimeValue(selectedSymbol);
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      getIndex();
      getTimeValue(selectedSymbol);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        progressShown ? LinearProgressIndicator() : SizedBox.shrink(),
        Container(
          height: 200,
          color: kColorBlack2,
          padding: EdgeInsets.only(left: 10.0),
          child: CustomLineChart(
            data: data,
            min: min,
            max: max,
          ),
        ),
        symbolValue != null
            ? Container(
                color: kColorBlack2,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  dense: true,
                  title: Text(
                    symbolValue['index'].toString(),
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    // style: ,
                  ),
                  subtitle: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text(
                        symbolValue['currentValue']
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
                          symbolValue['change'] > 0
                              ? Icon(
                                  symbolValue['change'] == 0
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 15.0,
                                  color: symbolValue['change'] < 0
                                      ? kColorRed.withAlpha(150)
                                      : kColorGreen,
                                )
                              : SizedBox.shrink(),
                          Text(
                            symbolValue['change'].toString().toCurrencyString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: symbolValue['change'] < 0
                                  ? kColorRed.withAlpha(150)
                                  : kColorGreen,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '(' + symbolValue['perChange'].toString() + '%)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.7,
                          color: symbolValue['change'] < 0
                              ? kColorRed.withAlpha(150)
                              : kColorGreen,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : SizedBox.shrink(),
        Container(
          color: kColorBlack2,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          width: double.maxFinite,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Container(
                color: kColorBlack1,
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButton(
                  isDense: true,
                  underline: SizedBox.shrink(),
                  onChanged: (value) {
                    setState(() {
                      selectedSymbol = value;
                    });
                    getTimeValue(selectedSymbol);
                    setState(() {
                      progressShown = true;
                    });
                    totalIndex == null ? getIndex() : getIndexDataOffline();
                  },
                  value: selectedSymbol,
                  dropdownColor: kColorBlack2,
                  items: dropDownMenuListIndex.length == 0
                      ? [
                          DropdownMenuItem(
                            value: 58,
                            child: Text('Loading...'),
                          ),
                        ]
                      : dropDownMenuListIndex,
                ),
              ),
              Container(
                color: kColorBlack1,
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButton(
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

  getIndexDataOffline() async {
    try {
      for (int i = 0; i < totalIndex.length; i++) {
        if (totalIndex[i]['id'].toString() == selectedSymbol.toString()) {
          symbolValue = totalIndex[i];
        }
      }
    } catch (e) {}
  }

  getIndex() async {
    try {
      var indexValue = await http.get(kIndex);
      var jsonData = jsonDecode(indexValue.body);
      totalIndex = jsonData;
      List<DropdownMenuItem> temp = [];
      for (int i = 0; i < jsonData.length; i++) {
        if (jsonData[i]['id'].toString() == selectedSymbol.toString()) {
          symbolValue = jsonData[i];
        }
        temp.add(DropdownMenuItem(
          value: jsonData[i]['id'].toInt(),
          child: Text(jsonData[i]['index'].toString()),
        ));
      }
      if (temp != dropDownMenuListIndex) {
        setState(() {
          dropDownMenuListIndex = temp;
        });
      }
    } catch (e) {}
  }

  getTimeValue(id) async {
    try {
      List<TimeValueModel> temp = [];
      var timeValue = await http.get('$kTimeValue/${id.toString()}');
      var jsonData = jsonDecode(timeValue.body);
      max = -100000000.0;
      min = 100000000.0;
      for (int i = 0; i < jsonData.length; i++) {
        if (double.parse(jsonData[i][1].toString()) < min) {
          min = double.parse(jsonData[i][1].toString());
        }
        if (double.parse(jsonData[i][1].toString()) > max) {
          max = double.parse(jsonData[i][1].toString());
        }
        temp.add(TimeValueModel(
            DateTime.fromMillisecondsSinceEpoch(jsonData[i][0] * 1000),
            double.parse(jsonData[i][1].toString())));
      }
      if(min == 100000000.0) min = 0;
      if(max == -100000000.0) max = 2000;
      if (data != temp) {
        setState(() {
          data = temp;
          progressShown = false;
        });
      } else {
        setState(() {
          progressShown = false;
        });
      }
    } catch (e) {
      
    }
  }
}
