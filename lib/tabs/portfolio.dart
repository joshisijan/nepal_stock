import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepal_stock/functions/watchlist_repo.dart';
import '../config/palette.dart';

class PortfolioTab extends StatefulWidget {
  @override
  _PortfolioTabState createState() => _PortfolioTabState();
}

class _PortfolioTabState extends State<PortfolioTab> {
  final PageStorageKey portfolioStorageKey = PageStorageKey('portfolio');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: portfolioStorageKey,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 50.0,
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Portfolio',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                FlatButton.icon(
                  color: Palette.lightBlack,
                  icon: Icon(
                    Icons.add,
                    color: Palette.darkGreen,
                  ),
                  label: Text('Add'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          MaterialButton(
            child: Text('delete data'),
            onPressed: () {},
          ),
          FutureBuilder(
            future: WatchlistRepo.instance().getSymbols(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Text('Loading');
              else {
                if (snapshot.hasError)
                  return Text(snapshot.error.toString());
                else {
                  var data = snapshot.data;
                  if (data == null)
                    return Text('Null Error');
                  else if (data.length <= 0)
                    return Text('Nothing added yet');
                  else
                    return Column(
                      children: data.map<Widget>((symbol) {
                        return ListTile(
                          title: Text(symbol.id.toString() +
                              ' . ' +
                              symbol.symbol.toString()),
                        );
                      }).toList(),
                    );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
