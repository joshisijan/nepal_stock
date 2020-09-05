import 'package:flutter/material.dart';
import '../config/palette.dart';

class TabldeSymbolWidget extends StatelessWidget {
  final String symbol;
  final String id;
  final Function onPressed;

  const TabldeSymbolWidget({
    Key key,
    @required this.symbol,
    @required this.id,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabledSymbol(
      id: this.id,
      symbol: this.symbol,
      onPressed: this.onPressed,
    );
  }
}

class TabledSymbol extends StatelessWidget {
  final String symbol;
  final String id;
  final Function onPressed;

  const TabledSymbol({
    Key key,
    @required this.symbol,
    @required this.id,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      dense: true,
      title: Wrap(
        alignment: WrapAlignment.spaceAround,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(this.symbol),
          Text('2000'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '10',
                style: TextStyle(color: Palette.lightGreen),
              ),
              Icon(
                Icons.arrow_drop_up,
                color: Palette.lightGreen,
              ),
            ],
          ),
          Text(
            '0.5%',
            style: TextStyle(color: Palette.lightGreen),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: this.onPressed,
      ),
    );
  }
}
