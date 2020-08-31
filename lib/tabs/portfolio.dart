import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../models/Symbol.dart';

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
            padding: EdgeInsets.symmetric(
              vertical: 50.0,
              horizontal: 20.0,
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
                  onPressed: (){
                    Symbol.insertSymbol(Symbol(
                      symbol: 'ARR',
                      value: '102',
                    ));
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: MaterialButton(
              child: Text('delete data'),
              onPressed: (){
                Symbol.deleteAllSymbol();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: StreamBuilder(
              stream: Symbol.getSymbol().asStream(),
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
                          style: TextStyle(color: Palette.darkGreen),
                        ),
                      ),
                    );
                  } else {
                    var data = snapshot.data;
                    if (data == null) {
                      return Container(
                        child: Center(
                          child: Text(
                            'An error occurred. Please reload',
                            style: TextStyle(color: Palette.darkGreen),
                          ),
                        ),
                      );
                    }else if(data.length <= 0){
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 2 - 100),
                        child: Center(
                          child: Text(
                            'Nothing added to portfolio yet!\nAdd by clicking the add button from top.',
                            style: TextStyle(color: Palette.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: snapshot.data.map<Widget>((symbol){
                        return ListTile(
                          title: Text(symbol.symbol.toString()),
                        );
                      }).toList(),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
