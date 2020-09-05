import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../widgets/widgets.dart';
import 'symbol_chart.dart';

class SymbolDetail extends StatefulWidget {
  final String name, value;

  const SymbolDetail({Key key, @required this.name, @required this.value})
      : super(key: key);

  @override
  _SymbolDetailState createState() => _SymbolDetailState();
}

class _SymbolDetailState extends State<SymbolDetail> {
  final PageStorageKey symbolsStorageKey = PageStorageKey('symbols');

  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: pageStorageBucket,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Palette.black,
              actions: [
                DoubledListItem(
                  icon: Icons.show_chart,
                  iconColor: Colors.white,
                  iconBackgroundColor: Colors.blue,
                  title: 'View Chart',
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SymbolChart(
                        name: this.widget.name,
                        value: this.widget.value,
                      );
                    }));
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(
                    top: 50.0, bottom: 20.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      this.widget.name,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      iconSize: 30.0,
                      padding: EdgeInsets.all(10.0),
                      color: Palette.darkGreen,
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
