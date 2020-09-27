import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/models/watchlist_model.dart';
import 'package:nepal_stock/reuseables/add_button.dart';
import 'package:nepal_stock/reuseables/confirm_alert.dart';
import 'package:nepal_stock/screens/search_delegate_screen.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WatchlistScreen extends StatelessWidget {
  List<dynamic> companies;
  List<WatchlistModel> allWatchlist;
  @override
  Widget build(BuildContext context) {
    companies =
        context.select((StockModel stockModel) => stockModel.getCompanies());
    return Consumer<WatchlistModel>(
      builder: (context, watchlistConsumer, __) {
        watchlistConsumer.setAllWatchlist();
        allWatchlist = watchlistConsumer.getAllWatchlist();
        return ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 32.0,
            ),
            Text(
              'My Watchlist',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
            AddButton(
              alignment: Alignment.centerLeft,
              loading: companies.length > 0 ? false : true,
              onPressed: companies.length > 0
                  ? () {
                      showSearch(
                          context: context,
                          delegate: SearchDelegateScreen(
                            companies: companies,
                            typeInt: 2,
                          ));
                    }
                  : null,
            ),
            allWatchlist != null
                ? allWatchlist.length > 0
                    ? Column(
                        children: allWatchlist.map((element) {
                          return Container(
                            color: kColorBlack1.withAlpha(150),
                            margin: EdgeInsets.symmetric(vertical: 1.0),
                            child: ListTile(
                              dense: true,
                              isThreeLine: true,
                              title: Text(element.symbol),
                              subtitle: Text(element.name),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ConfirmAlert(
                                          title: 'Remove from watchlist',
                                          content:
                                              'Do you really want to remove  ${element.symbol} (${element.name}) from watchlist?',
                                          onYes: () {
                                            WatchlistModel()
                                                .deleteWatchlist(element.id);
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      });
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.bookmark, size: 36.0,),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Nothing found on your Watchlist.',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ))
                : SizedBox.shrink(),
            //for offline status
            SizedBox(
              height: 20.0,
            ),
          ],
        );
      },
    );
  }
}
