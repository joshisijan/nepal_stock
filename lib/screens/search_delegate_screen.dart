import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepal_stock/models/portfolio_model.dart';
import 'package:nepal_stock/models/watchlist_model.dart';
import 'package:nepal_stock/reuseables/confirm_alert.dart';
import 'package:nepal_stock/reuseables/custom_flutter_toast.dart';
import 'package:nepal_stock/screens/security_detail_screen.dart';
import 'package:nepal_stock/styles/colors.dart';

class SearchDelegateScreen extends SearchDelegate {
  final List<dynamic> companies;
  final int typeInt; // 0 default 1 for portfolio and 2 for watchlist
  final double paddingTop;

  SearchDelegateScreen(
      {@required this.companies, this.typeInt = 0, this.paddingTop = 50.0});

  TextEditingController _numberController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  FocusNode _numberFocus = FocusNode();
  FocusNode _priceFocus = FocusNode();
  var formKey = GlobalKey<FormState>();

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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (item, index) {
          return Container(
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.symmetric(vertical: 2.0),
            child: ListTile(
              isThreeLine: true,
              dense: true,
              title: Text(
                companies[index]['symbol'].toString(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                companies[index]['securityName'].toString(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).textTheme.caption.color.withAlpha(200),
                ),
                onPressed: () {
                  if (typeInt == 0) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Add to'),
                            content: Container(
                              height: 20.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: Text('Add to Portfolio'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else if (typeInt == 1) {
                    showPortfolioDialogue(
                      context: context,
                      data: companies[index],
                      formKey: formKey,
                      numberController: _numberController,
                      numberFocus: _numberFocus,
                      priceController: _priceController,
                      priceFocus: _priceFocus,
                    );
                  } else if (typeInt == 2) {
                    showWatchlistDialogue(context, companies[index]);
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
            ),
          );
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        itemCount: result.length,
        itemBuilder: (item, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 2.0),
            color: Theme.of(context).cardColor,
            child: ListTile(
              dense: true,
              isThreeLine: true,
              title: Text(
                result[index]['symbol'].toString(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                result[index]['securityName'].toString(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).textTheme.caption.color.withAlpha(200),
                ),
                onPressed: () {
                  if (typeInt == 0) {
                  } else if (typeInt == 1) {
                    showPortfolioDialogue(
                      context: context,
                      data: result[index],
                      formKey: formKey,
                      numberController: _numberController,
                      numberFocus: _numberFocus,
                      priceController: _priceController,
                      priceFocus: _priceFocus,
                    );
                  } else if (typeInt == 2) {
                    showWatchlistDialogue(context, result[index]);
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
            ),
          );
        },
      ),
    );
  }

  // add portfolio function

  addPortfolio(PortfolioModel portfolio, BuildContext context, GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      try {
        await PortfolioModel().insertPortfolio(portfolio);
        Navigator.pop(context);
        CustomFlutterToast().showToast(
            'Added to your Portfolio', Icons.view_stream, paddingTop, context);
      } catch (e) {
        print('error while adding portfolio\n' + e.toString());
      }
    }
  }

  // show portfolio dialogue function
  showPortfolioDialogue({
    BuildContext context,
    Map<String, dynamic> data,
    TextEditingController numberController,
    TextEditingController priceController,
    FocusNode numberFocus,
    FocusNode priceFocus,
    Key formKey,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          numberController.text = '';
          priceController.text = '';
          return ConfirmAlert(
            title: 'Add to Portfolio',
            haveMoreContent: true,
            moreContent: Container(
              height: 200.0,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Text(
                      data['symbol'],
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Theme.of(context).textTheme.subtitle1.color,
                          ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      data['securityName'],
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.subtitle1.color,
                          ),
                    ),
                    Divider(),
                    Text(
                      'Number of Shares',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.subtitle1.color,
                          ),
                    ),
                    TextFormField(
                      controller: numberController,
                      textInputAction: TextInputAction.next,
                      focusNode: numberFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        signed: false,
                      ),
                      autofocus: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1.color.withAlpha(200),
                        ),
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(priceFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Number of shares is required.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Price (Rs.)',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.subtitle1.color,
                          ),
                    ),
                    TextFormField(
                      controller: priceController,
                      textInputAction: TextInputAction.done,
                      focusNode: priceFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        addPortfolio(
                            PortfolioModel(
                              id: data['id'].toString(),
                              name: data['securityName'],
                              symbol: data['symbol'],
                              quantity: int.parse(numberController.text),
                              price: double.parse(priceController.text),
                            ),
                            context, formKey);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Price of shares is required.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: '0.0',
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1.color.withAlpha(200),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ),
            onYes: () {
              addPortfolio(
                  PortfolioModel(
                    id: data['id'].toString(),
                    name: data['securityName'],
                    symbol: data['symbol'],
                    quantity: int.parse(numberController.text),
                    price: double.parse(priceController.text),
                  ),
                  context, formKey);
            },
            onCancel: () {
              numberController.text = '';
              priceController.text = '';
            },
          );
        });
  }

  showWatchlistDialogue(BuildContext context, Map<String, dynamic> watchlist) {
    WatchlistModel().checkExists(watchlist['id']).then((value) {
      if (value == true) {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmAlert(
              title: 'Already in Watchlist',
              content:
                  '${watchlist['symbol']} (${watchlist['securityName']}) is already in your watchlist.',
              onYes: () {
                Navigator.pop(context);
              },
              showNo: false,
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmAlert(
              title: 'Add to Watchlist',
              content:
                  'Add ${watchlist['symbol']} (${watchlist['securityName']}) to watchlist?',
              onYes: () async {
                await WatchlistModel().insertWatchlist(WatchlistModel(
                  id: watchlist['id'].toString(),
                  symbol: watchlist['symbol'].toString(),
                  name: watchlist['securityName'].toString(),
                ));
                Navigator.pop(context);
                CustomFlutterToast().showToast(
                    'Added to Watchlist', Icons.bookmark, paddingTop, context);
              },
            );
          },
        );
      }
    });
  }

  @override
  // TODO: implement searchFieldStyle
  TextStyle get searchFieldStyle => TextStyle(
        color: kColorWhite2.withAlpha(200),
      );
}
