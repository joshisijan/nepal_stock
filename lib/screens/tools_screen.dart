import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top + 24.0,
            color: Theme.of(context).canvasColor,
          ),
          Container(
            color: Theme.of(context).canvasColor,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Tools',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
          ),
          Container(
            height: 24.0,
            color: Theme.of(context).canvasColor,
          ),
          //for offline status
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
