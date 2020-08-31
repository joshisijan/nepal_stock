import 'package:flutter/material.dart';
import '../config/palette.dart';


class SymbolChart extends StatefulWidget {
  final String name, value;

  const SymbolChart({Key key, @required this.name, @required this.value})
      : super(key: key);
  @override
  _SymbolChartState createState() => _SymbolChartState();
}

class _SymbolChartState extends State<SymbolChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Palette.black,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(
                    top: 50.0,
                    bottom: 20.0,
                    left: 20.0,
                    right: 20.0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Charts',
                      style: Theme.of(context).textTheme.headline2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      iconSize: 30.0,
                      padding: EdgeInsets.all(10.0),
                      color: Palette.darkGreen,
                      onPressed: (){
                        setState((){ });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Symbol : ' + this.widget.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Theme.of(context).textTheme.caption.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
