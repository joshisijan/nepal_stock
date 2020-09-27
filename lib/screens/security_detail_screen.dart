import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_stock/api/api_url.dart';
import 'package:nepal_stock/reuseables/offline_status.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:nepal_stock/widgets/security_detail_day.dart';

class SecurityDetailScreen extends StatefulWidget {
  final String id;
  final String symbol;

  const SecurityDetailScreen({
    Key key,
    @required this.id,
    @required this.symbol,
  }) : super(key: key);

  @override
  _SecurityDetailScreenState createState() => _SecurityDetailScreenState();
}

class _SecurityDetailScreenState extends State<SecurityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.symbol ?? ''),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: kColorGreen,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
            SizedBox(
              width: 15.0,
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              child: FutureBuilder(
                future: http.get('$kSecurityDetail/${widget.id}'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text('An error occurred. Try again later.'));
                    } else {
                      if (snapshot.data == null) {
                        return Center(
                            child: Text(
                                'No data at the moment. Try again later.'));
                      } else {
                        if (snapshot.data.statusCode != 200) {
                          return Center(
                              child:
                                  Text('An error occurred. Try again later.'));
                        } else {
                          var data = snapshot.data.body;
                          var jsonData = jsonDecode(snapshot.data.body);
                          return ListView(
                            padding: EdgeInsets.all(20.0),
                            children: [
                              SecurityDetailDay(
                                securityName: jsonData['security']['securityName'],
                                data: jsonData['securityDailyTradeDto'],
                              ),
                              //for offline status
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          );
                        }
                      }
                    }
                  }
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: OfflineStatus(),
            ),
          ],
        ));
  }
}
