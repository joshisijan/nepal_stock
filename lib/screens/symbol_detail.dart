import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../functions/ns.dart';
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
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return SymbolChart(
                            name: this.widget.name,
                            value: this.widget.value,
                          );
                        }
                    ));
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
                  top: 50.0,
                  bottom: 20.0,
                  left: 20.0,
                  right: 20.0
                ),
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
            SliverToBoxAdapter(
              child: Container(
                child: FutureBuilder(
                  key: symbolsStorageKey,
                  future: NepalStockScrap.symbolDetail(this.widget.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 2 - 100),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 8.0,
                          ),
                        ),
                      );
                    } else {
                      if (snapshot.hasError) {
                        return Container(
                          child: Center(
                            child: Text(
                              'An error occurred. Please reload',
                              style: TextStyle(color: Palette.white),
                            ),
                          ),
                        );
                      } else {
                        var data = snapshot.data;
                        if (data == null || data.length <= 0) {
                          return Container(
                            child: Center(
                              child: Text(
                                'An error occurred. Please reload',
                                style: TextStyle(color: Palette.white),
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              child: Text(
                                data[0]['title'],
                                style: Theme.of(context).textTheme.subtitle1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DoubledList(
                              children: [
                                DoubledListItem(
                                  icon: Icons.location_on,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  isCentered: true,
                                  title: 'Address',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[6]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.email,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.red,
                                  isCentered: true,
                                  title: 'Email Address',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[8]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.attach_file,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.green,
                                  isCentered: true,
                                  title: 'Website',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[10]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.attach_money,
                                  iconColor: Palette.black,
                                  iconBackgroundColor: Colors.yellow,
                                  isCentered: true,
                                  title: 'Last Traded Price (LTP) (Rs.)',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[12]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.show_chart,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.red,
                                  isCentered: true,
                                  title: 'Change (Rs) and (%)',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[14]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.view_stream,
                                  iconColor: Palette.black,
                                  iconBackgroundColor: Colors.amber,
                                  isCentered: true,
                                  title: 'Total Listed Shares',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[16]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.monetization_on,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.teal,
                                  isCentered: true,
                                  title: 'Paid Up Value (Rs.)',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[18]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.account_balance,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.indigo,
                                  isCentered: true,
                                  title: 'Total Paid Up Value (Rs.)',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[20]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.show_chart,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.pink,
                                  isCentered: true,
                                  title: 'Closing Market Price (Rs.)',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.info,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[22]['title'],
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.attach_money,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.purple,
                                  isCentered: true,
                                  title: 'Market Capitalization (Rs.)',
                                  onPressed: (){

                                  },
                                ),
                                DoubledListItem(
                                  icon: Icons.account_balance,
                                  iconColor: Colors.white,
                                  iconBackgroundColor: Colors.blue,
                                  noSymbol: true,
                                  title: data[24]['title'],
                                  onPressed: (){

                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
