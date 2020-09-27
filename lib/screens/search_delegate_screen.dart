import 'package:flutter/material.dart';
import 'package:nepal_stock/models/watchlist_model.dart';
import 'package:nepal_stock/reuseables/confirm_alert.dart';
import 'package:nepal_stock/screens/security_detail_screen.dart';

class SearchDelegateScreen extends SearchDelegate {
  final List<dynamic> companies;
  final int typeInt; // 0 default 1 for portfolio and 2 for watchlist

  SearchDelegateScreen({@required this.companies, this.typeInt = 0});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return getResult(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != '') {
      return getResult(context);
    }
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (item, index) {
        return ListTile(
          dense: true,
          isThreeLine: true,
          title: Text(companies[index]['symbol'].toString()),
          subtitle: Text(companies[index]['securityName'].toString()),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if(typeInt == 2){
                WatchlistModel().checkExists(companies[index]['id']).then((value){
                  if(value == true){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmAlert(
                          title: 'Already in Watchlist',
                          content:
                          '${companies[index]['symbol']} (${companies[index]['securityName']}) is already in your watchlist.',
                          onYes: () {
                            Navigator.pop(context);
                          },
                          showNo: false,
                        );
                      },
                    );
                  }else{
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmAlert(
                          title: 'Add to Watchlist',
                          content:
                          'Do you want to add ${companies[index]['symbol']} (${companies[index]['securityName']}) to watchlist?',
                          onYes: () {
                            WatchlistModel().insertWatchlist(WatchlistModel(
                              id: companies[index]['id'].toString(),
                              symbol: companies[index]['symbol'].toString(),
                              name: companies[index]['securityName'].toString(),
                            ));
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                });
              }
            },
          ),
          onTap: () {
            print(companies[index]['id'].toString());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SecurityDetailScreen(
                      id: companies[index]['id'].toString(),
                      symbol: companies[index]['symbol'].toString(),
                    )));
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark();
  }

  Widget getResult(BuildContext context) {
    var result = companies.where((element) {
      return element['companyName'].toString().toLowerCase().contains(query) ||
          element['symbol'].toString().toLowerCase().contains(query) ||
          element['securityName'].toString().toLowerCase().contains(query);
    }).toList();
    if (result.length <= 0) {
      return Center(
        child: Text('Nothing found. Change your search query.'),
      );
    }
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (item, index) {
        return ListTile(
          dense: true,
          isThreeLine: true,
          title: Text(result[index]['symbol'].toString()),
          subtitle: Text(result[index]['securityName'].toString()),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if(typeInt == 2){
                WatchlistModel().checkExists(companies[index]).then((value){
                  if(value == true){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmAlert(
                          title: 'Already in Watchlist',
                          content:
                          '${companies[index]['symbol']} (${companies[index]['securityName']}) is already in your watchlist.',
                          onYes: () {
                            Navigator.pop(context);
                          },
                          showNo: false,
                        );
                      },
                    );
                  }else{
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmAlert(
                          title: 'Add to Watchlist',
                          content:
                          'Do you want to add ${companies[index]['symbol']} (${companies[index]['securityName']}) to watchlist?',
                          onYes: () {
                            WatchlistModel().insertWatchlist(WatchlistModel(
                              id: companies[index]['id'].toString(),
                              symbol: companies[index]['symbol'].toString(),
                              name: companies[index]['securityName'].toString(),
                            ));
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                });
              }
            },
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SecurityDetailScreen(
                      id: result[index]['id'].toString(),
                      symbol: result[index]['symbol'].toString(),
                    )));
          },
        );
      },
    );
  }
}
