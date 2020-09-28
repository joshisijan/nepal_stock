import 'package:flutter/material.dart';

class CustomLinearProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Theme.of(context).brightness == Brightness.light ? 3.0 : 1.0,
      child: LinearProgressIndicator(),
    );
  }
}
