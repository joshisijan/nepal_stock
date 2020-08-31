import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../functions/ns.dart';
import '../widgets/widgets.dart';
import 'symbol_detail.dart';

class Symbols extends StatefulWidget {
  @override
  _SymbolsState createState() => _SymbolsState();
}

class _SymbolsState extends State<Symbols> {

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
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Symbols',
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
              child: Container(
                child: FutureBuilder(
                  key: symbolsStorageKey,
                  future: NepalStockScrap.getSymbols(),
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
                        if(data == null || data.length <= 0){
                          return Container(
                            child: Center(
                              child: Text(
                                'An error occurred. Please reload',
                                style: TextStyle(color: Palette.white),
                              ),
                            ),
                          );
                        }
                        return Container(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: data.map<Widget>((symbol) {
                              if(symbol['attributes']['value'] != ''){
                                return DoubledListItem(
                                  title: symbol['title'],
                                  iconBackgroundColor: Colors.green,
                                  noSymbol: true,
                                  iconColor: Colors.white,
                                  icon: Icons.info,
                                  isCentered: true,
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context){
                                          return SymbolDetail(
                                            name: symbol['title'],
                                            value: symbol['attributes']['value'],
                                          );
                                        }
                                    ));
                                  },
                                );
                              }else{
                                return SizedBox.shrink();
                              }
                            }).toList(),
                          ),
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
