import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nepal_stock/styles/colors.dart';

class CustomFlutterToast {
  showToast(String msg, IconData icon,double paddingTop, BuildContext context) {
    FToast()..init(context);
    FToast()..removeCustomToast();
    FToast()
      ..showToast(
          child: Dismissible(
            key: Key(
                'this key must not match with other key so i am just typing anything that comes in my mind'),
            onDismissed: (dismissDirection) {},
            direction: DismissDirection.up,
            child: Container(
              color: kColorBlack1,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: paddingTop),
                    color: kColorGreen.withAlpha(180),
                    child: Column(
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                          leading: Icon(icon, color: Theme.of(context).textTheme.subtitle1.color,),
                          title: Container(child: Text(msg), alignment: Alignment.centerLeft,),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          gravity: ToastGravity.TOP,
          toastDuration: Duration(seconds: 5),
          positionedToastBuilder: (context, child) {
            return Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: child,
            );
          });
  }
}
