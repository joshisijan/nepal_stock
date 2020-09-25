import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_stock/api/api_url.dart';
import '../styles/colors.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class MarketStatus extends StatefulWidget {
  @override
  _MarketStatusState createState() => _MarketStatusState();
}

class _MarketStatusState extends State<MarketStatus> {
  String isOpen = "";
  String asOf = "";
  var status;
  var index;

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => getAll());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // combination of all future getters
  getAll() {
    getStatus();
    getIndex();
  }

  //gets market status
  void getStatus() async {
    try {
      var response = await http.get(kStatus);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (status != jsonData) {
          if (jsonData['isOpen'] == "CLOSE") {
            setState(() {
              isOpen = "Market Closed";
              asOf = jsonData["asOf"];
            });
          } else {
            setState(() {
              isOpen = "Market Open";
              asOf = jsonData["asOf"];
            });
          }
          status = jsonData;
        }
      }
    } catch (e) {

    }
  }

  //gets indexed data
  void getIndex() async {
    try {
      var response = await http.get(kIndex);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var temp;
        for (int i = 1; i < jsonData.length; i++) {
          if (jsonData[i]['id'].toString() == '58') {
            temp = jsonData[i];
          }
        }
        jsonData = temp;
        if (index != jsonData) {
          setState(() {
            index = jsonData;
          });
        }
      }
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      color: kColorBlack2,
      child: ListTile(
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
                  index == null
                      ? '0000.00'.toCurrencyString()
                      : index['currentValue'].toString().toCurrencyString(),
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
                    Icon(
                      index != null
                          ? index['change'] > 0
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down
                          : Icons.remove,
                      size: 15.0,
                      color: index != null
                          ? index['change'] > 0
                              ? kColorGreen
                              : kColorRed.withAlpha(150)
                          : kColorGrey2,
                    ),
                    Text(
                      index == null
                          ? '0.0'.toCurrencyString()
                          : index['change'].toString().toCurrencyString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: index != null
                            ? index['change'] > 0
                                ? kColorGreen
                                : kColorRed.withAlpha(150)
                            : kColorGrey2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  index == null
                      ? '(0.0)'
                      : '(' + index['perChange'].toString() + '%)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.7,
                    color: index != null
                        ? index['change'] > 0
                            ? kColorGreen
                            : kColorRed.withAlpha(150)
                        : kColorGrey2,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              status != null && asOf != ''
                  ? DateFormat("d MMMM, y | hh:mm a")
                      .format(DateTime.parse(asOf))
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
            color: status == null
                ? kColorBlack1
                : status['isOpen'] == "CLOSE"
                    ? kColorRed.withAlpha(150)
                    : kColorGreen,
          ),
          child: Text(
            status == null ? 'Loading...' : isOpen,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
            ),
          ),
        ),
        leading: status == null || index == null
            ? CircularProgressIndicator()
            : null,
      ),
    );
  }
}
