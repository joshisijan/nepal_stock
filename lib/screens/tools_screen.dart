import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 32.0,
          ),
          Text(
            'Tools',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          //for offline status
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
