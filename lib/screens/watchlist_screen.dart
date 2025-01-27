import 'package:flutter/material.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/models/watchlist_model.dart';
import 'package:nepal_stock/reuseables/add_button.dart';
import 'package:nepal_stock/reuseables/confirm_alert.dart';
import 'package:nepal_stock/screens/search_delegate_screen.dart';
import 'package:nepal_stock/screens/security_detail_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<dynamic> companies;

  List<WatchlistModel> allWatchlist;

  @override
  void initState() {
    super.initState();
    context.read<WatchlistModel>().setAllWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    companies =
        context.select((StockModel stockModel) => stockModel.getCompanies());
    allWatchlist = context.select((WatchlistModel watchlistModel) => watchlistModel.getAllWatchlist());
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top + 24.0,
          color: Theme.of(context).canvasColor,
        ),
        Container(
          color: Theme.of(context).canvasColor,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'My Watchlist',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
              color: Theme.of(context).textTheme.subtitle1.color,
            ),
          ),
        ),
        Container(
          color: Theme.of(context).canvasColor,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: AddButton(
            alignment: Alignment.centerLeft,
            loading: companies.length > 0 ? false : true,
            onPressed: companies.length > 0
                ? () {
              showSearch(
                context: context,
                delegate: SearchDelegateScreen(
                  companies: companies,
                  typeInt: 2,
                  paddingTop: MediaQuery.of(context).padding.top,
                ),
              );
            }
                : null,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        allWatchlist != null
            ? allWatchlist.length > 0
            ? Column(
          children: allWatchlist.map((element) {
            return Container(
              color: Theme.of(context).cardColor,
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                dense: true,
                isThreeLine: true,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SecurityDetailScreen(
                      id: element.id,
                      symbol: element.symbol,
                    ),
                  ));
                },
                title: Text(
                  element.symbol,
                  style: TextStyle(
                    color:
                    Theme.of(context).textTheme.caption.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  element.name,
                  style: TextStyle(
                    color:
                    Theme.of(context).textTheme.caption.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: PopupMenuButton(
                  color: Theme.of(context).brightness ==
                      Brightness.light
                      ? Theme.of(context).canvasColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  onSelected: (value) {
                    if (value == 1) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (_) => SecurityDetailScreen(
                          id: element.id,
                          symbol: element.symbol,
                        ),
                      ));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmAlert(
                              title: 'Remove from watchlist',
                              content:
                              'Remove  ${element.symbol} (${element.name}) from watchlist?',
                              onYes: () {
                                WatchlistModel()
                                    .deleteWatchlist(element.id);
                                Navigator.of(context).pop();
                              },
                            );
                          });
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.short_text,
                              color: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .color,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('View Security Detail'),
                          ],
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .color,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Remove from Watchlist'),
                          ],
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                        ),
                      ),
                    ];
                  },
                ),
              ),
            );
          }).toList(),
        )
            : Container(
            height: MediaQuery.of(context).size.height * 0.33,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark,
                  size: 36.0,
                  color: Theme.of(context).textTheme.caption.color,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Nothing found on your Watchlist.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .caption
                        .color,
                  ),
                ),
              ],
            ))
            : SizedBox.shrink(),
        //for offline status
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
