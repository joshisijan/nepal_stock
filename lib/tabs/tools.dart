import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ToolsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 20.0,
          ),
          child: Text(
            'Tools',
            style: Theme.of(context).textTheme.headline2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
