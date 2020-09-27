import 'package:flutter/material.dart';
import 'package:nepal_stock/models/portfolio_model.dart';
import 'package:nepal_stock/models/stock_model.dart';
import 'package:nepal_stock/reuseables/add_button.dart';
import 'package:nepal_stock/reuseables/confirm_alert.dart';
import 'package:nepal_stock/screens/search_delegate_screen.dart';
import 'package:nepal_stock/styles/colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PortfolioScreen extends StatelessWidget {
  List<dynamic> companies;
  List<PortfolioModel> allPortfolio;
  @override
  Widget build(BuildContext context) {
    companies = context.select((StockModel stockModel) => stockModel.getCompanies());
    return Consumer<PortfolioModel>(
      builder: (context, watchlistConsumer, _){
        watchlistConsumer.setAllPortfolio();
        allPortfolio = watchlistConsumer.getAllPortfolio();
        return ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 32.0,
            ),
            Text(
              'My Portfolio',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
            AddButton(
              alignment: Alignment.centerRight,
              loading: companies.length > 0 ? false : true,
              onPressed: companies.length > 0 ? (){
                showSearch(context: context, delegate: SearchDelegateScreen(
                  companies: companies,
                  typeInt: 1,
                ));
              } : null,
            ),
            allPortfolio != null
                ? allPortfolio.length > 0
                ? Column(
              children: allPortfolio.map((element) {
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
                                  PortfolioModel()
                                      .deletePortfolio(element.portfolioId);
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
                    Icon(Icons.view_stream, size: 36.0,),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Nothing found on your Portfolio.',
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
