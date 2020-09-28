import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:connection_verify/connection_verify.dart';

class OfflineStatus extends StatefulWidget {
  @override
  _OfflineStatusState createState() => _OfflineStatusState();
}

class _OfflineStatusState extends State<OfflineStatus> {
  bool connected = true;
  bool justConnected = false;
  Timer timer;
  Timer justConnectedTimer;

  @override
  void initState() {
    super.initState();
    getConnectionStatus();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getConnectionStatus();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  getConnectionStatus() async {
    var tempConnected = await ConnectionVerify.connectionStatus();
    if (tempConnected != connected) {
      setState(() {
        connected = tempConnected;
        if (connected == true) {
          justConnected = true;
          justConnectedTimer = Timer(Duration(seconds: 3), () {
            setState(() {
              justConnected = false;
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorBlack1,
      child: !connected
          ? Container(
              color: Theme.of(context).brightness == Brightness.light ? kColorRed1 : kColorRed1.withAlpha(200),
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'You are offline. Check your connection.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.7,
                ),
              ),
            )
          : justConnected
              ? Container(
                  color: kColorGreen,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'You\'re online.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.7,
                    ),
                  ),
                )
              : SizedBox.shrink(),
    );
  }
}
